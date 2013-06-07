From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v2 5/8] pinctrl: add pinctrl driver for Rockchip SoCs
Date: Sat, 8 Jun 2013 01:13:48 +0200
Message-ID: <201306080113.49186.heiko@sntech.de>
References: <201306062107.58875.heiko@sntech.de>
 <201306062111.40983.heiko@sntech.de>
 <CACRpkdZ97poa5HOP4baDnsdq5OjwO5S2=+pPH9ey84r=ZW43nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CACRpkdZ97poa5HOP4baDnsdq5OjwO5S2=+pPH9ey84r=ZW43nA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Am Freitag, 7. Juni 2013, 14:53:51 schrieb Linus Walleij:
> On Thu, Jun 6, 2013 at 9:11 PM, Heiko St=FCbner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org> wrote:
> > +       for (i =3D 0, j =3D 0; i < size; i +=3D 4, j++) {
> > +               unsigned long pinconf;
> > +
> > +               num =3D be32_to_cpu(*list++);
> > +               bank =3D bank_num_to_bank(info, num);
> > +               if (IS_ERR(bank))
> > +                       return PTR_ERR(bank);
> > +
> > +               pin =3D be32_to_cpu(*list++);
> > +               grp->pins[j] =3D bank->pin_base + pin;
> > +               grp->func[j] =3D be32_to_cpu(*list++);
> > +
> > +               pinconf =3D be32_to_cpu(*list++);
> > +               switch(pinconf) {
> > +               case RK_PINCTRL_NONE:
> > +                       bias =3D PIN_CONFIG_BIAS_DISABLE;
> > +                       break;
> > +               case RK_PINCTRL_PULL_PIN_DEFAULT:
> > +                       bias =3D PIN_CONFIG_BIAS_PULL_PIN_DEFAULT;
> > +                       break;
> > +               case RK_PINCTRL_PULL_UP:
> > +                       bias =3D PIN_CONFIG_BIAS_PULL_UP;
> > +                       break;
> > +               case RK_PINCTRL_PULL_DOWN:
> > +                       bias =3D PIN_CONFIG_BIAS_PULL_DOWN;
> > +                       break;
> > +               }
> > +
> > +               grp->configs[j] =3D pinconf_to_config_packed(bias, 0);
> > +       }
> =

> I would like this to be added to
> drivers/pinctrl/pinconf-generic.c
> as a utility function, with the header in
> drivers/pinctrl/pinconf.h
> =

> Also in a separate patch.
> =

> > +++ b/include/dt-bindings/pinctrl/rockchip.h
> =

> (...)
> =

> > +#define RK_PINCTRL_NONE                        0
> > +#define RK_PINCTRL_PULL_PIN_DEFAULT    (1 << 0)
> > +#define RK_PINCTRL_PULL_UP             (1 << 1)
> > +#define RK_PINCTRL_PULL_DOWN           (1 << 2)
> =

> So I'd like these moved to /include/dt-bindings/pinctrl/pinconfig.h
> and used as a separete include. Drop the RK_* prefix as it
> will be universal and use a PINCONFIG_* prefix instead
> of PINCTRL_*.
> =

> I think that is the route we need to take.
> =

> Bonus if you implement more config options from
> pinconf-generic.h but otherwise me and others will have
> to do it.

Gah, damn me for always wanting to get bonus points ;-),

I did play around a bit with the idea you described above and came up
with the stuff a bit below. This is in no way meant to be finished, I
also only was able to compile test it yet, but it looks like it might
work when I test it tomorrow.

So if possible I would just like to get a "looks halfway sane, continue"
or "completely wrong track" please :-) :


constants in dt-bindings/pinctrl/pinconfig.h:
-----------------------------
#define PINCONFIG_NONE			0
#define PINCONFIG_BIAS_DISABLE		(1 << 0)
#define PINCONFIG_BIAS_HIGH_IMPEDANCE	(1 << 1)
#define PINCONFIG_BIAS_BUS_HOLD		(1 << 2)
#define PINCONFIG_BIAS_PULL_PIN_DEFAULT	(1 << 3)
#define PINCONFIG_BIAS_PULL_UP		(1 << 4)
#define PINCONFIG_BIAS_PULL_DOWN	(1 << 5)
#define PINCONFIG_DRIVE_PUSH_PULL	(1 << 6)
#define PINCONFIG_DRIVE_OPEN_DRAIN	(1 << 7)
#define PINCONFIG_DRIVE_OPEN_SOURCE	(1 << 8)
#define PINCONFIG_INPUT_SCHMITT_ENABLE	(1 << 9)
#define PINCONFIG_INPUT_SCHMITT_DISABLE	(1 << 10)
#define PINCONFIG_LOW_POWER_MODE	(1 << 11)
#define PINCONFIG_OUTPUT_LOW		(1 << 12)
#define PINCONFIG_OUTPUT_HIGH		(1 << 13)


and code including how the rockchip driver could look like:
---------
diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-ge=
neric.c
index 9a6812b..35c40be 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -139,3 +139,61 @@ void pinconf_generic_dump_config(struct pinctrl_dev *p=
ctldev,
 }
 EXPORT_SYMBOL_GPL(pinconf_generic_dump_config);
 #endif
