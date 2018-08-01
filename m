From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH 08/40] soc/tegra: pmc: Use X macro to generate IO pad tables
Date: Wed, 1 Aug 2018 19:31:58 +0300
Message-ID: <1533141150-10511-9-git-send-email-avienamo@nvidia.com>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Refactor the IO pad tables into macro tables so that they can be reused
to generate pinctrl pin descriptors. Also add a name field which is
needed by pinctrl.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 233 ++++++++++++++++++++++++++----------------------
 1 file changed, 127 insertions(+), 106 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 784c182..38cb915 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -137,6 +137,7 @@ struct tegra_io_pad_soc {
 	enum tegra_io_pad id;
 	unsigned int dpd;
 	unsigned int voltage;
+	const char *name;
 };
 
 struct tegra_pmc_regs {
@@ -1696,37 +1697,49 @@ static const u8 tegra124_cpu_powergates[] = {
 	TEGRA_POWERGATE_CPU3,
 };
 
+#define TEGRA_IO_PAD(_id, _dpd, _voltage, _name)	\
+	((struct tegra_io_pad_soc) {			\
+		.id	= (_id),			\
+		.dpd	= (_dpd),			\
+		.voltage = (_voltage),			\
+		.name	= (_name),			\
+	})
+
+#define TEGRA124_IO_PAD_TABLE(_pad)					\
+	/* .id                          .dpd    .voltage  .name	*/	\
+	_pad(TEGRA_IO_PAD_AUDIO,	17,	UINT_MAX, "audio"),	\
+	_pad(TEGRA_IO_PAD_BB,		15,	UINT_MAX, "bb"),	\
+	_pad(TEGRA_IO_PAD_CAM,		36,	UINT_MAX, "cam"),	\
+	_pad(TEGRA_IO_PAD_COMP,		22,	UINT_MAX, "comp"),	\
+	_pad(TEGRA_IO_PAD_CSIA,		0,	UINT_MAX, "csia"),	\
+	_pad(TEGRA_IO_PAD_CSIB,		1,	UINT_MAX, "csb"),	\
+	_pad(TEGRA_IO_PAD_CSIE,		44,	UINT_MAX, "cse"),	\
+	_pad(TEGRA_IO_PAD_DSI,		2,	UINT_MAX, "dsi"),	\
+	_pad(TEGRA_IO_PAD_DSIB,		39,	UINT_MAX, "dsib"),	\
+	_pad(TEGRA_IO_PAD_DSIC,		40,	UINT_MAX, "dsic"),	\
+	_pad(TEGRA_IO_PAD_DSID,		41,	UINT_MAX, "dsid"),	\
+	_pad(TEGRA_IO_PAD_HDMI,		28,	UINT_MAX, "hdmi"),	\
+	_pad(TEGRA_IO_PAD_HSIC,		19,	UINT_MAX, "hsic"),	\
+	_pad(TEGRA_IO_PAD_HV,		38,	UINT_MAX, "hv"),	\
+	_pad(TEGRA_IO_PAD_LVDS,		57,	UINT_MAX, "lvds"),	\
+	_pad(TEGRA_IO_PAD_MIPI_BIAS,	3,	UINT_MAX, "mipi-bias"),	\
+	_pad(TEGRA_IO_PAD_NAND,		13,	UINT_MAX, "nand"),	\
+	_pad(TEGRA_IO_PAD_PEX_BIAS,	4,	UINT_MAX, "pex-bias"),	\
+	_pad(TEGRA_IO_PAD_PEX_CLK1,	5,	UINT_MAX, "pex-clk1"),	\
+	_pad(TEGRA_IO_PAD_PEX_CLK2,	6,	UINT_MAX, "pex-clk2"),	\
+	_pad(TEGRA_IO_PAD_PEX_CNTRL,	32,	UINT_MAX, "pex-cntrl"),	\
+	_pad(TEGRA_IO_PAD_SDMMC1,	33,	UINT_MAX, "sdmmc1"),	\
+	_pad(TEGRA_IO_PAD_SDMMC3,	34,	UINT_MAX, "sdmmc3"),	\
+	_pad(TEGRA_IO_PAD_SDMMC4,	35,	UINT_MAX, "sdmmc4"),	\
+	_pad(TEGRA_IO_PAD_SYS_DDC,	58,	UINT_MAX, "sys_ddc"),	\
+	_pad(TEGRA_IO_PAD_UART,		14,	UINT_MAX, "uart"),	\
+	_pad(TEGRA_IO_PAD_USB0,		9,	UINT_MAX, "usb0"),	\
+	_pad(TEGRA_IO_PAD_USB1,		10,	UINT_MAX, "usb1"),	\
+	_pad(TEGRA_IO_PAD_USB2,		11,	UINT_MAX, "usb2"),	\
+	_pad(TEGRA_IO_PAD_USB_BIAS,	12,	UINT_MAX, "usb_bias")
+
 static const struct tegra_io_pad_soc tegra124_io_pads[] = {
-	{ .id = TEGRA_IO_PAD_AUDIO, .dpd = 17, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_BB, .dpd = 15, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CAM, .dpd = 36, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_COMP, .dpd = 22, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSIA, .dpd = 0, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSIB, .dpd = 1, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSIE, .dpd = 44, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DSI, .dpd = 2, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DSIB, .dpd = 39, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DSIC, .dpd = 40, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DSID, .dpd = 41, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_HDMI, .dpd = 28, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_HSIC, .dpd = 19, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_HV, .dpd = 38, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_LVDS, .dpd = 57, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_MIPI_BIAS, .dpd = 3, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_NAND, .dpd = 13, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_BIAS, .dpd = 4, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_CLK1, .dpd = 5, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_CLK2, .dpd = 6, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_CNTRL, .dpd = 32, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_SDMMC1, .dpd = 33, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_SDMMC3, .dpd = 34, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_SDMMC4, .dpd = 35, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_SYS_DDC, .dpd = 58, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_UART, .dpd = 14, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_USB0, .dpd = 9, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_USB1, .dpd = 10, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_USB2, .dpd = 11, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_USB_BIAS, .dpd = 12, .voltage = UINT_MAX },
+	TEGRA124_IO_PAD_TABLE(TEGRA_IO_PAD)
 };
 
 static const struct tegra_pmc_soc tegra124_pmc_soc = {
@@ -1778,45 +1791,49 @@ static const u8 tegra210_cpu_powergates[] = {
 	TEGRA_POWERGATE_CPU3,
 };
 
+#define TEGRA210_IO_PAD_TABLE(_pad)					   \
+	/*   .id                        .dpd     .voltage  .name */	   \
+	_pad(TEGRA_IO_PAD_AUDIO,       17,	 5,	   "audio"),	   \
+	_pad(TEGRA_IO_PAD_AUDIO_HV,    61,	 18,	   "audio-hv"),	   \
+	_pad(TEGRA_IO_PAD_CAM,	       36,	 10,	   "cam"),	   \
+	_pad(TEGRA_IO_PAD_CSIA,	       0,	 UINT_MAX, "csia"),	   \
+	_pad(TEGRA_IO_PAD_CSIB,	       1,	 UINT_MAX, "csib"),	   \
+	_pad(TEGRA_IO_PAD_CSIC,	       42,	 UINT_MAX, "csic"),	   \
+	_pad(TEGRA_IO_PAD_CSID,	       43,	 UINT_MAX, "csid"),	   \
+	_pad(TEGRA_IO_PAD_CSIE,	       44,	 UINT_MAX, "csie"),	   \
+	_pad(TEGRA_IO_PAD_CSIF,	       45,	 UINT_MAX, "csif"),	   \
+	_pad(TEGRA_IO_PAD_DBG,	       25,	 19,	   "dbg"),	   \
+	_pad(TEGRA_IO_PAD_DEBUG_NONAO, 26,	 UINT_MAX, "debug-nonao"), \
+	_pad(TEGRA_IO_PAD_DMIC,	       50,	 20,	   "dmic"),	   \
+	_pad(TEGRA_IO_PAD_DP,	       51,	 UINT_MAX, "dp"),	   \
+	_pad(TEGRA_IO_PAD_DSI,	       2,	 UINT_MAX, "dsi"),	   \
+	_pad(TEGRA_IO_PAD_DSIB,	       39,	 UINT_MAX, "dsib"),	   \
+	_pad(TEGRA_IO_PAD_DSIC,	       40,	 UINT_MAX, "dsic"),	   \
+	_pad(TEGRA_IO_PAD_DSID,	       41,	 UINT_MAX, "dsid"),	   \
+	_pad(TEGRA_IO_PAD_EMMC,	       35,	 UINT_MAX, "emmc"),	   \
+	_pad(TEGRA_IO_PAD_EMMC2,       37,	 UINT_MAX, "emmc2"),	   \
+	_pad(TEGRA_IO_PAD_GPIO,	       27,	 21,	   "gpio"),	   \
+	_pad(TEGRA_IO_PAD_HDMI,	       28,	 UINT_MAX, "hdmi"),	   \
+	_pad(TEGRA_IO_PAD_HSIC,	       19,	 UINT_MAX, "hsic"),	   \
+	_pad(TEGRA_IO_PAD_LVDS,	       57,	 UINT_MAX, "lvds"),	   \
+	_pad(TEGRA_IO_PAD_MIPI_BIAS,   3,	 UINT_MAX, "mipi-bias"),   \
+	_pad(TEGRA_IO_PAD_PEX_BIAS,    4,	 UINT_MAX, "pex-bias"),    \
+	_pad(TEGRA_IO_PAD_PEX_CLK1,    5,	 UINT_MAX, "pex-clk1"),    \
+	_pad(TEGRA_IO_PAD_PEX_CLK2,    6,	 UINT_MAX, "pex-clk2"),    \
+	_pad(TEGRA_IO_PAD_PEX_CNTRL,   UINT_MAX, 11,	   "pex-cntrl"),   \
+	_pad(TEGRA_IO_PAD_SDMMC1,      33,	 12,	   "sdmmc1"),	   \
+	_pad(TEGRA_IO_PAD_SDMMC3,      34,	 13,	   "sdmmc3"),	   \
+	_pad(TEGRA_IO_PAD_SPI,	       46,	 22,	   "spi"),	   \
+	_pad(TEGRA_IO_PAD_SPI_HV,      47,	 23,	   "spi-hv"),	   \
+	_pad(TEGRA_IO_PAD_UART,	       14,	 2,	   "uart"),	   \
+	_pad(TEGRA_IO_PAD_USB0,	       9,	 UINT_MAX, "usb0"),	   \
+	_pad(TEGRA_IO_PAD_USB1,	       10,	 UINT_MAX, "usb1"),	   \
+	_pad(TEGRA_IO_PAD_USB2,	       11,	 UINT_MAX, "usb2"),	   \
+	_pad(TEGRA_IO_PAD_USB3,	       18,	 UINT_MAX, "usb3"),	   \
+	_pad(TEGRA_IO_PAD_USB_BIAS,    12,	 UINT_MAX, "usb-bias")
+
 static const struct tegra_io_pad_soc tegra210_io_pads[] = {
-	{ .id = TEGRA_IO_PAD_AUDIO, .dpd = 17, .voltage = 5 },
-	{ .id = TEGRA_IO_PAD_AUDIO_HV, .dpd = 61, .voltage = 18 },
-	{ .id = TEGRA_IO_PAD_CAM, .dpd = 36, .voltage = 10 },
-	{ .id = TEGRA_IO_PAD_CSIA, .dpd = 0, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSIB, .dpd = 1, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSIC, .dpd = 42, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSID, .dpd = 43, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSIE, .dpd = 44, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSIF, .dpd = 45, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DBG, .dpd = 25, .voltage = 19 },
-	{ .id = TEGRA_IO_PAD_DEBUG_NONAO, .dpd = 26, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DMIC, .dpd = 50, .voltage = 20 },
-	{ .id = TEGRA_IO_PAD_DP, .dpd = 51, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DSI, .dpd = 2, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DSIB, .dpd = 39, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DSIC, .dpd = 40, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DSID, .dpd = 41, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_EMMC, .dpd = 35, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_EMMC2, .dpd = 37, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_GPIO, .dpd = 27, .voltage = 21 },
-	{ .id = TEGRA_IO_PAD_HDMI, .dpd = 28, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_HSIC, .dpd = 19, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_LVDS, .dpd = 57, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_MIPI_BIAS, .dpd = 3, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_BIAS, .dpd = 4, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_CLK1, .dpd = 5, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_CLK2, .dpd = 6, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_CNTRL, .dpd = UINT_MAX, .voltage = 11 },
-	{ .id = TEGRA_IO_PAD_SDMMC1, .dpd = 33, .voltage = 12 },
-	{ .id = TEGRA_IO_PAD_SDMMC3, .dpd = 34, .voltage = 13 },
-	{ .id = TEGRA_IO_PAD_SPI, .dpd = 46, .voltage = 22 },
-	{ .id = TEGRA_IO_PAD_SPI_HV, .dpd = 47, .voltage = 23 },
-	{ .id = TEGRA_IO_PAD_UART, .dpd = 14, .voltage = 2 },
-	{ .id = TEGRA_IO_PAD_USB0, .dpd = 9, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_USB1, .dpd = 10, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_USB2, .dpd = 11, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_USB3, .dpd = 18, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_USB_BIAS, .dpd = 12, .voltage = UINT_MAX },
+	TEGRA210_IO_PAD_TABLE(TEGRA_IO_PAD)
 };
 
 static const struct tegra_pmc_soc tegra210_pmc_soc = {
@@ -1835,45 +1852,49 @@ static const struct tegra_pmc_soc tegra210_pmc_soc = {
 	.setup_irq_polarity = tegra20_pmc_setup_irq_polarity,
 };
 
+#define TEGRA186_IO_PAD_TABLE(_pad)					     \
+	/*   .id                        .dpd      .voltage  .name */	     \
+	_pad(TEGRA_IO_PAD_CSIA,		0,	  UINT_MAX, "csia"),	     \
+	_pad(TEGRA_IO_PAD_CSIB,		1,	  UINT_MAX, "csib"),	     \
+	_pad(TEGRA_IO_PAD_DSI,		2,	  UINT_MAX, "dsi"),	     \
+	_pad(TEGRA_IO_PAD_MIPI_BIAS,	3,	  UINT_MAX, "mipi-bias"),    \
+	_pad(TEGRA_IO_PAD_PEX_CLK_BIAS,	4,	  UINT_MAX, "pex-clk-bias"), \
+	_pad(TEGRA_IO_PAD_PEX_CLK3,	5,	  UINT_MAX, "pex-clk3"),     \
+	_pad(TEGRA_IO_PAD_PEX_CLK2,	6,	  UINT_MAX, "pex-clk2"),     \
+	_pad(TEGRA_IO_PAD_PEX_CLK1,	7,	  UINT_MAX, "pex-clk1"),     \
+	_pad(TEGRA_IO_PAD_USB0,		9,	  UINT_MAX, "usb0"),	     \
+	_pad(TEGRA_IO_PAD_USB1,		10,	  UINT_MAX, "usb1"),	     \
+	_pad(TEGRA_IO_PAD_USB2,		11,	  UINT_MAX, "usb2"),	     \
+	_pad(TEGRA_IO_PAD_USB_BIAS,	12,	  UINT_MAX, "usb-bias"),     \
+	_pad(TEGRA_IO_PAD_UART,		14,	  UINT_MAX, "uart"),	     \
+	_pad(TEGRA_IO_PAD_AUDIO,	17,	  UINT_MAX, "audio"),	     \
+	_pad(TEGRA_IO_PAD_HSIC,		19,	  UINT_MAX, "hsic"),	     \
+	_pad(TEGRA_IO_PAD_DBG,		25,	  UINT_MAX, "dbg"),	     \
+	_pad(TEGRA_IO_PAD_HDMI_DP0,	28,	  UINT_MAX, "hdmi-dp0"),     \
+	_pad(TEGRA_IO_PAD_HDMI_DP1,	29,	  UINT_MAX, "hdmi-dp1"),     \
+	_pad(TEGRA_IO_PAD_PEX_CNTRL,	32,	  UINT_MAX, "pex-cntrl"),    \
+	_pad(TEGRA_IO_PAD_SDMMC2_HV,	34,	  5,	    "sdmmc2-hv"),    \
+	_pad(TEGRA_IO_PAD_SDMMC4,	36,	  UINT_MAX, "sdmmc4"),	     \
+	_pad(TEGRA_IO_PAD_CAM,		38,	  UINT_MAX, "cam"),	     \
+	_pad(TEGRA_IO_PAD_DSIB,		40,	  UINT_MAX, "dsib"),	     \
+	_pad(TEGRA_IO_PAD_DSIC,		41,	  UINT_MAX, "dsic"),	     \
+	_pad(TEGRA_IO_PAD_DSID,		42,	  UINT_MAX, "dsid"),	     \
+	_pad(TEGRA_IO_PAD_CSIC,		43,	  UINT_MAX, "csic"),	     \
+	_pad(TEGRA_IO_PAD_CSID,		44,	  UINT_MAX, "csid"),	     \
+	_pad(TEGRA_IO_PAD_CSIE,		45,	  UINT_MAX, "csie"),	     \
+	_pad(TEGRA_IO_PAD_CSIF,		46,	  UINT_MAX, "csif"),	     \
+	_pad(TEGRA_IO_PAD_SPI,		47,	  UINT_MAX, "spi"),	     \
+	_pad(TEGRA_IO_PAD_UFS,		49,	  UINT_MAX, "ufs"),	     \
+	_pad(TEGRA_IO_PAD_DMIC_HV,	52,	  2,	    "dmic-hv"),	     \
+	_pad(TEGRA_IO_PAD_EDP,		53,	  UINT_MAX, "edp"),	     \
+	_pad(TEGRA_IO_PAD_SDMMC1_HV,	55,	  4,	    "sdmmc1-hv"),    \
+	_pad(TEGRA_IO_PAD_SDMMC3_HV,	56,	  6,	    "sdmmc3-hv"),    \
+	_pad(TEGRA_IO_PAD_CONN,		60,	  UINT_MAX, "conn"),	     \
+	_pad(TEGRA_IO_PAD_AUDIO_HV,	61,	  1,	    "audio-hv"),     \
+	_pad(TEGRA_IO_PAD_AO_HV,	UINT_MAX, 0,	    "ao-hv")
+
 static const struct tegra_io_pad_soc tegra186_io_pads[] = {
-	{ .id = TEGRA_IO_PAD_CSIA, .dpd = 0, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSIB, .dpd = 1, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DSI, .dpd = 2, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_MIPI_BIAS, .dpd = 3, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_CLK_BIAS, .dpd = 4, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_CLK3, .dpd = 5, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_CLK2, .dpd = 6, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_CLK1, .dpd = 7, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_USB0, .dpd = 9, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_USB1, .dpd = 10, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_USB2, .dpd = 11, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_USB_BIAS, .dpd = 12, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_UART, .dpd = 14, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_AUDIO, .dpd = 17, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_HSIC, .dpd = 19, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DBG, .dpd = 25, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_HDMI_DP0, .dpd = 28, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_HDMI_DP1, .dpd = 29, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_PEX_CNTRL, .dpd = 32, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_SDMMC2_HV, .dpd = 34, .voltage = 5 },
-	{ .id = TEGRA_IO_PAD_SDMMC4, .dpd = 36, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CAM, .dpd = 38, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DSIB, .dpd = 40, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DSIC, .dpd = 41, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DSID, .dpd = 42, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSIC, .dpd = 43, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSID, .dpd = 44, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSIE, .dpd = 45, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_CSIF, .dpd = 46, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_SPI, .dpd = 47, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_UFS, .dpd = 49, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_DMIC_HV, .dpd = 52, .voltage = 2 },
-	{ .id = TEGRA_IO_PAD_EDP, .dpd = 53, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_SDMMC1_HV, .dpd = 55, .voltage = 4 },
-	{ .id = TEGRA_IO_PAD_SDMMC3_HV, .dpd = 56, .voltage = 6 },
-	{ .id = TEGRA_IO_PAD_CONN, .dpd = 60, .voltage = UINT_MAX },
-	{ .id = TEGRA_IO_PAD_AUDIO_HV, .dpd = 61, .voltage = 1 },
-	{ .id = TEGRA_IO_PAD_AO_HV, .dpd = UINT_MAX, .voltage = 0 },
+	TEGRA186_IO_PAD_TABLE(TEGRA_IO_PAD)
 };
 
 static const struct tegra_pmc_regs tegra186_pmc_regs = {
-- 
2.7.4
