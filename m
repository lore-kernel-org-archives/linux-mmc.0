From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Subject: [PATCH v3 2/7] mmc: dw_mmc-pltfm: remove static from dw_mci_pltfm_remove
Date: Tue, 11 Jun 2013 13:29:56 +0200
Message-ID: <201306111329.57149.heiko@sntech.de>
References: <201306111328.52679.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201306111328.52679.heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Linus Walleij <linus.walleij@linaro.org>, devicetree-discuss@lists.ozlabs.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-mmc@vger.kernel.org

dw_mci_pltfm_remove gets exported and used by dw_mmc-exynos, so should
not be static.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc-pltfm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 37873f1..0048da8 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -68,7 +68,7 @@ static int dw_mci_pltfm_probe(struct platform_device *pdev)
 	return dw_mci_pltfm_register(pdev, NULL);
 }
 
-static int dw_mci_pltfm_remove(struct platform_device *pdev)
+int dw_mci_pltfm_remove(struct platform_device *pdev)
 {
 	struct dw_mci *host = platform_get_drvdata(pdev);
 
-- 
1.7.2.3
