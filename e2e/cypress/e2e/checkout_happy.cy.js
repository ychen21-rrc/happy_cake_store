describe("Happy path - checkout success", () => {
  it("adds item to cart and places order", () => {
    cy.visit("/");

    // Use a real product name from your seed data
    cy.contains("Chocolate Lava Cake").click();
    cy.contains("Add to Cart").click();

    cy.visit("/cart");
    cy.contains("Proceed to Checkout").click();

    // Log in (make sure this account exists)
    cy.get("#user_email").type("test@test.com");
    cy.get("#user_password").type("password");
    cy.contains("Log in").click();

    // Fill in address
    cy.get("#address_street").type("123 Main St");
    cy.get("#address_city").type("Winnipeg");
    cy.get("#address_province_id").select("Manitoba");
    cy.get("#address_postal_code").type("R3C 0A1");

    cy.contains("Place Order").click();
    cy.contains("Order placed!");
  });
});
