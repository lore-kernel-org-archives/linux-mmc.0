From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 08/16] sh: kfr2r09: use MMC_CAP2_NO_WRITE_PROTECT instead of TMIO own flag
Date: Thu, 18 Jan 2018 01:28:08 +0900
Message-ID: <1516206496-16612-9-git-send-email-yamada.masahiro@socionext.com>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

TMIO_MMC_WRPROTECT_DISABLE is equivalent to MMC_CAP2_NO_WRITE_PROTECT.

The flag is propagated as follows:
    tmio_mmc_data::capabilities2 -> mmc_host::caps2

Only the difference is the TMIO_... makes tmio_mmc_get_ro() return 0
(i.e. it does not affect mmc_gpio_get_ro() at all), while MMC_CAP2_...
returns 0 before calling ->get_ro() hook (i.e. it affects both IP own
logic and GPIO detection).

The TMIO MMC drivers do not set-up gpio_ro by themselves, so gpio_ro
is obviously unused by legacy boards like this.  So, this conversion
should be safe.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - newly added

Changes in v2: None

 arch/sh/boards/mach-kfr2r09/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 5deb2d8..6af7777 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -375,8 +375,8 @@ static struct resource kfr2r09_sh_sdhi0_resources[] = {
 static struct tmio_mmc_data sh7724_sdhi0_data = {
 	.chan_priv_tx	= (void *)SHDMA_SLAVE_SDHI0_TX,
 	.chan_priv_rx	= (void *)SHDMA_SLAVE_SDHI0_RX,
-	.flags		= TMIO_MMC_WRPROTECT_DISABLE,
 	.capabilities	= MMC_CAP_SDIO_IRQ,
+	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT,
 };
 
 static struct platform_device kfr2r09_sh_sdhi0_device = {
-- 
2.7.4
