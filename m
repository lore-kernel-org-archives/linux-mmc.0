From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 01/12] ARM: OMAP2+: Select PINCTRL_TI_IODELAY for SOC_DRA7XX
Date: Fri, 16 Jun 2017 17:24:28 +0530
Message-ID: <20170616115439.8508-2-kishon@ti.com>
References: <20170616115439.8508-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170616115439.8508-1-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, nsekhar@ti.com
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, kishon@ti.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

PINCTRL_TI_IODELAY should be enabled so that "pinctrl_dev" can be created
for pinctrl entries populated with iodelay values in device tree data.
Select PINCTRL_TI_IODELAY for SOC_DRA7XX here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap2/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 0465338183c7..e31a5a22e171 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -87,6 +87,7 @@ config SOC_DRA7XX
 	select OMAP_INTERCONNECT_BARRIER
 	select PM_OPP if PM
 	select ZONE_DMA if ARM_LPAE
+	select PINCTRL_TI_IODELAY if OF && PINCTRL
 
 config ARCH_OMAP2PLUS
 	bool
-- 
2.11.0
