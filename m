From: David =?utf-8?q?Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>
Subject: [PATCH 4/4] mmc: sunxi: Removing unused code
Date: Tue, 16 Dec 2014 15:11:15 +0100
Message-ID: <20141216141115.3036.96031.stgit@dizzy-6.o2s.ch>
References: <20141216140921.3036.14668.stgit@dizzy-6.o2s.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141216140921.3036.14668.stgit@dizzy-6.o2s.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, Peter Griffin <peter.griffin@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, David =?utf-8?q?Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, =?utf-8?b?5p2O5oOz?= <lixiang@allwinnertech.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Removing a relict from reverse engineering of the Android driver code i=
n
sunxi_mmc_clk_set_rate.

Signed-off-by: David Lanzend=C3=B6rfer <david.lanzendoerfer@o2s.ch>
Reported-by: =E6=9D=8E=E6=83=B3 <lixiang@allwinnertech.com>
---
 drivers/mmc/host/sunxi-mmc.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.=
c
index 695fe85..6af0a28 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -627,7 +627,7 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_ho=
st *host, u32 oclk_en)
 static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 				  struct mmc_ios *ios)
 {
-	u32 rate, oclk_dly, rval, sclk_dly, src_clk;
+	u32 rate, oclk_dly, rval, sclk_dly;
 	int ret;
=20
 	rate =3D clk_round_rate(host->clk_mmc, ios->clock);
@@ -672,14 +672,6 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc=
_host *host,
 		sclk_dly =3D 4;
 	}
=20
-	src_clk =3D clk_get_rate(clk_get_parent(host->clk_mmc));
-	if (src_clk >=3D 300000000 && src_clk <=3D 400000000) {
-		if (oclk_dly)
-			oclk_dly--;
-		if (sclk_dly)
-			sclk_dly--;
-	}
-
 	clk_sunxi_mmc_phase_control(host->clk_mmc, sclk_dly, oclk_dly);
=20
 	return sunxi_mmc_oclk_onoff(host, 1);
