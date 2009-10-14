From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] mmc: au1xmmc: allow platforms to disable host capabilities
Date: Wed, 14 Oct 2009 09:38:06 +0200
Message-ID: <4AD57FDE.1040206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: linux-mmc@vger.kernel.org
Cc: Manuel Lauss <manuel.lauss@gmail.com>, Linux-MIPS <linux-mips@linux-mips.org>
List-Id: linux-mmc@vger.kernel.org


Although the hardware supports a 4/8bit SD interface and the driver
unconditionally advertises all hardware caps to the MMC core, not all
datalines may actually be wired up.  This patch introduces another
field to au1xmmc platform data allowing platforms to disable certain
advanced host controller features.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/include/asm/mach-au1x00/au1100_mmc.h |    1 +
 drivers/mmc/host/au1xmmc.c                     |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-au1x00/au1100_mmc.h b/arch/mips/include/asm/mach-au1x00/au1100_mmc.h
index c35e209..a674643 100644
--- a/arch/mips/include/asm/mach-au1x00/au1100_mmc.h
+++ b/arch/mips/include/asm/mach-au1x00/au1100_mmc.h
@@ -46,6 +46,7 @@ struct au1xmmc_platform_data {
 	int(*card_readonly)(void *mmc_host);
 	void(*set_power)(void *mmc_host, int state);
 	struct led_classdev *led;
+	unsigned long mask_host_caps;
 };

 #define SD0_BASE	0xB0600000
diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index 7534726..e2caf5a 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -1025,6 +1025,10 @@ static int __devinit au1xmmc_probe(struct platform_device *pdev)
 	} else
 		mmc->caps |= MMC_CAP_NEEDS_POLL;

+	/* platform may not be able to use all advertised caps */
+	if (host->platdata)
+		mmc->caps &= ~(host->platdata->mask_host_caps);
+
 	tasklet_init(&host->data_task, au1xmmc_tasklet_data,
 			(unsigned long)host);

-- 
1.6.5