+
+/*
+ * Maps the devicetree config bits to actual pinconf values.
+ * The array indizes match the bits set in dt-bindings/pinctrl/pinconf.h
+ * and the array should contain an entry for each bit defined there
+ */
+static unsigned long conf_map[] =3D {
+	PIN_CONF_PACKED(PIN_CONFIG_BIAS_DISABLE, 0),
+	PIN_CONF_PACKED(PIN_CONFIG_BIAS_HIGH_IMPEDANCE, 0),
+	PIN_CONF_PACKED(PIN_CONFIG_BIAS_BUS_HOLD, 0),
+	PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_PIN_DEFAULT, 0),
+	PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_UP, 0),
+	PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_DOWN, 0),
+	PIN_CONF_PACKED(PIN_CONFIG_DRIVE_PUSH_PULL, 0),
+	PIN_CONF_PACKED(PIN_CONFIG_DRIVE_OPEN_DRAIN, 0),
+	PIN_CONF_PACKED(PIN_CONFIG_DRIVE_OPEN_SOURCE, 0),
+	PIN_CONF_PACKED(PIN_CONFIG_INPUT_SCHMITT_ENABLE, 1),
+	PIN_CONF_PACKED(PIN_CONFIG_INPUT_SCHMITT_ENABLE, 0),
+	PIN_CONF_PACKED(PIN_CONFIG_LOW_POWER_MODE, 0),
+	PIN_CONF_PACKED(PIN_CONFIG_OUTPUT, 0),
+	PIN_CONF_PACKED(PIN_CONFIG_OUTPUT, 1),
+};
+
+/*
+ * Parse a pinconf bitmap from a devicetree entry into individual pin conf=
igs.
+ * @pinconf: the bitmap containing config bits
+ * @configs: after the function returns contains a pointer to an array of
+ *	     pin configs
+ * @nconfigs: number of entries of configs
+ */
+int pinconf_generic_parse_dt_bitmap(unsigned long pinconf, =

+				    unsigned long *configs,
+				    unsigned int *nconfigs)
+{
+	int bit;
+	int i;
+
+	*nconfigs =3D hweight_long(pinconf);
+	configs =3D kzalloc(*nconfigs * sizeof(unsigned long), GFP_KERNEL);
+
+	i =3D 0;
+	while (pinconf && i < *nconfigs) {
+		bit =3D __ffs(pinconf);
+		pinconf &=3D ~BIT(i);
+
+		if (bit > ARRAY_SIZE(conf_map)) {
+			pr_err("%s: unknown bit %d\n", __func__, bit);
+			kfree(configs);
+			return -EINVAL;
+		}
+
+		configs[i] =3D conf_map[bit];
+
+		i++;
+	}
+
+	return 0;
+}
diff --git a/drivers/pinctrl/pinconf.h b/drivers/pinctrl/pinconf.h
index 92c7267..0fab53a 100644
--- a/drivers/pinctrl/pinconf.h
+++ b/drivers/pinctrl/pinconf.h
@@ -123,3 +123,9 @@ static inline void pinconf_generic_dump_config(struct p=
inctrl_dev *pctldev,
 	return;
 }
 #endif
+
+#ifdef CONFIG_GENERIC_PINCONF
+int pinconf_generic_parse_dt_bitmap(unsigned long pinconf, =

+				    unsigned long *configs,
+				    unsigned int *nconfigs);
+#endif
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-r=
ockchip.c
index b77e241..88398df 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -40,6 +40,7 @@
 #include <dt-bindings/pinctrl/rockchip.h>
 =

 #include "core.h"
+#include "pinconf.h"
 =

 /* GPIO control registers */
 #define GPIO_SWPORT_DR		0x00
@@ -639,7 +640,8 @@ static int rockchip_pinctrl_parse_groups(struct device_=
node *np,
 	int num;
 	int i, j;
 	int pin;
-	int bias;
+	int ret;
+	int nconfigs;
 =

 	dev_dbg(info->dev, "group(%d): %s\n", index, np->name);
 =

@@ -683,22 +685,16 @@ static int rockchip_pinctrl_parse_groups(struct devic=
e_node *np,
 		grp->func[j] =3D be32_to_cpu(*list++);
 =

 		pinconf =3D be32_to_cpu(*list++);
-		switch(pinconf) {
-		case RK_PINCTRL_NONE:
-			bias =3D PIN_CONFIG_BIAS_DISABLE;
-			break;
-		case RK_PINCTRL_PULL_PIN_DEFAULT:
-			bias =3D PIN_CONFIG_BIAS_PULL_PIN_DEFAULT;
-			break;
-		case RK_PINCTRL_PULL_UP:
-			bias =3D PIN_CONFIG_BIAS_PULL_UP;
-			break;
-		case RK_PINCTRL_PULL_DOWN:
-			bias =3D PIN_CONFIG_BIAS_PULL_DOWN;
-			break;
-		}
 =

-		grp->configs[j] =3D pinconf_to_config_packed(bias, 0);
+		ret =3D pinconf_generic_parse_dt_bitmap(pinconf, =

+				    &grp->configs[j], &nconfigs);
+		if (ret)
+			return ret;
+
+		if (nconfigs !=3D 1) {
+			pr_err("unexpected number of config entries\n");
+			return -EINVAL;
+		}
 	}
 =

 	return 0;
