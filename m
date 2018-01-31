From: Ulf Magnusson <ulfalizer@gmail.com>
Subject: [PATCH 03/11] mmc: kconfig: Remove blank help text
Date: Wed, 31 Jan 2018 10:34:22 +0100
Message-ID: <20180131093434.20050-4-ulfalizer@gmail.com>
References: <20180131093434.20050-1-ulfalizer@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180131093434.20050-1-ulfalizer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com, mcgrof@kernel.org, rdunlap@infradead.org, dan.carpenter@oracle.com, pebolle@tiscali.nl, Ulf Magnusson <ulfalizer@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Shawn Lin <shawn.lin@rock-chips.com>, Simon Horman <horms+renesas@verge.net.au>, Jan Glauber <jglauber@cavium.com>, Eric Anholt <eric@anholt.net>, Carlo Caione <carlo@endlessm.com>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Kishon Vijay Abraham I <kishon@ti.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rui Feng <rui_feng@realsil.com.cn>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Blank help texts are probably either a typo, a Kconfig misunderstanding,
or some kind of half-committing to adding a help text (in which case a
TODO comment would be clearer, if the help text really can't be added
right away).

Best to remove them, IMO.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 drivers/mmc/host/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 67bd3344dd03..24dee8eb5270 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -874,7 +874,6 @@ config MMC_CQHCI
 config MMC_TOSHIBA_PCI
 	tristate "Toshiba Type A SD/MMC Card Interface Driver"
 	depends on PCI
-	help
 
 config MMC_BCM2835
 	tristate "Broadcom BCM2835 SDHOST MMC Controller support"
-- 
2.14.1
