From: yongd <yongd@marvell.com>
Subject: [PATCH 1/3] mmc: esdhc: enable polling to detect card by itself
Date: Fri, 28 Sep 2012 18:28:31 +0800
Message-ID: <1348828113-19668-2-git-send-email-yongd@marvell.com>
References: <1348828113-19668-1-git-send-email-yongd@marvell.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1348828113-19668-1-git-send-email-yongd@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Daniel Drake <dsd@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, Wilson Callan <wilson.callan@savantsystems.com>, Ben Dooks <ben-linux@fluff.org>
Cc: zhangfei.gao@marvell.com, kevin.liu@marvell.com, jlfu@marvell.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, yongd <yongd@marvell.com>
List-Id: linux-mmc@vger.kernel.org

In the current code logic, sdhci_add_host() will enable the polling
method (set MMC_CAP_NEEDS_POLL) for a removable card (MMC_CAP_
NONREMOVABLE is not set) whose host's internal card detection method
is disabled for some reason (SDHCI_QUIRK_BROKEN_CARD_DETECTION is set).

However, this is improper since we can have some other card detection
methods besides host internal card detection and polling method. For
example, if the card detection type is ESDHC_CD_GPIO (external gpio pin
for CD), we will keep SDHCI_QUIRK_BROKEN_CARD_DETECTION set. This is right.
But, just as above said, sdhci_add_host() will also enable polling for such
a card. This is redundant.

On the other hand, for the card with ESDHC_CD_NONE detection type(no CD, neither
controller nor gpio, so use polling), we currently rely on sdhci_add_host() to
enable polling for us.

Here proposed a solution for such an embarrassing case. 1st, this patch will
de-couple polling enabling with sdhci_add_host() by doing this in host driver
itself, just as some other vendors. 2nd, one more patch will remove such improper
MMC_CAP_NEEDS_POLL enabling in sdhci_add_host().

Change-Id: Ia7525009d8fd188e3f0169f225e4a76ff9e94b47
Signed-off-by: yongd <yongd@marvell.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index e23f813..f70079c 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -569,6 +569,7 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		break;
 
 	case ESDHC_CD_NONE:
+		host->mmc->caps = MMC_CAP_NEEDS_POLL;
 		break;
 	}
 
-- 
1.7.9.5
