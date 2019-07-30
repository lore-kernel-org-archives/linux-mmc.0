From: "Shirley Her (SC)" <shirley.her@bayhubtech.com>
Subject: [PATCH V3 2/2] mmc: sdhci: Fix O2 Host data read/write DLL lock phase
 shift issue
Date: Tue, 30 Jul 2019 19:08:02 +0000
Message-ID: <1564513681-16428-1-git-send-email-shirley.her@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Chevron Li (WH)" <chevron.li@bayhubtech.com>, "Louis Lu (TP)" <louis.lu@bayhubtech.com>, "Max Huang (SC)" <max.huang@bayhubtech.com>, "Shirley Her (SC)" <shirley.her@bayhubtech.com>
List-Id: linux-mmc@vger.kernel.org

Fix data read/write error in HS200 mode due to chip DLL lock phase shift

Signed-off-by:Shirley Her <shirley.her@bayhubtech.com>
---
change in V3:
 1. add more explanation in dll_recovery and execute_tuning function
 2. move dll_adjust_count ot O2_host struct
 3. fix some coding style error
 4. renaming O2_PLL_WDT_CONTROL1 to O2_PLL_DLL_WDT_CONTROL1

change in V2:
 1. use usleep_range instead of udelay
 2. move dll_adjust_count ot sdhci-pci-o2micro.c

change in V1:
 1. add error recovery function to relock DLL with correct phase
 2. retuning Hs200 after DLL locked
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 322 ++++++++++++++++++++++++-------=
----
 1 file changed, 225 insertions(+), 97 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-=
pci-o2micro.c
index 186a33d..a24df30 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -55,9 +55,139 @@
 #define  O2_PLL_FORCE_ACTIVE	BIT(18)
 #define  O2_PLL_LOCK_STATUS	BIT(14)
 #define  O2_PLL_SOFT_RESET	BIT(12)
+#define  O2_DLL_LOCK_STATUS	BIT(11)
=20
 #define O2_SD_DETECT_SETTING 0x324
=20
+static const u32 dmdn_table[5] =3D {0x25100000, 0x2B1C0000,
+	0x2C1A0000, 0x371B0000, 0x35100000};
+
+struct o2_host {
+	u8 dll_adjust_count;
+};
+
+static void sdhci_o2_wait_card_detect_stable(struct sdhci_host *host)
+{
+	ktime_t timeout;
+	u32 scratch32;
+
+	/* Wait max 50 ms */
+	timeout =3D ktime_add_ms(ktime_get(), 50);
+	while (1) {
+		bool timedout =3D ktime_after(ktime_get(), timeout);
+
+		scratch32 =3D sdhci_readl(host, SDHCI_PRESENT_STATE);
+		if ((scratch32 & SDHCI_CARD_PRESENT) >> SDHCI_CARD_PRES_SHIFT
+		    =3D=3D (scratch32 & SDHCI_CD_LVL) >> SDHCI_CD_LVL_SHIFT)
+			break;
+
+		if (timedout) {
+			pr_err("%s: Card Detect debounce never finished.\n",
+			       mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			return;
+		}
+		udelay(10);
+	}
+}
+
+static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
+{
+	ktime_t timeout;
+	u16 scratch;
+	u32 scratch32;
+
+	/* PLL software reset */
+	scratch32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
+	scratch32 |=3D O2_PLL_SOFT_RESET;
+	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
+	udelay(1);
+	scratch32 &=3D ~(O2_PLL_SOFT_RESET);
+	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
+
+	/* PLL force active */
+	scratch32 |=3D O2_PLL_FORCE_ACTIVE;
+	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
+
+	/* Wait max 20 ms */
+	timeout =3D ktime_add_ms(ktime_get(), 20);
+	while (1) {
+		bool timedout =3D ktime_after(ktime_get(), timeout);
+
+		scratch =3D sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1);
+		if (scratch & O2_PLL_LOCK_STATUS)
+			break;
+		if (timedout) {
+			pr_err("%s: Internal clock never stabilised.\n",
+			       mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			goto out;
+		}
+		udelay(10);
+	}
+
+	/* Wait for card detect finish */
+	udelay(1);
+	sdhci_o2_wait_card_detect_stable(host);
+
+out:
+	/* Cancel PLL force active */
+	scratch32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
+	scratch32 &=3D ~O2_PLL_FORCE_ACTIVE;
+	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
+}
+
+static int sdhci_o2_get_cd(struct mmc_host *mmc)
+{
+	struct sdhci_host *host =3D mmc_priv(mmc);
+
+	if (!(sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1) & O2_PLL_LOCK_STATUS))
+		sdhci_o2_enable_internal_clock(host);
+
+	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
+}
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
@@ -73,7 +203,6 @@ static void __sdhci_o2_execute_tuning(struct sdhci_host =
*host, u32 opcode)
 	int i;
