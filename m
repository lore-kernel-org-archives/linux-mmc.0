From: David =?utf-8?q?Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>
Subject: [PATCH 2/4] mmc: sunxi: Correcting SDXC_HARDWARE_RESET bit
Date: Tue, 16 Dec 2014 01:37:51 +0100
Message-ID: <20141216003750.15488.23791.stgit@dizzy-6.o2s.ch>
References: <20141216003412.15488.54812.stgit@dizzy-6.o2s.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from c-82-192-226-27.customer.ggaweb.ch ([82.192.226.27]:33670 "EHLO
	dizzy-6.o2s.ch" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752668AbaLPAoJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Dec 2014 19:44:09 -0500
In-Reply-To: <20141216003412.15488.54812.stgit@dizzy-6.o2s.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, Peter Griffin <peter.griffin@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, David =?utf-8?q?Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, =?utf-8?b?5p2O5oOz?= <lixiang@allwinnertech.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org

=46ixing the register name in sunxi_mmc_reset_host since the SDXC_HARDW=
ARE_RESET bit
is actually located within REG_GCTRL and not REG_CMDR as it was pointed=
 out by Allwinner.

Signed-off-by: David Lanzend=C3=B6rfer <david.lanzendoerfer@o2s.ch>
Reported-by: =E6=9D=8E=E6=83=B3 <lixiang@allwinnertech.com>
---
 drivers/mmc/host/sunxi-mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.=
c
index 25ba321..50bd3d2 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -252,7 +252,7 @@ static int sunxi_mmc_reset_host(struct sunxi_mmc_ho=
st *host)
 	unsigned long expire =3D jiffies + msecs_to_jiffies(250);
 	u32 rval;
=20
-	mmc_writel(host, REG_CMDR, SDXC_HARDWARE_RESET);
+	mmc_writel(host, REG_GCTRL, SDXC_HARDWARE_RESET);
 	do {
 		rval =3D mmc_readl(host, REG_GCTRL);
 	} while (time_before(jiffies, expire) && (rval & SDXC_HARDWARE_RESET)=
);

