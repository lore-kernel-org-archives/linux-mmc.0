From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: [PATCH v3] mmc: sunxi: Handle the 'New Timing' mode
Date: Sat, 13 Aug 2016 18:41:45 +0200
Message-ID: <57af5f39.07961c0a.56b49.5cd2SMTPIN_ADDED_MISSING@gmr-mx.google.com>
Reply-To: moinejf-GANU6spQydw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCV6DL6LYMNBBOV6XW6QKGQEHMV6RWA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Some MMC devices as mmc2 in the A83T or mmc1 and mmc2 in the H3 have
a 'New Timing' mode.
When aware about this capability, and when this is possible (clock
rate great enough), the clock driver switches the MMC clock to the
'new mode', meaning that the phase delays are defined in the MMC
registers instead of in the clock registers.
To alert the MMC driver about this switch, the clock driver returns
the error code EPERM on calling clk_set_phase().

This patch makes the MMC driver to handle this returned code and to
activate or not the 'New Timing' mode on the MMC side.

Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
---
Some explanations:
In the old timing, the phase delays are set in the clock only
(that's why there is a function clk_set_phase() which is called from
the MMC side).
In the new timing, the delays are in the MMC register SDXC_REG_NTSR
only.
The new timing works only when the clock rate is greater or equal
to 50MHz.

There are 2 flags saying that the new timing is used:
- the bit 'mode select' in the clock register, and
- the bit 'new timing' in the MMC register.
Both bits must be set/reset at the same time, otherwise the device
does not work (tested with wifi and eMMC in H3 and A83T boards).
So, some synchronization must exist.

The previous versions was using a DT property for the MMC and a flag
in the clock driver. This did work with a correct configuration
on both sides, but experiment showed that it was easy to do an error.

The actual version asks for just a flag (and a rate) in the clock
driver and the synchronization is done by a specific error code.
It depends on my previous patch
 'clk: core: Force setting the phase delay when no change'.

The patch relative to the clock side is not included here.
It depends on 'which driver?'.
v3
- use an error code from the clock driver to enable/disable the
  'new timing'
v2
- use a DT property about the 'new timing' capability of
  the MMC device
---
 drivers/mmc/host/sunxi-mmc.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index ba647b7..d0ffe8b 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -64,6 +64,7 @@
 #define SDXC_REG_CBCR	(0x48) /* SMC CIU Byte Count Register */
 #define SDXC_REG_BBCR	(0x4C) /* SMC BIU Byte Count Register */
 #define SDXC_REG_DBGC	(0x50) /* SMC Debug Enable Register */
+#define SDXC_REG_NTSR	(0x5c) /* SMC NewTiming Set Register */
 #define SDXC_REG_HWRST	(0x78) /* SMC Card Hardware Reset for Register */
 #define SDXC_REG_DMAC	(0x80) /* SMC IDMAC Control Register */
 #define SDXC_REG_DLBA	(0x84) /* SMC IDMAC Descriptor List Base Addre */
@@ -171,6 +172,9 @@
 #define SDXC_SEND_AUTO_STOPCCSD		BIT(9)
 #define SDXC_CEATA_DEV_IRQ_ENABLE	BIT(10)
 
+/* NewTiming Set Register */
+#define SDXC_NEWMODE_ENABLE		BIT(31)
+
 /* IDMA controller bus mod bit field */
 #define SDXC_IDMAC_SOFT_RESET		BIT(0)
 #define SDXC_IDMAC_FIX_BURST		BIT(1)
@@ -218,8 +222,8 @@
 #define SDXC_CLK_50M_DDR_8BIT	4
 
 struct sunxi_mmc_clk_delay {
-	u32 output;
-	u32 sample;
+	u16 output;
+	u16 sample;
 };
 
 struct sunxi_idma_des {
@@ -721,8 +725,22 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 		return -EINVAL;
 	}
 
-	clk_set_phase(host->clk_sample, sclk_dly);
-	clk_set_phase(host->clk_output, oclk_dly);
+	ret = clk_set_phase(host->clk_sample, sclk_dly);
+
+	/*
+	 * EPERM is returned when the MMC clock is switched to the new mode.
+	 * In this mode, the phase delays are defined in the MMC register NTSR.
+	 * Actually, as the reset/boot values are fine enough, these delays are
+	 * not changed here.
+	 */
+	if (ret == -EPERM) {
+		mmc_writel(host, REG_NTSR,
+			   mmc_readl(host, REG_NTSR) | SDXC_NEWMODE_ENABLE);
+	} else {
+		mmc_writel(host, REG_NTSR,
+			   mmc_readl(host, REG_NTSR) & ~SDXC_NEWMODE_ENABLE);
+		clk_set_phase(host->clk_output, oclk_dly);
+	}
 
 	return sunxi_mmc_oclk_onoff(host, 1);
 }
-- 
2.9.2
