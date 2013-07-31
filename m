From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH] mmc: tmio-mmc: Check the regulator_enable() return value
Date: Wed, 31 Jul 2013 16:18:31 +0200
Message-ID: <1375280311-6003-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

The regulator_enable() function is marked with __must_check, check its
return value and return an error in case of failure. This removes the
following warning during kernel compilation:

drivers/mmc/host/tmio_mmc_pio.c: In function =E2=80=98tmio_mmc_power_on=
=E2=80=99:
drivers/mmc/host/tmio_mmc_pio.c:795:19: warning: ignoring return value
of =E2=80=98regulator_enable=E2=80=99, declared with attribute warn_unu=
sed_result
[-Wunused-result]

The error isn't propagated back to the MMC core, as the .set_ios()
operation in which the regulator is enabled doesn't have a return value=
=2E
This should be fixed as well.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.=
com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mm=
c_pio.c
index 4675513..e3e2645 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -770,15 +770,18 @@ static int tmio_mmc_clk_update(struct mmc_host *m=
mc)
 	return ret;
 }
=20
-static void tmio_mmc_power_on(struct tmio_mmc_host *host, unsigned sho=
rt vdd)
+static int tmio_mmc_power_on(struct tmio_mmc_host *host, unsigned shor=
t vdd)
 {
 	struct mmc_host *mmc =3D host->mmc;
-	int ret =3D 0;
+	int ret;
=20
 	/* .set_ios() is returning void, so, no chance to report an error */
=20
 	if (!IS_ERR(mmc->supply.vmmc)) {
 		ret =3D mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+		if (ret < 0)
+			return ret;
+
 		/*
 		 * Attention: empiric value. With a b43 WiFi SDIO card this
 		 * delay proved necessary for reliable card-insertion probing.
@@ -791,10 +794,15 @@ static void tmio_mmc_power_on(struct tmio_mmc_hos=
t *host, unsigned short vdd)
 	 * It seems, VccQ should be switched on after Vcc, this is also what =
the
 	 * omap_hsmmc.c driver does.
 	 */
-	if (!IS_ERR(mmc->supply.vqmmc) && !ret) {
-		regulator_enable(mmc->supply.vqmmc);
+	if (!IS_ERR(mmc->supply.vqmmc)) {
+		ret =3D regulator_enable(mmc->supply.vqmmc);
+		if (ret < 0)
+			return ret;
+
 		udelay(200);
 	}
+
+	return 0;
 }
=20
 static void tmio_mmc_power_off(struct tmio_mmc_host *host)
--=20
1.8.1.5

