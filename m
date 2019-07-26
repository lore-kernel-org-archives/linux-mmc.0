From: "Shirley Her (SC)" <shirley.her@bayhubtech.com>
Subject: [PATCH V2 1/1] mmc: sdhci: Fix O2 Host data read/write DLL lock Phase
 shift issue
Date: Fri, 26 Jul 2019 18:48:32 +0000
Message-ID: <1564166909-7437-1-git-send-email-shirley.her@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Louis Lu (TP)" <louis.lu@bayhubtech.com>, "Max Huang (SC)" <max.huang@bayhubtech.com>, "Chevron Li (WH)" <chevron.li@bayhubtech.com>, "Shirley Her (SC)" <shirley.her@bayhubtech.com>
List-Id: linux-mmc@vger.kernel.org

Fix data read/write error in HS200 mode due to chip DLL lock phase shift

Signed-off-by:Shirley Her<shirley.her@bayhubtech.com>
---
change in V2:
  1. Use usleep_range instead of udelay
  2. move dll_adjust_count to sdhci-pci-o2micro.c

change in V1:
  1. Add error recovery function to relock the DLL with correct phase
  2. Retuning HS200 after DLL locked
---
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 157 +++++++++++++++++++++++++++++--=
----
 1 file changed, 133 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-=
pci-o2micro.c
index 9dc4548..c43b2ce 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -51,13 +51,60 @@
 #define O2_SD_VENDOR_SETTING2	0x1C8
 #define O2_SD_HW_TUNING_DISABLE	BIT(4)
=20
-#define O2_PLL_WDT_CONTROL1	0x1CC
+#define O2_PLL_DLL_WDT_CONTROL1	0x1CC
 #define  O2_PLL_FORCE_ACTIVE	BIT(18)
 #define  O2_PLL_LOCK_STATUS	BIT(14)
 #define  O2_PLL_SOFT_RESET	BIT(12)
+#define  O2_DLL_LOCK_STATUS	BIT(11)
=20
 #define O2_SD_DETECT_SETTING 0x324
=20
+static const u32 dmdn_table[5] =3D {0x25100000, 0x2B1C0000,
+	0x2C1A0000, 0x371B0000, 0x35100000};
+static u8 dll_adjust_count;
+static int sdhci_o2_get_cd(struct mmc_host *mmc);
+
+static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
+{
+	u32 scratch_32;
+
+	pci_read_config_dword(chip->pdev,
+			      O2_SD_PLL_SETTING, &scratch_32);
+
+	scratch_32 &=3D 0x0000FFFF;
+	scratch_32 |=3D value;
+
+	pci_write_config_dword(chip->pdev,
+			       O2_SD_PLL_SETTING, scratch_32);
+}
+
+static int sdhci_o2_wait_dll_detect_lock(struct sdhci_host *host)
+{
+	ktime_t timeout;
+	u32 scratch32;
+
+	usleep_range(5000, 6000);
+	scratch32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
+	if (!(scratch32 & O2_DLL_LOCK_STATUS)) {
+		pr_warn("%s: DLL is still unlocked after wait 5ms\n",
+			mmc_hostname(host->mmc));
+	}
+
+	/* Detect 500 ms */
+	timeout =3D ktime_add_ms(ktime_get(), 500);
+	while (1) {
+		bool timedout =3D ktime_after(ktime_get(), timeout);
+
+		scratch32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
+		if (!(scratch32 & O2_DLL_LOCK_STATUS))
+			return 0;
+
+		if (timedout)
+			return 1;
+		usleep_range(10, 1000);
+	}
+}
+
 static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
 {
 	u16 reg;
@@ -95,11 +142,85 @@ static void __sdhci_o2_execute_tuning(struct sdhci_hos=
t *host, u32 opcode)
 	sdhci_reset_tuning(host);
 }
=20
+static int sdhci_o2_error_recovery(struct sdhci_pci_chip *chip,
+				 struct sdhci_host *host)
+{
+	int ret =3D 0;
+	u8 scratch_8 =3D 0;
+	u32 scratch_32 =3D 0;
+	/* Disable clock */
+	sdhci_writeb(host, 0, SDHCI_CLOCK_CONTROL);
+
+DLL_ADJUST:
+	if (dll_adjust_count >=3D 5) {
+		dll_adjust_count =3D 4;
+		pr_warn("%s: error recovery failed with the dll_adjust_count over max va=
lue.\n",
+			mmc_hostname(host->mmc));
+	}
+
+	/* UnLock WP */
+	ret =3D pci_read_config_byte(chip->pdev,
+			O2_SD_LOCK_WP, &scratch_8);
+	if (ret)
+		return ret;
+
+	scratch_8 &=3D 0x7f;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+
+	/* PLL software reset */
+	scratch_32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
+	scratch_32 |=3D O2_PLL_SOFT_RESET;
+	sdhci_writel(host, scratch_32, O2_PLL_DLL_WDT_CONTROL1);
+
+	ret =3D pci_read_config_dword(chip->pdev,
+				    O2_SD_FUNC_REG4,
+				    &scratch_32);
+	/* Enable Base Clk setting change */
+	scratch_32 |=3D O2_SD_FREG4_ENABLE_CLK_SET;
+	pci_write_config_dword(chip->pdev, O2_SD_FUNC_REG4, scratch_32);
+	o2_pci_set_baseclk(chip, dmdn_table[dll_adjust_count]);
+
+
+	/* Enable internal clock */
+	scratch_8 =3D SDHCI_CLOCK_INT_EN;
+	sdhci_writeb(host, scratch_8, SDHCI_CLOCK_CONTROL);
+
+	if (sdhci_o2_get_cd(host->mmc)) {
+		if (sdhci_o2_wait_dll_detect_lock(host)) {
+			scratch_8 |=3D SDHCI_CLOCK_CARD_EN;
+			sdhci_writeb(host, scratch_8, SDHCI_CLOCK_CONTROL);
+			ret =3D 1;
+		} else {
+
+			pr_warn("%s: DLL unlocked when dll_adjust_count is %d.\n",
+			mmc_hostname(host->mmc), dll_adjust_count);
+			dll_adjust_count++;
+			goto DLL_ADJUST;
+		}
+	} else
+		goto DLL_ADJUST;
+
+		/* Lock WP */
+	ret =3D pci_read_config_byte(chip->pdev,
+				   O2_SD_LOCK_WP, &scratch_8);
+	if (ret)
+		return ret;
+	scratch_8 |=3D 0x80;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+	return ret;
+}
+
 static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host =3D mmc_priv(mmc);
