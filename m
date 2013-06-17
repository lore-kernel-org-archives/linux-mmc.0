From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v10 1/2] ARM: davinci: move private EDMA API to arm/common
Date: Mon, 17 Jun 2013 15:36:10 +0530
Message-ID: <1371463571-2578-2-git-send-email-nsekhar@ti.com>
References: <1371463571-2578-1-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1371463571-2578-1-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Joel Fernandes A <joelagnel-l0cyMroinI0@public.gmane.org>, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>

Move mach-davinci/dma.c to common/edma.c so it can be used
by OMAP (specifically AM33xx) as well.

Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Acked-by: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org> # davinci_mmc.c
[nsekhar-l0cyMroinI0@public.gmane.org: dropped davinci sffsdr changes]
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/Kconfig                                   |    1 +
 arch/arm/common/Kconfig                            |    3 +
 arch/arm/common/Makefile                           |    1 +
 arch/arm/{mach-davinci/dma.c => common/edma.c}     |    2 +-
 arch/arm/mach-davinci/Makefile                     |    2 +-
 arch/arm/mach-davinci/board-tnetv107x-evm.c        |    2 +-
 arch/arm/mach-davinci/davinci.h                    |    2 +-
 arch/arm/mach-davinci/devices-tnetv107x.c          |    2 +-
 arch/arm/mach-davinci/devices.c                    |    6 +-
 arch/arm/mach-davinci/dm355.c                      |    2 +-
 arch/arm/mach-davinci/dm365.c                      |    2 +-
 arch/arm/mach-davinci/dm644x.c                     |    2 +-
 arch/arm/mach-davinci/dm646x.c                     |    2 +-
 arch/arm/mach-davinci/include/mach/da8xx.h         |    2 +-
 drivers/dma/edma.c                                 |    2 +-
 drivers/mmc/host/davinci_mmc.c                     |    1 +
 include/linux/mfd/davinci_voicecodec.h             |    3 +-
 .../mach => include/linux/platform_data}/edma.h    |   89 +-------------------
 include/linux/platform_data/spi-davinci.h          |    2 +-
 sound/soc/davinci/davinci-evm.c                    |    1 +
 sound/soc/davinci/davinci-pcm.c                    |    1 +
 sound/soc/davinci/davinci-pcm.h                    |    2 +-
 22 files changed, 29 insertions(+), 103 deletions(-)
 rename arch/arm/{mach-davinci/dma.c => common/edma.c} (99%)
 rename {arch/arm/mach-davinci/include/mach => include/linux/platform_data}/edma.h (59%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 49d993c..b1c66a4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -840,6 +840,7 @@ config ARCH_DAVINCI
 	select GENERIC_IRQ_CHIP
 	select HAVE_IDE
 	select NEED_MACH_GPIO_H
+	select TI_PRIV_EDMA
 	select USE_OF
 	select ZONE_DMA
 	help
diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index 9353184..c3a4e9c 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -17,3 +17,6 @@ config SHARP_PARAM
 
 config SHARP_SCOOP
 	bool
+
+config TI_PRIV_EDMA
+	bool
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 48434cb..8c60f47 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
 obj-$(CONFIG_MCPM)		+= mcpm_head.o mcpm_entry.o mcpm_platsmp.o vlock.o
 AFLAGS_mcpm_head.o		:= -march=armv7-a
 AFLAGS_vlock.o			:= -march=armv7-a
+obj-$(CONFIG_TI_PRIV_EDMA)	+= edma.o
diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/common/edma.c
similarity index 99%
rename from arch/arm/mach-davinci/dma.c
rename to arch/arm/common/edma.c
index 45b7c71..dcaeb8e 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/common/edma.c
@@ -25,7 +25,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 
-#include <mach/edma.h>
+#include <linux/platform_data/edma.h>
 
 /* Offsets matching "struct edmacc_param" */
 #define PARM_OPT		0x00
diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index dd1ffcc..63997a1 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -5,7 +5,7 @@
 
 # Common objects
 obj-y 			:= time.o clock.o serial.o psc.o \
-			   dma.o usb.o common.o sram.o aemif.o
+			   usb.o common.o sram.o aemif.o
 
 obj-$(CONFIG_DAVINCI_MUX)		+= mux.o
 
diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index ba79837..78ea395 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -26,12 +26,12 @@
 #include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/spi/spi.h>
+#include <linux/platform_data/edma.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
 #include <mach/irqs.h>
-#include <mach/edma.h>
 #include <mach/mux.h>
 #include <mach/cp_intc.h>
 #include <mach/tnetv107x.h>
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index b4b7451..a883043 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -23,9 +23,9 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/platform_data/davinci_asp.h>
+#include <linux/platform_data/edma.h>
 #include <linux/platform_data/keyscan-davinci.h>
 #include <mach/hardware.h>
-#include <mach/edma.h>
 
 #include <media/davinci/vpfe_capture.h>
 #include <media/davinci/vpif_types.h>
diff --git a/arch/arm/mach-davinci/devices-tnetv107x.c b/arch/arm/mach-davinci/devices-tnetv107x.c
index cfb194d..612a085 100644
--- a/arch/arm/mach-davinci/devices-tnetv107x.c
+++ b/arch/arm/mach-davinci/devices-tnetv107x.c
@@ -18,10 +18,10 @@
 #include <linux/dma-mapping.h>
 #include <linux/clk.h>
 #include <linux/slab.h>
+#include <linux/platform_data/edma.h>
 
 #include <mach/common.h>
 #include <mach/irqs.h>
-#include <mach/edma.h>
 #include <mach/tnetv107x.h>
 
 #include "clock.h"
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index a7068a3..90b83d0 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -19,9 +19,10 @@
 #include <mach/irqs.h>
 #include <mach/cputype.h>
 #include <mach/mux.h>
-#include <mach/edma.h>
 #include <linux/platform_data/mmc-davinci.h>
 #include <mach/time.h>
+#include <linux/platform_data/edma.h>
+
 
 #include "davinci.h"
 #include "clock.h"
@@ -34,6 +35,9 @@
 #define DM365_MMCSD0_BASE	     0x01D11000
 #define DM365_MMCSD1_BASE	     0x01D00000
 
+#define DAVINCI_DMA_MMCRXEVT	26
+#define DAVINCI_DMA_MMCTXEVT	27
+
 void __iomem  *davinci_sysmod_base;
 
 void davinci_map_sysmod(void)
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index a11034a..526cf7d 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -19,7 +19,6 @@
 #include <asm/mach/map.h>
 
 #include <mach/cputype.h>
-#include <mach/edma.h>
 #include <mach/psc.h>
 #include <mach/mux.h>
 #include <mach/irqs.h>
@@ -28,6 +27,7 @@
 #include <mach/common.h>
 #include <linux/platform_data/spi-davinci.h>
 #include <mach/gpio-davinci.h>
+#include <linux/platform_data/edma.h>
 
 #include "davinci.h"
 #include "clock.h"
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 40fa4fe..c4b7411 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -18,11 +18,11 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/spi/spi.h>
+#include <linux/platform_data/edma.h>
 
 #include <asm/mach/map.h>
 
 #include <mach/cputype.h>
-#include <mach/edma.h>
 #include <mach/psc.h>
 #include <mach/mux.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 4d37d3e..dd156d5 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -12,11 +12,11 @@
 #include <linux/clk.h>
 #include <linux/serial_8250.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/edma.h>
 
 #include <asm/mach/map.h>
 
 #include <mach/cputype.h>
-#include <mach/edma.h>
 #include <mach/irqs.h>
 #include <mach/psc.h>
 #include <mach/mux.h>
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index ac7b431..6d52a32 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -13,11 +13,11 @@
 #include <linux/clk.h>
 #include <linux/serial_8250.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/edma.h>
 
 #include <asm/mach/map.h>
 
 #include <mach/cputype.h>
-#include <mach/edma.h>
 #include <mach/irqs.h>
 #include <mach/psc.h>
 #include <mach/mux.h>
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index faec783..3c797e2 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -20,8 +20,8 @@
 #include <linux/videodev2.h>
 
 #include <mach/serial.h>
-#include <mach/edma.h>
 #include <mach/pm.h>
+#include <linux/platform_data/edma.h>
 #include <linux/platform_data/i2c-davinci.h>
 #include <linux/platform_data/mmc-davinci.h>
 #include <linux/platform_data/usb-davinci.h>
diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index cd7e328..5f3e532 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -24,7 +24,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
-#include <mach/edma.h>
+#include <linux/platform_data/edma.h>
 
 #include "dmaengine.h"
 #include "virt-dma.h"
diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 3946a0e..5dfb70c 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -37,6 +37,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 
+#include <linux/platform_data/edma.h>
 #include <linux/platform_data/mmc-davinci.h>
 
 /*
diff --git a/include/linux/mfd/davinci_voicecodec.h b/include/linux/mfd/davinci_voicecodec.h
index 0ab6132..7dd6524 100644
--- a/include/linux/mfd/davinci_voicecodec.h
+++ b/include/linux/mfd/davinci_voicecodec.h
@@ -26,8 +26,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/core.h>
-
-#include <mach/edma.h>
+#include <linux/platform_data/edma.h>
 
 /*
  * Register values.
diff --git a/arch/arm/mach-davinci/include/mach/edma.h b/include/linux/platform_data/edma.h
similarity index 59%
rename from arch/arm/mach-davinci/include/mach/edma.h
rename to include/linux/platform_data/edma.h
index 7e84c90..2344ea2 100644
--- a/arch/arm/mach-davinci/include/mach/edma.h
+++ b/include/linux/platform_data/edma.h
@@ -1,28 +1,12 @@
 /*
- *  TI DAVINCI dma definitions
+ *  TI EDMA definitions
  *
- *  Copyright (C) 2006-2009 Texas Instruments.
+ *  Copyright (C) 2006-2013 Texas Instruments.
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
  *  Free Software Foundation;  either version 2 of the  License, or (at your
  *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
  */
 
 /*
@@ -69,11 +53,6 @@ struct edmacc_param {
 	unsigned int ccnt;
 };
 
-#define CCINT0_INTERRUPT     16
-#define CCERRINT_INTERRUPT   17
-#define TCERRINT0_INTERRUPT   18
-#define TCERRINT1_INTERRUPT   19
-
 /* fields in edmacc_param.opt */
 #define SAM		BIT(0)
 #define DAM		BIT(1)
@@ -87,70 +66,6 @@ struct edmacc_param {
 #define TCCHEN		BIT(22)
 #define ITCCHEN		BIT(23)
 
-#define TRWORD (0x7<<2)
-#define PAENTRY (0x1ff<<5)
-
-/* Drivers should avoid using these symbolic names for dm644x
- * channels, and use platform_device IORESOURCE_DMA resources
- * instead.  (Other DaVinci chips have different peripherals
- * and thus have different DMA channel mappings.)
- */
-#define DAVINCI_DMA_MCBSP_TX              2
-#define DAVINCI_DMA_MCBSP_RX              3
-#define DAVINCI_DMA_VPSS_HIST             4
-#define DAVINCI_DMA_VPSS_H3A              5
-#define DAVINCI_DMA_VPSS_PRVU             6
-#define DAVINCI_DMA_VPSS_RSZ              7
-#define DAVINCI_DMA_IMCOP_IMXINT          8
-#define DAVINCI_DMA_IMCOP_VLCDINT         9
-#define DAVINCI_DMA_IMCO_PASQINT         10
-#define DAVINCI_DMA_IMCOP_DSQINT         11
-#define DAVINCI_DMA_SPI_SPIX             16
-#define DAVINCI_DMA_SPI_SPIR             17
-#define DAVINCI_DMA_UART0_URXEVT0        18
-#define DAVINCI_DMA_UART0_UTXEVT0        19
-#define DAVINCI_DMA_UART1_URXEVT1        20
-#define DAVINCI_DMA_UART1_UTXEVT1        21
-#define DAVINCI_DMA_UART2_URXEVT2        22
-#define DAVINCI_DMA_UART2_UTXEVT2        23
-#define DAVINCI_DMA_MEMSTK_MSEVT         24
-#define DAVINCI_DMA_MMCRXEVT             26
-#define DAVINCI_DMA_MMCTXEVT             27
-#define DAVINCI_DMA_I2C_ICREVT           28
-#define DAVINCI_DMA_I2C_ICXEVT           29
-#define DAVINCI_DMA_GPIO_GPINT0          32
-#define DAVINCI_DMA_GPIO_GPINT1          33
-#define DAVINCI_DMA_GPIO_GPINT2          34
-#define DAVINCI_DMA_GPIO_GPINT3          35
-#define DAVINCI_DMA_GPIO_GPINT4          36
-#define DAVINCI_DMA_GPIO_GPINT5          37
-#define DAVINCI_DMA_GPIO_GPINT6          38
-#define DAVINCI_DMA_GPIO_GPINT7          39
-#define DAVINCI_DMA_GPIO_GPBNKINT0       40
-#define DAVINCI_DMA_GPIO_GPBNKINT1       41
-#define DAVINCI_DMA_GPIO_GPBNKINT2       42
-#define DAVINCI_DMA_GPIO_GPBNKINT3       43
-#define DAVINCI_DMA_GPIO_GPBNKINT4       44
-#define DAVINCI_DMA_TIMER0_TINT0         48
-#define DAVINCI_DMA_TIMER1_TINT1         49
-#define DAVINCI_DMA_TIMER2_TINT2         50
-#define DAVINCI_DMA_TIMER3_TINT3         51
-#define DAVINCI_DMA_PWM0                 52
-#define DAVINCI_DMA_PWM1                 53
-#define DAVINCI_DMA_PWM2                 54
-
-/* DA830 specific EDMA3 information */
-#define EDMA_DA830_NUM_DMACH		32
-#define EDMA_DA830_NUM_TCC		32
-#define EDMA_DA830_NUM_PARAMENTRY	128
-#define EDMA_DA830_NUM_EVQUE		2
-#define EDMA_DA830_NUM_TC		2
-#define EDMA_DA830_CHMAP_EXIST		0
-#define EDMA_DA830_NUM_REGIONS		4
-#define DA830_DMACH2EVENT_MAP0		0x000FC03Fu
-#define DA830_DMACH2EVENT_MAP1		0x00000000u
-#define DA830_EDMA_ARM_OWN		0x30FFCCFFu
-
 /*ch_status paramater of callback function possible values*/
 #define DMA_COMPLETE 1
 #define DMA_CC_ERROR 2
diff --git a/include/linux/platform_data/spi-davinci.h b/include/linux/platform_data/spi-davinci.h
index 7af305b..8dc2fa47 100644
--- a/include/linux/platform_data/spi-davinci.h
+++ b/include/linux/platform_data/spi-davinci.h
@@ -19,7 +19,7 @@
 #ifndef __ARCH_ARM_DAVINCI_SPI_H
 #define __ARCH_ARM_DAVINCI_SPI_H
 
-#include <mach/edma.h>
+#include <linux/platform_data/edma.h>
 
 #define SPI_INTERN_CS	0xFF
 
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 484b22c..fd7c45b 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -14,6 +14,7 @@
 #include <linux/timer.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/edma.h>
 #include <linux/i2c.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index b2f27c2..8460edc 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -17,6 +17,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/kernel.h>
 #include <linux/genalloc.h>
+#include <linux/platform_data/edma.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/davinci/davinci-pcm.h b/sound/soc/davinci/davinci-pcm.h
index b6ef703..fbb710c 100644
--- a/sound/soc/davinci/davinci-pcm.h
+++ b/sound/soc/davinci/davinci-pcm.h
@@ -14,7 +14,7 @@
 
 #include <linux/genalloc.h>
 #include <linux/platform_data/davinci_asp.h>
-#include <mach/edma.h>
+#include <linux/platform_data/edma.h>
 
 struct davinci_pcm_dma_params {
 	int channel;			/* sync dma channel ID */
-- 
1.7.10.1
