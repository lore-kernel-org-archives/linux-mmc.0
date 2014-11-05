From: =?UTF-8?q?Kristina=20Mart=C5=A1enko?=
	<kristina.martsenko@gmail.com>
Subject: [PATCH] mmc: core: fix card detection regression
Date: Wed,  5 Nov 2014 02:22:41 +0200
Message-ID: <1415146961-25993-1-git-send-email-kristina.martsenko@gmail.com>
References: <1747777414.897866.1414878004147.JavaMail.open-xchange@oxbsltgw09.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1747777414.897866.1414878004147.JavaMail.open-xchange@oxbsltgw09.schlund.de>
Sender: linux-gpio-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Stefan Wahren <stefan.wahren@i2se.com>, Fabio Estevam <festevam@gmail.com>, Michael Heimpold <mhei@heimpold.de>, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Since commit 89168b489915 ("mmc: core: restore detect line inversion
semantics"), the SD card on i.MX28 (and possibly other) devices isn't
detected and booting stops at:

[    4.120617] Waiting for root device /dev/mmcblk0p3...

This is caused by the MMC_CAP2_CD_ACTIVE_HIGH flag being set incorrectl=
y
when the host controller doesn't use a GPIO for card detection (but
instead uses a dedicated pin). In this case mmc_gpiod_request_cd() will
return before assigning to the gpio_invert variable, leaving the
variable uninitialized. The variable then gets used to set the flag.
This patch fixes the issue by making sure gpio_invert is set to false
when a GPIO isn't used. After this patch, i.MX28 boots fine.

The MMC_CAP2_RO_ACTIVE_HIGH (write protect) flag is also set incorrectl=
y
for the exact same reason (it uses the same uninitialized variable), so
this patch fixes that too.

=46ixes: 89168b489915 ("mmc: core: restore detect line inversion semant=
ics")
Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Kristina Mart=C5=A1enko <kristina.martsenko@gmail.com>
---
This is a different version of the previous patch [1], so I haven't
included the Reviewed-by and Tested-by's. Would be nice if someone coul=
d
test this version as well.

[1] http://thread.gmane.org/gmane.linux.kernel.gpio/4609/focus=3D29576

 drivers/mmc/core/host.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 03c53b72a2d6..270d58a4c43d 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -311,7 +311,8 @@ int mmc_of_parse(struct mmc_host *host)
 	struct device_node *np;
 	u32 bus_width;
 	int len, ret;
-	bool cap_invert, gpio_invert;
+	bool cd_cap_invert, cd_gpio_invert =3D false;
+	bool ro_cap_invert, ro_gpio_invert =3D false;
=20
 	if (!host->parent || !host->parent->of_node)
 		return 0;
@@ -359,16 +360,13 @@ int mmc_of_parse(struct mmc_host *host)
 	if (of_find_property(np, "non-removable", &len)) {
 		host->caps |=3D MMC_CAP_NONREMOVABLE;
 	} else {
-		if (of_property_read_bool(np, "cd-inverted"))
-			cap_invert =3D true;
-		else
-			cap_invert =3D false;
+		cd_cap_invert =3D of_property_read_bool(np, "cd-inverted");
=20
 		if (of_find_property(np, "broken-cd", &len))
 			host->caps |=3D MMC_CAP_NEEDS_POLL;
=20
 		ret =3D mmc_gpiod_request_cd(host, "cd", 0, true,
-					   0, &gpio_invert);
+					   0, &cd_gpio_invert);
 		if (ret) {
 			if (ret =3D=3D -EPROBE_DEFER)
 				return ret;
@@ -391,17 +389,14 @@ int mmc_of_parse(struct mmc_host *host)
 		 * both inverted, the end result is that the CD line is
 		 * not inverted.
 		 */
-		if (cap_invert ^ gpio_invert)
+		if (cd_cap_invert ^ cd_gpio_invert)
 			host->caps2 |=3D MMC_CAP2_CD_ACTIVE_HIGH;
 	}
=20
 	/* Parse Write Protection */
-	if (of_property_read_bool(np, "wp-inverted"))
-		cap_invert =3D true;
-	else
-		cap_invert =3D false;
+	ro_cap_invert =3D of_property_read_bool(np, "wp-inverted");
=20
-	ret =3D mmc_gpiod_request_ro(host, "wp", 0, false, 0, &gpio_invert);
+	ret =3D mmc_gpiod_request_ro(host, "wp", 0, false, 0, &ro_gpio_invert=
);
 	if (ret) {
 		if (ret =3D=3D -EPROBE_DEFER)
 			goto out;
@@ -414,7 +409,7 @@ int mmc_of_parse(struct mmc_host *host)
 		dev_info(host->parent, "Got WP GPIO\n");
=20
 	/* See the comment on CD inversion above */
-	if (cap_invert ^ gpio_invert)
+	if (ro_cap_invert ^ ro_gpio_invert)
 		host->caps2 |=3D MMC_CAP2_RO_ACTIVE_HIGH;
=20
 	if (of_find_property(np, "cap-sd-highspeed", &len))
--=20
2.0.2

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