+	struct sdhci_pci_slot *slot =3D sdhci_priv(host);
 	int current_bus_width =3D 0;
=20
+
+	if (dll_adjust_count)
+		sdhci_o2_error_recovery(slot->chip, host);
+
+	dll_adjust_count++;
 	/*
 	 * This handler only implements the eMMC tuning that is specific to
 	 * this controller.  Fall back to the standard method for other TIMING.
@@ -131,23 +252,11 @@ static int sdhci_o2_execute_tuning(struct mmc_host *m=
mc, u32 opcode)
 		mmc->ios.bus_width =3D MMC_BUS_WIDTH_8;
 		sdhci_set_bus_width(host, current_bus_width);
 	}
-
 	host->flags &=3D ~SDHCI_HS400_TUNING;
 	return 0;
 }
=20
-static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
-{
-	u32 scratch_32;
-	pci_read_config_dword(chip->pdev,
-			      O2_SD_PLL_SETTING, &scratch_32);
=20
-	scratch_32 &=3D 0x0000FFFF;
-	scratch_32 |=3D value;
-
-	pci_write_config_dword(chip->pdev,
-			       O2_SD_PLL_SETTING, scratch_32);
-}
=20
 static void o2_pci_led_enable(struct sdhci_pci_chip *chip)
 {
@@ -316,23 +425,23 @@ static void sdhci_o2_enable_internal_clock(struct sdh=
ci_host *host)
 	u32 scratch32;
=20
 	/* PLL software reset */
-	scratch32 =3D sdhci_readl(host, O2_PLL_WDT_CONTROL1);
+	scratch32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
 	scratch32 |=3D O2_PLL_SOFT_RESET;
-	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
+	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
 	udelay(1);
 	scratch32 &=3D ~(O2_PLL_SOFT_RESET);
-	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
+	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
=20
 	/* PLL force active */
 	scratch32 |=3D O2_PLL_FORCE_ACTIVE;
-	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
+	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
=20
 	/* Wait max 20 ms */
 	timeout =3D ktime_add_ms(ktime_get(), 20);
 	while (1) {
 		bool timedout =3D ktime_after(ktime_get(), timeout);
=20
-		scratch =3D sdhci_readw(host, O2_PLL_WDT_CONTROL1);
+		scratch =3D sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1);
 		if (scratch & O2_PLL_LOCK_STATUS)
 			break;
 		if (timedout) {
@@ -350,16 +459,16 @@ static void sdhci_o2_enable_internal_clock(struct sdh=
ci_host *host)
=20
 out:
 	/* Cancel PLL force active */
-	scratch32 =3D sdhci_readl(host, O2_PLL_WDT_CONTROL1);
+	scratch32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
 	scratch32 &=3D ~O2_PLL_FORCE_ACTIVE;
-	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
+	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
 }
=20
 static int sdhci_o2_get_cd(struct mmc_host *mmc)
 {
 	struct sdhci_host *host =3D mmc_priv(mmc);
-
-	sdhci_o2_enable_internal_clock(host);
+	if (!(sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1) & O2_PLL_LOCK_STATUS))
+		sdhci_o2_enable_internal_clock(host);
=20
 	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
 }
@@ -369,7 +478,7 @@ static void sdhci_o2_enable_clk(struct sdhci_host *host=
, u16 clk)
 	/* Enable internal clock */
 	clk |=3D SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-
+	sdhci_o2_enable_internal_clock(host);
 	if (sdhci_o2_get_cd(host->mmc)) {
 		clk |=3D SDHCI_CLOCK_CARD_EN;
 		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
@@ -400,7 +509,7 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot=
)
=20
 	chip =3D slot->chip;
 	host =3D slot->host;
-
+	dll_adjust_count =3D 0;
 	caps =3D sdhci_readl(host, SDHCI_CAPABILITIES);
=20
 	/*
--=20
2.7.4
