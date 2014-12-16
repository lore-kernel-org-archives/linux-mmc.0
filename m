From: David =?utf-8?q?Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>
Subject: [PATCH 3/4] mmc: sunxi: Reset behavior fix
Date: Tue, 16 Dec 2014 01:37:56 +0100
Message-ID: <20141216003756.15488.34861.stgit@dizzy-6.o2s.ch>
References: <20141216003412.15488.54812.stgit@dizzy-6.o2s.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141216003412.15488.54812.stgit@dizzy-6.o2s.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, Peter Griffin <peter.griffin@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, David =?utf-8?q?Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, =?utf-8?b?5p2O5oOz?= <lixiang@allwinnertech.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

When there is only one DES available the DMA performs a FIFO reset and =
waits until the reinitialization has been completed.
Disabling the SDXC_IDMAC_DES0_DIC bit prevents the DMA from sending an =
interrupt after it has finished this reinitialization.

The flags SDXC_IDMAC_DES0_FD and SDXC_IDMAC_DES0_LD are both required i=
n order to use the controller with more than one DES.

Signed-off-by: David Lanzend=C3=B6rfer <david.lanzendoerfer@o2s.ch>
Reported-by: =E6=9D=8E=E6=83=B3 <lixiang@allwinnertech.com>
---
 drivers/mmc/host/sunxi-mmc.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.=
c
index 50bd3d2..5331c88 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -310,7 +310,17 @@ static void sunxi_mmc_init_idma_des(struct sunxi_m=
mc_host *host,
 	}
=20
 	pdes[0].config |=3D SDXC_IDMAC_DES0_FD;
-	pdes[i - 1].config =3D SDXC_IDMAC_DES0_OWN | SDXC_IDMAC_DES0_LD;
+
+	/*
+	 * When there is only one DES available the DMA performs a FIFO reset=
 and waits
+	 * until the reinitialization has been completed.
+	 * Disabling the SDXC_IDMAC_DES0_DIC bit prevents the DMA from sendin=
g an interrupt
+	 * after it has finished this reinitialization.
+	 */
+	pdes[i - 1].config =3D SDXC_IDMAC_DES0_OWN;
+	pdes[i - 1].config |=3D SDXC_IDMAC_DES0_FD;
+	pdes[i - 1].config |=3D SDXC_IDMAC_DES0_LD;
+	pdes[i - 1].config &=3D ~SDXC_IDMAC_DES0_DIC;
=20
 	/*
 	 * Avoid the io-store starting the idmac hitting io-mem before the
