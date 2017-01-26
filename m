From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 13/13] mmc: bcm2835: use bcm2835_read_wait_sdcmd in bcm2835_finish_command
Date: Fri, 27 Jan 2017 00:37:26 +0100
Message-ID: <1485473846-24537-14-git-send-email-kraxel@redhat.com>
References: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-rpi-kernel@lists.infradead.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, "maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." <bcm-kernel-feedback-list@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, "moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/mmc/host/bcm2835.c | 56 +---------------------------------------------
 1 file changed, 1 insertion(+), 55 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 82caddc..64a2334 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -152,7 +152,6 @@ struct bcm2835_host {
 	unsigned int		blocks;		/* remaining PIO blocks */
 	int			irq;		/* Device IRQ */
 
-	u32			cmd_quick_poll_retries;
 	u32			ns_per_fifo_word;
 
 	/* cached registers */
@@ -782,62 +781,10 @@ static void bcm2835_finish_command(struct bcm2835_host *host)
 	struct device *dev = &host->pdev->dev;
 	struct mmc_command *cmd = host->cmd;
 	u32 sdcmd;
-	u32 retries;
 
 	dev_dbg(dev, "finish_command(%x)\n", readl(host->ioaddr + SDCMD));
 
-	/* Poll quickly at first */
-
-	retries = host->cmd_quick_poll_retries;
-	if (!retries) {
-		/* Work out how many polls take 1us by timing 10us */
-		struct timeval start, now;
-		int us_diff;
-
-		retries = 1;
-		do {
-			int i;
-
-			retries *= 2;
-
-			do_gettimeofday(&start);
-
-			for (i = 0; i < retries; i++) {
-				cpu_relax();
-				sdcmd = readl(host->ioaddr + SDCMD);
-			}
-
-			do_gettimeofday(&now);
-			us_diff = (now.tv_sec - start.tv_sec) * 1000000 +
-				(now.tv_usec - start.tv_usec);
-		} while (us_diff < 10);
-
-		host->cmd_quick_poll_retries =
-			((retries * us_diff + 9) * CMD_DALLY_US) / 10 + 1;
-		retries = 1; /* We've already waited long enough this time */
-	}
-
-	retries = host->cmd_quick_poll_retries;
-	for (sdcmd = readl(host->ioaddr + SDCMD);
-	     (sdcmd & SDCMD_NEW_FLAG) && !(sdcmd & SDCMD_FAIL_FLAG) && retries;
-	     retries--) {
-		cpu_relax();
-		sdcmd = readl(host->ioaddr + SDCMD);
-	}
-
-	if (!retries) {
-		unsigned long wait_max;
-
-		/* Wait max 100 ms */
-		wait_max = jiffies + msecs_to_jiffies(100);
-		while (time_before(jiffies, wait_max)) {
-			usleep_range(1, 10);
-			sdcmd = readl(host->ioaddr + SDCMD);
-			if (!(sdcmd & SDCMD_NEW_FLAG) ||
-			    (sdcmd & SDCMD_FAIL_FLAG))
-				break;
-		}
-	}
+	sdcmd = bcm2835_read_wait_sdcmd(host, 100, true);
 
 	/* Check for errors */
 	if (sdcmd & SDCMD_NEW_FLAG) {
@@ -1435,7 +1382,6 @@ static int bcm2835_probe(struct platform_device *pdev)
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
 	host->pdev = pdev;
-	host->cmd_quick_poll_retries = 0;
 	host->pio_timeout = msecs_to_jiffies(500);
 	host->pio_limit = 1;
 	host->max_delay = 1; /* Warn if over 1ms */
-- 
1.8.3.1
