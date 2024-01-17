import { type Page, type Locator, expect } from '@playwright/test'
import ModulePage from "../module_page";

export default class RedsquarePage extends ModulePage {

    constructor(page: Page) {
        super(page, "/redsquare");
    }

    async openChat() {

    }

    async createNewTweet() {
        const newTweetButton = this.page.locator('#new-tweet');
        await newTweetButton.click()
        const tweetTextArea = this.page.locator('#post-tweet-textarea');
        await expect(tweetTextArea).toBeVisible();

        const tweetText = "Hello, this is a test tweet!";
        await tweetTextArea.fill(tweetText);

        const postTweetButton = this.page.locator('#post-tweet-button');
        await postTweetButton.click();


        await this.page.waitForTimeout(5000);

        const tweetTextElement = this.page.locator('.tweet-text', { hasText: tweetText });

        await expect(tweetTextElement).toBeVisible();
    }
}

