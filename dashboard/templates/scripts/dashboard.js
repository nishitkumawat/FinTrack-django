document.addEventListener("DOMContentLoaded", function () {
  document
    .getElementById("addItemButton")
    .addEventListener("click", function () {
      const dropdown = document.getElementById("itemsDropdown");
      const selectedItem = dropdown.options[dropdown.selectedIndex].text;
      const selectedQuantity = document.getElementById("billquantity").value;
      const selectedPrice = document.getElementById("billprice").value;

      if (dropdown.selectedIndex !== 0) {
        const listItem = document.createElement("li");
        listItem.className = "list-group-item";
        listItem.textContent = selectedItem;

        document.getElementById("itemList").appendChild(listItem);
        updateHiddenInput();
      } else {
        alert("Please select an item to add.");
      }
    });

  function updateHiddenInput() {
    const items = [];
    document.querySelectorAll("#itemList li").forEach((li) => {
      items.push(li.textContent);
    });
    x = "";
    for (let i = 0; i < items.length; i++) {
      x += items[i] + "||";
    }
    document.getElementById("selectedItemsInput").value = x;
  }
});
document.addEventListener("DOMContentLoaded", function () {
  const sidebar = document.getElementById("sidebarMenu");
  const sidebarLinks = document.querySelectorAll(".sidebar .nav-link");

  sidebarLinks.forEach((link) => {
    link.addEventListener("click", function () {
      // Check screen size
      if (window.innerWidth <= 768) {
        const collapseInstance = bootstrap.Collapse.getInstance(sidebar);
        if (collapseInstance) {
          collapseInstance.hide(); // Collapse the sidebar
        }
      }
    });
  });
});

function onLoadMethod() {
  inputField = document.getElementById("company_name");
  if (inputField.value.trim() == "") {
    document.getElementById("tab1-link").classList.remove("active");
    document.getElementById("tab1").classList.remove("active");
    document.getElementById("tab6-link").classList.add("active");
    document.getElementById("tab6").classList.add("active");
    document.getElementById("tab1-link").classList.add("d-none");
    document.getElementById("tab2-link").classList.add("d-none");
    document.getElementById("tab3-link").classList.add("d-none");
    document.getElementById("tab4-link").classList.add("d-none");
    document.getElementById("tab5-link").classList.add("d-none");
  }
}

function addItem() {
  let itemId = document.getElementById("itemId").value;
  let itemName = document.getElementById("itemName").value;
  let itemQuantity = document.getElementById("itemQuantity").value;
  let purchasePrice = document.getElementById("purchasePrice").value;

  if (!itemId || !itemName || !itemQuantity || !purchasePrice) {
    alert("Please fill all fields!");
    return;
  }

  let table = document.getElementById("inventoryTable");

  let newRow = table.insertRow();

  newRow.innerHTML = `
                <td>${itemId}</td>
                <td>${itemName}</td>
                <td>${itemQuantity}</td>
                <td>${purchasePrice}</td>
                <td>
                  <button class="btn btn-success btn-sm" onclick="openEditModal(this)">Edit</button>
                  <button class="btn btn-danger btn-sm" onclick="deleteItem(this)">Delete</button>
                </td>

            `;

  document.getElementById("itemId").value = "";
  document.getElementById("itemName").value = "";
  document.getElementById("itemQuantity").value = "";
  document.getElementById("purchasePrice").value = "";
  tableJson();
}

function deleteItem(button) {
  button.closest("tr").remove();
}

function openEditModal(button) {
  let row = button.closest("tr");

  let itemId = row.cells[0].innerText;
  let itemName = row.cells[1].innerText;
  let purchasePrice = row.cells[3].innerText;

  document.getElementById("editItemId").value = itemId;
  document.getElementById("editItemName").value = itemName;
  document.getElementById("editPurchasePrice").value = purchasePrice;

  var myModal = new bootstrap.Modal(document.getElementById("editItemModal"));
  myModal.show();
}

function saveChanges() {
  let itemId = document.getElementById("editItemId").value;
  let newName = document.getElementById("editItemName").value;
  let newPrice = document.getElementById("editPurchasePrice").value;

  let table = document.getElementById("inventoryTable");
  for (let row of table.rows) {
    if (row.cells[0].innerText === itemId) {
      row.cells[1].innerText = newName;
      row.cells[3].innerText = newPrice;
      break;
    }
  }

  var modal = bootstrap.Modal.getInstance(
    document.getElementById("editItemModal")
  );
  modal.hide();
  tableInventory();
  handleAction("updateInventory");
}

function handleAction(action) {
  fetch("/dashboard/handle-action/", {
    method: "POST",
    headers: {
      "X-CSRFToken": document
        .querySelector('meta[name="csrf-token"]')
        .getAttribute("content"),
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ action: action }),
  })
    .then((response) => response.json())
    .then((data) => alert(data.message))
    .catch((error) => console.error("Error:", error));
}

function tableInventory() {
  tableData = "[";
  let table = document.getElementById("inventoryTable");
  for (let row of table.rows) {
    tableData += `${row.cells[0].innerText}|${row.cells[1].innerText}|${row.cells[2].innerText}|${row.cells[3].innerText},`;
  }
  document.getElementById("table_data").value = tableData + "]";
  console.log(document.getElementById("table_data").value);
  return document.getElementById("table_data").value;
}
