From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: [PATCH 1/3] ARM: davinci: da850: override mmc DT node device name
Date: Thu, 31 Jan 2013 16:03:05 +0530
Message-ID: <1359628387-14437-2-git-send-email-prakash.pm@ti.com>
References: <1359628387-14437-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1359628387-14437-1-git-send-email-prakash.pm@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, nsekhar@ti.com, hs@denx.de, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, davinci-linux-open-source@linux.davincidsp.com, mporter@ti.com, ido@wizery.com, gregkh@linuxfoundation.org, "Manjunathappa, Prakash" <prakash.pm@ti.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Populate OF_DEV_AUXDATA with desired device name expected by
davinci_mmc driver. Without this clk_get of davinci_mmc DT driver
fails.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
Cc: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: davinci-linux-open-source@linux.davincidsp.com
Cc: devicetree-discuss@lists.ozlabs.org
Cc: cjb@laptop.org
Cc: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/da8xx-dt.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 37c27af..c623db0 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -39,9 +39,15 @@ static void __init da8xx_init_irq(void)
 
 #ifdef CONFIG_ARCH_DAVINCI_DA850
 
+static const struct of_dev_auxdata da8xx_auxdata[] __initconst = {
+	OF_DEV_AUXDATA("ti,davinci_mmc", 0x01c40000, "davinci_mmc.0", NULL),
+	{},
+};
+
 static void __init da850_init_machine(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, da8xx_auxdata,
+			NULL);
 
 	da8xx_uart_clk_enable();
 }
-- 
1.7.4.1