=20
 	sdhci_send_tuning(host, MMC_SEND_TUNING_BLOCK_HS200);
-
 	for (i =3D 0; i < 150; i++) {
 		u16 ctrl =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
=20
@@ -95,12 +224,103 @@ static void __sdhci_o2_execute_tuning(struct sdhci_ho=
st *host, u32 opcode)
 	sdhci_reset_tuning(host);
 }
=20
+/* this function is used to fix o2 dll shift issue */
+static int sdhci_o2_dll_recovery(struct sdhci_host *host)
+{
+	int ret =3D 0;
+	u8 scratch_8 =3D 0;
+	u32 scratch_32 =3D 0;
+	ktime_t timeout;
+	struct sdhci_pci_slot *slot =3D sdhci_priv(host);
+	struct sdhci_pci_chip *chip =3D slot->chip;
+	struct o2_host *o2_host =3D sdhci_pci_priv(slot);
+
+	/* Disable clock */
+	sdhci_writeb(host, 0, SDHCI_CLOCK_CONTROL);
+	/* set timeout 10 s */
+	timeout =3D ktime_add(ktime_get(), 10);
+	while (1) {
+		bool timeout =3D ktime_after(ktime_get(), timeout);
+
+		if (timeout) {
+			pr_warn("%s: error recovery failed with timeout.\n",
+				mmc_hostname(host->mmc));
+			ret =3D 0;
+			goto out;
+		}
+		if (o2_host->dll_adjust_count < 4) {
+			o2_host->dll_adjust_count++;
+		} else {
+
+			o2_host->dll_adjust_count =3D 4;
+			pr_warn("%s: dll_adjust_count reach max value.\n",
+				mmc_hostname(host->mmc));
+		}
+
+		/* UnLock WP */
+		ret =3D pci_read_config_byte(chip->pdev,
+				O2_SD_LOCK_WP, &scratch_8);
+		if (ret)
+			return ret;
+
+		scratch_8 &=3D 0x7f;
+		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+
+		/* PLL software reset */
+		scratch_32 =3D sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
+		scratch_32 |=3D O2_PLL_SOFT_RESET;
+		sdhci_writel(host, scratch_32, O2_PLL_DLL_WDT_CONTROL1);
+
+		ret =3D pci_read_config_dword(chip->pdev,
+					    O2_SD_FUNC_REG4,
+					    &scratch_32);
+		/* Enable Base Clk setting change */
+		scratch_32 |=3D O2_SD_FREG4_ENABLE_CLK_SET;
+		pci_write_config_dword(chip->pdev, O2_SD_FUNC_REG4, scratch_32);
+		o2_pci_set_baseclk(chip, dmdn_table[o2_host->dll_adjust_count]);
+
+		/* Enable internal clock */
+		scratch_8 =3D SDHCI_CLOCK_INT_EN;
+		sdhci_writeb(host, scratch_8, SDHCI_CLOCK_CONTROL);
+
+		if (sdhci_o2_get_cd(host->mmc)) {
+			if (sdhci_o2_wait_dll_detect_lock(host)) {
+				scratch_8 |=3D SDHCI_CLOCK_CARD_EN;
+				sdhci_writeb(host, scratch_8,
+					SDHCI_CLOCK_CONTROL);
+				ret =3D 1;
+				goto out;
+			} else {
+				pr_warn("%s: DLL unlocked when dll_adjust_count is %d.\n",
+					mmc_hostname(host->mmc),
+					o2_host->dll_adjust_count);
+			}
+		}
+	}
+out:
+	/* Lock WP */
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
 	int current_bus_width =3D 0;
=20
 	/*
+	 * Judge the tuning reason, whether caused by dll shift
+	 * If cause by dll shift, should call sdhci_o2_dll_recovery
+	 */
+	if (!sdhci_o2_wait_dll_detect_lock(host))
+		sdhci_o2_dll_recovery(host);
+
+	/*
 	 * This handler only implements the eMMC tuning that is specific to
 	 * this controller.  Fall back to the standard method for other TIMING.
 	 */
@@ -131,24 +351,10 @@ static int sdhci_o2_execute_tuning(struct mmc_host *m=
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
-
-	scratch_32 &=3D 0x0000FFFF;
-	scratch_32 |=3D value;
-
-	pci_write_config_dword(chip->pdev,
-			       O2_SD_PLL_SETTING, scratch_32);
-}
-
 static void o2_pci_led_enable(struct sdhci_pci_chip *chip)
 {
 	int ret;
@@ -284,92 +490,12 @@ static void sdhci_pci_o2_enable_msi(struct sdhci_pci_=
chip *chip,
 	host->irq =3D pci_irq_vector(chip->pdev, 0);
 }
=20
-static void sdhci_o2_wait_card_detect_stable(struct sdhci_host *host)
-{
-	ktime_t timeout;
-	u32 scratch32;
-
-	/* Wait max 50 ms */
-	timeout =3D ktime_add_ms(ktime_get(), 50);
-	while (1) {
-		bool timedout =3D ktime_after(ktime_get(), timeout);
-
-		scratch32 =3D sdhci_readl(host, SDHCI_PRESENT_STATE);
-		if ((scratch32 & SDHCI_CARD_PRESENT) >> SDHCI_CARD_PRES_SHIFT
-		    =3D=3D (scratch32 & SDHCI_CD_LVL) >> SDHCI_CD_LVL_SHIFT)
-			break;
-
-		if (timedout) {
-			pr_err("%s: Card Detect debounce never finished.\n",
-			       mmc_hostname(host->mmc));
-			sdhci_dumpregs(host);
-			return;
-		}
-		udelay(10);
-	}
-}
-
-static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
-{
-	ktime_t timeout;
-	u16 scratch;
-	u32 scratch32;
-
-	/* PLL software reset */
-	scratch32 =3D sdhci_readl(host, O2_PLL_WDT_CONTROL1);
-	scratch32 |=3D O2_PLL_SOFT_RESET;
-	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
-	udelay(1);
-	scratch32 &=3D ~(O2_PLL_SOFT_RESET);
-	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
-
-	/* PLL force active */
-	scratch32 |=3D O2_PLL_FORCE_ACTIVE;
-	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
-
-	/* Wait max 20 ms */
-	timeout =3D ktime_add_ms(ktime_get(), 20);
-	while (1) {
-		bool timedout =3D ktime_after(ktime_get(), timeout);
-
-		scratch =3D sdhci_readw(host, O2_PLL_WDT_CONTROL1);
-		if (scratch & O2_PLL_LOCK_STATUS)
-			break;
-		if (timedout) {
-			pr_err("%s: Internal clock never stabilised.\n",
-			       mmc_hostname(host->mmc));
-			sdhci_dumpregs(host);
-			goto out;
-		}
-		udelay(10);
-	}
-
-	/* Wait for card detect finish */
-	udelay(1);
-	sdhci_o2_wait_card_detect_stable(host);
-
-out:
-	/* Cancel PLL force active */
-	scratch32 =3D sdhci_readl(host, O2_PLL_WDT_CONTROL1);
-	scratch32 &=3D ~O2_PLL_FORCE_ACTIVE;
-	sdhci_writel(host, scratch32, O2_PLL_WDT_CONTROL1);
-}
-
-static int sdhci_o2_get_cd(struct mmc_host *mmc)
-{
-	struct sdhci_host *host =3D mmc_priv(mmc);
-
-	sdhci_o2_enable_internal_clock(host);
-
-	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
-}
-
 static void sdhci_o2_enable_clk(struct sdhci_host *host, u16 clk)
 {
 	/* Enable internal clock */
 	clk |=3D SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-
+	sdhci_o2_enable_internal_clock(host);
 	if (sdhci_o2_get_cd(host->mmc)) {
 		clk |=3D SDHCI_CLOCK_CARD_EN;
 		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
@@ -395,12 +521,13 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *sl=
ot)
 {
 	struct sdhci_pci_chip *chip;
 	struct sdhci_host *host;
+	struct o2_host *o2_host =3D sdhci_pci_priv(slot);
 	u32 reg, caps;
 	int ret;
=20
 	chip =3D slot->chip;
 	host =3D slot->host;
-
+	o2_host->dll_adjust_count =3D 0;
 	caps =3D sdhci_readl(host, SDHCI_CAPABILITIES);
=20
 	/*
@@ -687,4 +814,5 @@ const struct sdhci_pci_fixes sdhci_o2 =3D {
 	.resume =3D sdhci_pci_o2_resume,
 #endif
 	.ops =3D &sdhci_pci_o2_ops,
+	.priv_size =3D sizeof(struct o2_host),
 };
--=20
2.7.4
