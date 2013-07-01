From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Crash during reboot due to 7628774 "mmc: core: Handle card shutdown
 from mmc_bus"
Date: Mon, 01 Jul 2013 14:32:58 -0600
Message-ID: <51D1E77A.3010601@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

It looks like commit 7628774 "mmc: core: Handle card shutdown from
mmc_bus" causes a crash during "reboot" at least on Tegra platforms. The
issue appears to be in:

> static void mmc_bus_shutdown(struct device *dev)
> {
> 	struct mmc_driver *drv = to_mmc_driver(dev->driver);
> 	struct mmc_card *card = mmc_dev_to_card(dev);
> 	struct mmc_host *host = card->host;
> 	int ret;
> 
> 	drv->shutdown(card);

Since drv == NULL.

Is this expected (and hence there's a missing guard on that function
call), or is the root-cause some other issue?
