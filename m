From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 02/13] mmc: bcm2835: use bcm2835_read_wait_sdcmd in bcm2835_send_command
Date: Fri, 27 Jan 2017 00:37:15 +0100
Message-ID: <1485473846-24537-3-git-send-email-kraxel@redhat.com>
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
 drivers/mmc/host/bcm2835.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index ceee4cf..ffb9140 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -645,7 +645,6 @@ bool bcm2835_send_command(struct bcm2835_host *host,
 	struct device *dev = &host->pdev->dev;
 	u32 sdcmd, sdhsts;
 	unsigned long timeout;
-	int delay;
 
 	WARN_ON(host->cmd);
 
@@ -660,26 +659,13 @@ bool bcm2835_send_command(struct bcm2835_host *host,
 			cmd->opcode, cmd->arg, cmd->flags);
 	}
 
-	/* Wait max 100 ms */
-	timeout = 10000;
-
-	while (readl(host->ioaddr + SDCMD) & SDCMD_NEW_FLAG) {
-		if (timeout == 0) {
-			dev_err(dev, "previous command never completed.\n");
-			bcm2835_dumpregs(host);
-			cmd->error = -EILSEQ;
-			tasklet_schedule(&host->finish_tasklet);
-			return false;
-		}
-		timeout--;
-		udelay(10);
-	}
-
-	delay = (10000 - timeout) / 100;
-	if (delay > host->max_delay) {
-		host->max_delay = delay;
-		dev_warn(dev, "controller hung for %d ms\n",
-			 host->max_delay);
+	sdcmd = bcm2835_read_wait_sdcmd(host, 100, false);
+	if (sdcmd & SDCMD_NEW_FLAG) {
+		dev_err(dev, "previous command never completed.\n");
+		bcm2835_dumpregs(host);
+		cmd->error = -EILSEQ;
+		tasklet_schedule(&host->finish_tasklet);
+		return false;
 	}
 
 	timeout = jiffies;
-- 
1.8.3.1
