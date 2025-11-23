describe("Unhappy path - checkout fails", () => {
  it("shows errors when address missing", () => {
    cy.visit("/checkout");
    cy.contains("Place Order").click();

    // Address validations triggered
    cy.contains("can't be blank");
  });
});
