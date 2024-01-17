import { expect, test } from '@playwright/test';
import Redsquare from "../../src/mods/redsquare/redsquare_page";

test("Should load redsquare", async ({ page }) => {
    let redsquare = new Redsquare(page);
    await redsquare.goto();
    // await arcade.createChessGame();
});

test("Should create new tweets", async ({ page }) => {
    let redsquare = new Redsquare(page);
    await redsquare.goto();
    await redsquare.createNewTweet();
});
