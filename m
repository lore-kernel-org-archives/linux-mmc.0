From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 01/13] mmc: bcm2835: add bcm2835_read_wait_sdcmd
Date: Fri, 27 Jan 2017 00:37:14 +0100
Message-ID: <1485473846-24537-2-git-send-email-kraxel@redhat.com>
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
 drivers/mmc/host/bcm2835.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 9744517..ceee4cf 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -609,6 +609,36 @@ static void bcm2835_prepare_data(struct bcm2835_host *host,
 	writel(data->blocks, host->ioaddr + SDHBLC);
 }
 
+static u32 bcm2835_read_wait_sdcmd(struct bcm2835_host *host, u32 timeout,
+				   bool check_fail)
+{
+	struct device *dev = &host->pdev->dev;
+	unsigned long start = jiffies;
+	unsigned long fastpoll = start + usecs_to_jiffies(10);
+	unsigned long end = start + msecs_to_jiffies(timeout);
+	u32 value;
+
+	for (;;) {
+		value = readl(host->ioaddr + SDCMD);
+		if (!(value & SDCMD_NEW_FLAG))
+			break;
+		if (check_fail && (value & SDCMD_FAIL_FLAG))
+			break;
+		if (time_after(jiffies, end)) {
+			dev_err(dev, "%s: timeout (%d us)\n",
+				__func__, timeout);
+			break;
+		}
+
+		/* if it takes longer reduce poll interval */
+		if (time_after(jiffies, fastpoll))
+			udelay(10);
+		else
+			cpu_relax();
+	}
+	return value;
+}
+
 bool bcm2835_send_command(struct bcm2835_host *host,
 			  struct mmc_command *cmd)
 {
-- 
1.8.3.1
