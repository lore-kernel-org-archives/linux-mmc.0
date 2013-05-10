From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH] ARM: mmc: bcm281xx SDHCI driver
Date: Fri, 10 May 2013 16:37:01 +0200
Message-ID: <20130510143701.GC22508@game.jcrosoft.org>
References: <1368078942-31265-1-git-send-email-csd@broadcom.com>
 <20130509063503.GF3041@game.jcrosoft.org>
 <518CA1DF.5050008@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <518CA1DF.5050008@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christian Daudt <csd@broadcom.com>
Cc: csd_b@daudt.org, Stephen Warren <swarren@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Wei WANG <wei_wang@realsil.com.cn>, Ludovic Desroches <ludovic.desroches@atmel.com>, "Mike A. Chan" <mikechan@google.com>, Rob Landley <rob@landley.net>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 00:29 Fri 10 May     , Christian Daudt wrote:
> Thanks for the feedback.
> 
> On 13-05-08 11:35 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >On 22:55 Wed 08 May     , Christian Daudt wrote:
> >>Add SDHCI driver for the Broadcom 281xx SoCs. Also
> >>add bindings for it into bcm281xx dts files.
> >>Still missing:
> >>  - power managemement
> >split the dts/dtsi in an other patch
> ok.
> >>Signed-off-by: Christian Daudt <csd@broadcom.com>
> >>
> >>diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
> >>index e3bf2d6..65edf6d 100644
> >>--- a/arch/arm/configs/bcm_defconfig
> >>+++ b/arch/arm/configs/bcm_defconfig
> >>@@ -78,6 +78,13 @@ CONFIG_BACKLIGHT_LCD_SUPPORT=y
> >>  CONFIG_LCD_CLASS_DEVICE=y
> >>  CONFIG_BACKLIGHT_CLASS_DEVICE=y
> >>  # CONFIG_USB_SUPPORT is not set
> >>+CONFIG_MMC=y
> >>+CONFIG_MMC_UNSAFE_RESUME=y
> >>+CONFIG_MMC_BLOCK_MINORS=32
> >>+CONFIG_MMC_TEST=y
> >>+CONFIG_MMC_SDHCI=y
> >>+CONFIG_MMC_SDHCI_PLTFM=y
> >>+CONFIG_MMC_SDHCI_BCM_KONA=y
> >>  CONFIG_NEW_LEDS=y
> >>  CONFIG_LEDS_CLASS=y
> >>  CONFIG_LEDS_TRIGGERS=y
> >>diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> >>index d88219e..e067c5a 100644
> >>--- a/drivers/mmc/host/Kconfig
> >>+++ b/drivers/mmc/host/Kconfig
> >>@@ -238,6 +238,16 @@ config MMC_SDHCI_S3C_DMA
> >>  	  YMMV.
> >>+config MMC_SDHCI_BCM_KONA
> >>+	tristate "SDHCI support on Broadcom KONA platform"
> >>+	depends on ARCH_BCM && MMC_SDHCI_PLTFM
> >select MMC_SDHCI_PLTFM
> >will be better
> Ok - changed it. Why is the select is better than the depends ?

so you do not need to enable MMC_SDHCI_PLTFM

and you can drop one line in the savdefconfig

if tomorrow you need regulator select it so a old defconfig will continue to
work

Best Regards,
J.
