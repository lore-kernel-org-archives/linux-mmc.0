From: Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH 2/2] mmc: bcm2835: print some informational messages during reset
Date: Wed, 14 Feb 2018 15:38:58 +0100
Message-ID: <57ff1e429a7fc12300a3cca0c5e9a637beed0d3a.1518619058.git.msuchanek@suse.de>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
In-Reply-To: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Michal Suchanek <msuchanek@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Julia Lawall <Julia.Lawall@lip6.fr>, linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The previous patch does reset during hardware error so make the reset
progress more visible.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 drivers/mmc/host/bcm2835.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index ce05fe72f865..4dde8b2b62a9 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -283,10 +283,14 @@ static void bcm2835_reset_internal(struct bcm2835_host *host)
 static void bcm2835_reset(struct mmc_host *mmc)
 {
 	struct bcm2835_host *host = mmc_priv(mmc);
+	struct device *dev = &host->pdev->dev;
 
-	if (host->dma_chan)
+	if (host->dma_chan) {
+		dev_info(dev, "tearing down dma");
 		dmaengine_terminate_sync(host->dma_chan);
+	}
 	host->dma_chan = NULL;
+	dev_info(dev, "resetting");
 	bcm2835_reset_internal(host);
 }
 
-- 
2.13.6
