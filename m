From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 1/2] mmc: sdhci-spear: add device tree bindings
Date: Fri, 28 Sep 2012 15:58:22 +0530
Message-ID: <cb66033bd923920daefc57570381f978d6e37168.1348828070.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48137 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab2I1K2l (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Sep 2012 06:28:41 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: spear-devel@list.st.com, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, sr@denx.de, Viresh Kumar <viresh.kumar@linaro.org>

This adds simple DT bindings for SDHCI SPEAr controller. It uses cd-gpios f=
rom
common mmc bindings.

This also fixes spear300-evb.dts with correct name for card detect binding.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2:
- Use cd-gpios instead of int-gpio as binding for card detect gpio.
- Fix spear300-evb.dts binding name for cd-gpios
- Removed power-gpio from DT bindings and code, must be handled via regulat=
ors

 .../devicetree/bindings/mmc/sdhci-spear.txt        | 18 +++++++
 arch/arm/boot/dts/spear300-evb.dts                 |  3 +-
 arch/arm/boot/dts/spear320-evb.dts                 |  2 -
 drivers/mmc/host/sdhci-spear.c                     | 57 ++++++++++++++++++=
+++-
 4 files changed, 74 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-spear.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-spear.txt b/Docume=
ntation/devicetree/bindings/mmc/sdhci-spear.txt
new file mode 100644
index 0000000..5c863e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-spear.txt
@@ -0,0 +1,18 @@
+* SPEAr SDHCI Controller
+
+Required properties:
+- compatible : "st,spear300-sdhci"
+
+Optional Properties:
+- cd-gpios: card detect gpio, with zero flags.
+
+If your board don't support these gpios then don't pass the entry.
+
+Example:
+
+=09sdhci@fc000000 {
+=09=09compatible =3D "st,spear300-sdhci";
+=09=09reg =3D <0xfc000000 0x1000>;
+
+=09=09cd-gpios =3D <&gpio0 6 0>
+=09};
diff --git a/arch/arm/boot/dts/spear300-evb.dts b/arch/arm/boot/dts/spear30=
0-evb.dts
index d71b8d5..1e7c7a8 100644
--- a/arch/arm/boot/dts/spear300-evb.dts
+++ b/arch/arm/boot/dts/spear300-evb.dts
@@ -80,8 +80,7 @@
 =09=09};
=20
 =09=09sdhci@70000000 {
-=09=09=09int-gpio =3D <&gpio1 0 0>;
-=09=09=09power-gpio =3D <&gpio1 2 1>;
+=09=09=09cd-gpios =3D <&gpio1 0 0>;
 =09=09=09status =3D "okay";
 =09=09};
=20
diff --git a/arch/arm/boot/dts/spear320-evb.dts b/arch/arm/boot/dts/spear32=
0-evb.dts
index e4e912f..082328b 100644
--- a/arch/arm/boot/dts/spear320-evb.dts
+++ b/arch/arm/boot/dts/spear320-evb.dts
@@ -103,8 +103,6 @@
 =09=09};
=20
 =09=09sdhci@70000000 {
-=09=09=09power-gpio =3D <&gpio0 2 1>;
-=09=09=09power_always_enb;
 =09=09=09status =3D "okay";
 =09=09};
=20
diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.=
c
index 423da81..ecad282 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -20,6 +20,8 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
@@ -68,8 +70,42 @@ static irqreturn_t sdhci_gpio_irq(int irq, void *dev_id)
 =09return IRQ_HANDLED;
 }
=20
+#ifdef CONFIG_OF
+static struct sdhci_plat_data * __devinit
+sdhci_probe_config_dt(struct platform_device *pdev)
+{
+=09struct device_node *np =3D pdev->dev.of_node;
+=09struct sdhci_plat_data *pdata =3D NULL;
+=09int cd_gpio;
+
+=09cd_gpio =3D of_get_named_gpio(np, "cd-gpios", 0);
+=09if (!gpio_is_valid(cd_gpio))
+=09=09cd_gpio =3D -1;
+
+=09/* If pdata is required */
+=09if (cd_gpio !=3D -1) {
+=09=09pdata =3D devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+=09=09if (!pdata) {
+=09=09=09dev_err(&pdev->dev, "DT: kzalloc failed\n");
+=09=09=09return ERR_PTR(-ENOMEM);
+=09=09}
+=09}
+
+=09pdata->card_int_gpio =3D cd_gpio;
+
+=09return pdata;
+}
+#else
+static struct sdhci_plat_data * __devinit
+sdhci_probe_config_dt(struct platform_device *pdev)
+{
+=09return ERR_PTR(-ENOSYS);
+}
+#endif
+
 static int __devinit sdhci_probe(struct platform_device *pdev)
 {
+=09struct device_node *np =3D pdev->dev.of_node;
 =09struct sdhci_host *host;
 =09struct resource *iomem;
 =09struct spear_sdhci *sdhci;
@@ -110,8 +146,16 @@ static int __devinit sdhci_probe(struct platform_devic=
e *pdev)
 =09=09goto put_clk;
 =09}
=20
-=09/* overwrite platform_data */
-=09sdhci->data =3D dev_get_platdata(&pdev->dev);
+=09if (np) {
+=09=09sdhci->data =3D sdhci_probe_config_dt(pdev);
+=09=09if (IS_ERR(sdhci->data)) {
+=09=09=09dev_err(&pdev->dev, "DT: Failed to get pdata\n");
+=09=09=09return -ENODEV;
+=09=09}
+=09} else {
+=09=09sdhci->data =3D dev_get_platdata(&pdev->dev);
+=09}
+
 =09pdev->dev.platform_data =3D sdhci;
=20
 =09if (pdev->dev.parent)
@@ -276,11 +320,20 @@ static int sdhci_resume(struct device *dev)
=20
 static SIMPLE_DEV_PM_OPS(sdhci_pm_ops, sdhci_suspend, sdhci_resume);
=20
+#ifdef CONFIG_OF
+static const struct of_device_id sdhci_spear_id_table[] =3D {
+=09{ .compatible =3D "st,spear300-sdhci" },
+=09{}
+};
+MODULE_DEVICE_TABLE(of, sdhci_spear_id_table);
+#endif
+
 static struct platform_driver sdhci_driver =3D {
 =09.driver =3D {
 =09=09.name=09=3D "sdhci",
 =09=09.owner=09=3D THIS_MODULE,
 =09=09.pm=09=3D &sdhci_pm_ops,
+=09=09.of_match_table =3D of_match_ptr(sdhci_spear_id_table),
 =09},
 =09.probe=09=09=3D sdhci_probe,
 =09.remove=09=09=3D __devexit_p(sdhci_remove),
--=20
1.7.12.rc2.18.g61b472e


