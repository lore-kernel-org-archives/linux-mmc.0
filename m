From: Olliver Schinagl <oliver+list@schinagl.nl>
Subject: [PATCH v2] mmc: sunxi: fix timeout in sunxi_mmc_oclk_onoff
Date: Wed, 12 Aug 2015 14:37:18 +0200
Message-ID: <55CB3DFE.8060508@schinagl.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000306040805060401040005"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?B?RGF2aWQgTGFuemVuZMO2cmZlcg==?= <david.lanzendoerfer@o2s.ch>, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, Arnd Bergmann <arnd@arndb.de>, Peter Griffin <peter.griffin@linaro.org>, Michal Suchanek <hramrach@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

This is a multi-part message in MIME format.
--------------000306040805060401040005
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey all

A few months ago, Michal Suchanek submitted the attached patch fixing 
the gating timeout issue. Until recently, about v4.0.0 I hadn't noticed 
any issues and ran all boards from SD card.

Recently I upgraded to Hans's 4.2 tree where he added

mmc: sunxi: Don't start commands while the card is busy

which started to trigger the timeout very aggressively causing a pretty 
much unusable system.
While reverting the commands patch also removed the problem for some 
reason, that is of course not the real fix.

Applying Michal's patch on top of the commands patch appears to fix the 
issue on atleast the A20 Lime2.

Attached I have Michal's original patch, rebased to 4.2.0-rc5, with 
Hans's patch applied before hand.

Changed since v1
* Whitespace cleanup as suggested by Maxime Ripard, no functional 
changes from that patch

Olliver

--------------000306040805060401040005
Content-Type: text/x-patch;
 name="0001-mmc-sunxi-fix-timeout-in-sunxi_mmc_oclk_onoff.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-mmc-sunxi-fix-timeout-in-sunxi_mmc_oclk_onoff.patch"

>From bb0436dd5e2b3f021f8fcff2c2d25b87b48ab569 Mon Sep 17 00:00:00 2001
From: Michal Suchanek <hramrach@gmail.com>
Date: Sun, 24 May 2015 20:07:32 +0200
Subject: [PATCH 1/1] mmc: sunxi: fix timeout in sunxi_mmc_oclk_onoff

The 250ms timeout is too short.

On my system enabling the oclk takes under 50ms and disabling slightly
over 100ms when idle. Under load disabling the clock can take over
350ms.

This does not make mmc clock gating look like good option to have on
sunxi but the system should not crash with mmc clock gating enabled
nonetheless.

This patch sets the timeout to 750ms and adds debug prints which show
how long enabling/disabling the clock took so more data can be collected
from other systems.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
Signed-off-by: Olliver Schinagl <o.schinagl@ultimaker.com>
---
 drivers/mmc/host/sunxi-mmc.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index daa90b7..34d134c 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -210,6 +210,8 @@
 #define SDXC_IDMAC_DES0_CES	BIT(30) /* card error summary */
 #define SDXC_IDMAC_DES0_OWN	BIT(31) /* 1-idma owns it, 0-host owns it */
 
+#define SUNXI_OCLK_ONOFF_TIMEOUT 750
+
 struct sunxi_idma_des {
 	u32	config;
 	u32	buf_size;
@@ -615,7 +617,7 @@ static irqreturn_t sunxi_mmc_handle_manual_stop(int irq, void *dev_id)
 
 static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
 {
-	unsigned long expire = jiffies + msecs_to_jiffies(250);
+	unsigned long start, end;
 	u32 rval;
 	int ret;
 
@@ -629,6 +631,8 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
 	if (oclk_en)
 		rval |= SDXC_CARD_CLOCK_ON;
 
+	start = jiffies;
+	end = start + msecs_to_jiffies(SUNXI_OCLK_ONOFF_TIMEOUT);
 	mmc_writel(host, REG_CLKCR, rval);
 
 	rval = SDXC_START | SDXC_UPCLK_ONLY | SDXC_WAIT_PRE_OVER;
@@ -636,15 +640,29 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
 
 	do {
 		rval = mmc_readl(host, REG_CMDR);
-	} while (time_before(jiffies, expire) && (rval & SDXC_START));
+	} while (time_before(jiffies, end) && (rval & SDXC_START));
+	end = jiffies;
 
 	/* clear irq status bits set by the command */
 	mmc_writel(host, REG_RINTR,
 		   mmc_readl(host, REG_RINTR) & ~SDXC_SDIO_INTERRUPT);
 
 	if (rval & SDXC_START) {
-		dev_err(mmc_dev(host->mmc), "fatal err update clk timeout\n");
+		dev_err(mmc_dev(host->mmc),
+				"fatal err update oclk timeout. Could not %s in %ims.\n",
+				oclk_en ? "enable" : "disable",
+				jiffies_to_msecs(end - start));
 		return -EIO;
+	} else {
+		int msecs = jiffies_to_msecs(end - start);
+		const char *ing = oclk_en ? "enabling" : "disabling";
+
+		if ((msecs > 150) || (oclk_en && (msecs > 50)))
+			dev_warn(mmc_dev(host->mmc),
+				 "%s oclk took %ims", ing, msecs);
+		else
+			dev_dbg(mmc_dev(host->mmc),
+				"%s oclk took %ims", ing, msecs);
 	}
 
 	return 0;
-- 
2.1.4


--------------000306040805060401040005--
