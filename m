From: "Ernest Zhang(WH)" <ernest.zhang@bayhubtech.com>
Subject: [PATCH V2 2/2] mmc: sdhci: Moving sdhci_o2 into sdhci-pci-o2micro.c
Date: Tue, 18 Dec 2018 11:40:37 +0000
Message-ID: <20181218114003.10002-2-ernest.zhang@bayhubtech.com>
References: <20181218114003.10002-1-ernest.zhang@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218114003.10002-1-ernest.zhang@bayhubtech.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Andy Dai (WH)" <andy.dai@bayhubtech.com>, "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>, "Shirley Her (SC)" <shirley.her@bayhubtech.com>, "Mike Li (WH)" <mike.li@bayhubtech.com>
List-Id: linux-mmc@vger.kernel.org

Moving sdhci_o2 into sdhci-pci-o2micro.c

Signed-off-by: Ernest Zhang <ernest.zhang@bayhubtech.com>
---
Change in V2:
	1. Moving sdhci_o2 into sdhci-pci-o2micro.c

Change in V1:
	N/A
---
 drivers/mmc/host/sdhci-pci-core.c    | 19 -------------------
 drivers/mmc/host/sdhci-pci-o2micro.c | 19 +++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h         |  1 +
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci=
-core.c
index fc4f35653602..99b0fec2836b 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1257,25 +1257,6 @@ static int jmicron_resume(struct sdhci_pci_chip *chi=
p)
 }
 #endif
=20
-static const struct sdhci_ops sdhci_pci_o2_ops =3D {
-	.set_clock =3D sdhci_pci_o2_set_clock,
-	.enable_dma =3D sdhci_pci_enable_dma,
-	.set_bus_width =3D sdhci_set_bus_width,
-	.reset =3D sdhci_reset,
-	.set_uhs_signaling =3D sdhci_set_uhs_signaling,
-};
-
-static const struct sdhci_pci_fixes sdhci_o2 =3D {
-	.probe =3D sdhci_pci_o2_probe,
-	.quirks =3D SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
-	.quirks2 =3D SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD,
-	.probe_slot =3D sdhci_pci_o2_probe_slot,
-#ifdef CONFIG_PM_SLEEP
-	.resume =3D sdhci_pci_o2_resume,
-#endif
-	.ops =3D &sdhci_pci_o2_ops,
-};
-
 static const struct sdhci_pci_fixes sdhci_jmicron =3D {
 	.probe		=3D jmicron_probe,
=20
diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-=
pci-o2micro.c
index 506b93e5dcd8..7f11cee71db1 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -665,3 +665,22 @@ int sdhci_pci_o2_resume(struct sdhci_pci_chip *chip)
 	return sdhci_pci_resume_host(chip);
 }
 #endif
+
+static const struct sdhci_ops sdhci_pci_o2_ops =3D {
+	.set_clock =3D sdhci_pci_o2_set_clock,
+	.enable_dma =3D sdhci_pci_enable_dma,
+	.set_bus_width =3D sdhci_set_bus_width,
+	.reset =3D sdhci_reset,
+	.set_uhs_signaling =3D sdhci_set_uhs_signaling,
+};
+
+const struct sdhci_pci_fixes sdhci_o2 =3D {
+	.probe =3D sdhci_pci_o2_probe,
+	.quirks =3D SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks2 =3D SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD,
+	.probe_slot =3D sdhci_pci_o2_probe_slot,
+#ifdef CONFIG_PM_SLEEP
+	.resume =3D sdhci_pci_o2_resume,
+#endif
+	.ops =3D &sdhci_pci_o2_ops,
+};
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index e41a85f0b40a..0e08021179a8 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -188,5 +188,6 @@ void sdhci_pci_o2_set_clock(struct sdhci_host *host, un=
signed int clock);
=20
 extern const struct sdhci_pci_fixes sdhci_arasan;
 extern const struct sdhci_pci_fixes sdhci_snps;
+extern const struct sdhci_pci_fixes sdhci_o2;
=20
 #endif /* __SDHCI_PCI_H */
--=20
2.16.4
