From: Wan ZongShun <Vincent.Wan@amd.com>
Subject: [PATCH 3/3] SDHCI: Change AMD SDHCI quirk application scope
Date: Sat, 6 Jun 2015 21:13:40 +0800
Message-ID: <1433596420-5612-3-git-send-email-Vincent.Wan@amd.com>
References: <1433596420-5612-1-git-send-email-Vincent.Wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1433596420-5612-1-git-send-email-Vincent.Wan@amd.com>
Sender: linux-pci-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-i2c@vger.kernel.org, bp@alien8.de, jdelvare@suse.de
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Wan ZongShun <Vincent.Wan@amd.com>, Wan ZongShun <mcuos.com@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Change this quirk to apply to AMD Carrizo platform.

Signed-off-by: Wan ZongShun <Vincent.Wan@amd.com>
Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>

Tested-by: Nath, Arindam <Arindam.Nath@amd.com>
Tested-by: Ramesh, Ramya <Ramya.Ramesh@amd.com>
---
 drivers/mmc/host/sdhci-pci.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index f208f20..94f54d2 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -724,14 +724,37 @@ static const struct sdhci_pci_fixes sdhci_rtsx = {
 	.probe_slot	= rtsx_probe_slot,
 };
 
+/*AMD chipset generation*/
+enum amd_chipset_gen {
+	AMD_CHIPSET_BEFORE_ML,
+	AMD_CHIPSET_CZ,
+	AMD_CHIPSET_NL,
+	AMD_CHIPSET_UNKNOWN,
+};
+
 static int amd_probe(struct sdhci_pci_chip *chip)
 {
 	struct pci_dev	*smbus_dev;
+	enum amd_chipset_gen gen;
 
 	smbus_dev = pci_get_device(PCI_VENDOR_ID_AMD,
 			PCI_DEVICE_ID_AMD_HUDSON2_SMBUS, NULL);
+	if (smbus_dev) {
+		gen = AMD_CHIPSET_BEFORE_ML;
+	} else {
+		smbus_dev = pci_get_device(PCI_VENDOR_ID_AMD,
+				PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, NULL);
+		if (smbus_dev) {
+			if (smbus_dev->revision < 0x51)
+				gen = AMD_CHIPSET_CZ;
+			else
+				gen = AMD_CHIPSET_NL;
+		} else {
+			gen = AMD_CHIPSET_UNKNOWN;
+		}
+	}
 
-	if (smbus_dev && (smbus_dev->revision < 0x51)) {
+	if ((gen == AMD_CHIPSET_BEFORE_ML) || (gen == AMD_CHIPSET_CZ)) {
 		chip->quirks2 |= SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD;
 		chip->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
 	}
-- 
1.9.1
