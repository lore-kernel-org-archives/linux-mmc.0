From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v2] mmc: sdhci-msm: Add support for vendor capabilities registers
Date: Sat, 21 Mar 2015 16:50:17 +0200
Message-ID: <1426949417-5498-1-git-send-email-georgi.djakov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Some versions of this controller do not advertise their 3.0v and
8bit bus-width support capabilities. It is required to explicitly
set these capabilities for the specific controller versions.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
Changes since v1:
 * Converted to separate read, modify, write statements.
 * Slightly updated comment text.

 Tested on msm8916-mtp board.

 drivers/mmc/host/sdhci-msm.c |   31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 3d32ce896b09..b87f271ede29 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -41,6 +41,15 @@
 #define CORE_VENDOR_SPEC	0x10c
 #define CORE_CLK_PWRSAVE	BIT(1)
 
+#define CORE_MCI_VERSION		0x050
+#define CORE_VERSION_MAJOR_SHIFT	28
+#define CORE_VERSION_MAJOR_MASK		(0xf << CORE_VERSION_MAJOR_SHIFT)
+#define CORE_VERSION_MINOR_MASK		0xff
+
+#define CORE_VENDOR_SPEC_CAPABILITIES0	0x11c
+#define CORE_8_BIT_SUPPORT		BIT(18)
+#define CORE_3_0V_SUPPORT		BIT(25)
+
 #define CDR_SELEXT_SHIFT	20
 #define CDR_SELEXT_MASK		(0xf << CDR_SELEXT_SHIFT)
 #define CMUX_SHIFT_PHASE_SHIFT	24
@@ -426,7 +435,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	struct sdhci_msm_host *msm_host;
 	struct resource *core_memres;
 	int ret;
-	u16 host_version;
+	u16 host_version, core_minor;
+	u32 core_version, caps;
+	u8 core_major;
 
 	msm_host = devm_kzalloc(&pdev->dev, sizeof(*msm_host), GFP_KERNEL);
 	if (!msm_host)
@@ -516,6 +527,24 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		host_version, ((host_version & SDHCI_VENDOR_VER_MASK) >>
 			       SDHCI_VENDOR_VER_SHIFT));
 
+	core_version = readl_relaxed(msm_host->core_mem + CORE_MCI_VERSION);
+	core_major = (core_version & CORE_VERSION_MAJOR_MASK) >>
+		      CORE_VERSION_MAJOR_SHIFT;
+	core_minor = core_version & CORE_VERSION_MINOR_MASK;
+	dev_dbg(&pdev->dev, "MCI Version: 0x%08x, major: 0x%04x, minor: 0x%02x\n",
+		core_version, core_major, core_minor);
+
+	/*
+	 * Support for some capabilities is not advertised by newer
+	 * controller versions and must be explicitly enabled.
+	 */
+	if (core_major >= 1 && core_minor != 0x11 && core_minor != 0x12) {
+		caps = readl_relaxed(host->ioaddr + SDHCI_CAPABILITIES);
+		caps |= CORE_3_0V_SUPPORT | CORE_8_BIT_SUPPORT;
+		writel_relaxed(caps, host->ioaddr +
+			       CORE_VENDOR_SPEC_CAPABILITIES0);
+	}
+
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto clk_disable;
