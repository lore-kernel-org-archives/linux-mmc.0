From: Sebastian Frias <sf84@laposte.net>
Subject: Re: arasan,sdhci.txt "compatibility" DT binding
Date: Mon, 28 Nov 2016 17:23:26 +0100
Message-ID: <e8425325-8036-b99e-1903-3590af96991c@laposte.net>
References: <56B07BA5.4060407@free.fr> <56B166F1.5080605@rock-chips.com>
 <56B1AA44.1010108@xilinx.com> <56B1BAF8.2050907@free.fr>
 <56B1CF40.1030203@xilinx.com> <20160203152104.GP4215@xsjsorenbubuntu>
 <56B21DDB.6050708@free.fr> <582ED9E0.5090506@free.fr>
 <CAFd313x6MJeO90_+rxditdPn762g7TqZc0_D6ojGTKmtGJKjPA@mail.gmail.com>
 <582EF744.8090307@free.fr> <a20b2b4f-15d4-3c29-324c-1ced5dbcc67f@xilinx.com>
 <583C50E7.6030400@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <583C50E7.6030400@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mason <slash.tmp@free.fr>, linux-mmc <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Jisheng Zhang <jszhang@marvell.com>, Michal Simek <monstr@monstr.eu>, Rameshwar Sahu <rsahu@apm.com>, Suman Tripathi <stripathi@apm.com>, Arnd Bergmann <arnd@arndb.de>, Xiaobo Xie <x.xie@freescale.com>, P L Sai Krishna <lakshmis@xilinx.com>, Linus Walleij <linus.walleij@linaro.org>, Anton Vorontsov <anton@enomsg.org>, Heiko Stuebner <heiko@sntech.de>, Michal Simek <michal.simek@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@arm.linux.org.uk>, Maxime Ripard <maxime.ripard@free-electrons.com>, Suneel Garapati <suneel.garapati@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Zach Brown <zach.brown@ni.com>
List-Id: linux-mmc@vger.kernel.org

On 28/11/16 16:44, Mason wrote:
> Hello,
> 
> @Shawn Lin, could you take a look below and tell me exactly
> which IP core(s) Rockchip is using in its SoCs?
> 
> Based on the feedback I received, here is an updated list of
> compatible strings and controller versions dealt with by the
> drivers/mmc/host/sdhci-of-arasan.c code.
> 
> 
> Xilinx Zynq:
> "SD2.0 / SDIO2.0 / MMC3.31 AHB Host Controller"
> "arasan,sdhci-8.9a"
> NB: 8.9a is the documentation revision (dated 2011-10-19)
> subsequent tweaks labeled 9.0a, 9.1a, 9.2a
> 
> Xilinx ZynqMP:
> "SD3.0 / SDIO3.0 / eMMC4.51 AHB Host Controller"
> "arasan,sdhci-8.9a"
> NB: using the same compatible string as Zynq
> 
> Sigma SMP87xx
> "SD3.0 / SDIO3.0 / eMMC4.4 AHB Host Controller"
> no compatible string yet, platform-specific init required
> 
> APM:
> "SD3.0 / SDIO3.0 / eMMC4.41 AHB Host Controller"
> "arasan,sdhci-4.9a"
> NB: 4.9a appears to be the documentation revision
> no functional diff with "arasan,sdhci-8.9a"
> 
> Rockchip
> Exact IP unknown, waiting for Shawn's answer
> "arasan,sdhci-5.1"
> NB: 5.1 appears to refer to the eMMC standard supported
> 
> 
> On a final note, there are many variations of the Arasan IP.
> I've tracked down at least the following:
> 
> SD_2.0_SDIO_2.0__MMC_3.31_AHB_Host_Controller.pdf
> SD_3.0_SDIO_3.0_eMMC_4.41_OCP_Host_Controller.pdf
> SD_3.0_SDIO_3.0_eMMC_4.4__AHB_Host_Controller.pdf
> SD_3.0_SDIO_3.0_eMMC_4.51_Host_Controller.pdf
> SD_3.0_SDIO_3.0_eMMC_4.5__Host_Controller.pdf
> SD_4.1_SDIO_4.1_eMMC_4.51_Host_Controller.pdf
> SD_4.1_SDIO_4.1_eMMC_5.1__Host_Controller.pdf
> 
> It seems to me the compatible string should specify
> the SD/SDIO version AND the eMMC version, since it
> seems many combinations are allowed, e.g. eMMC 4.51
> has two possible SD versions.
> 
> What do you think?


I'm trying to picture this. Imagine:
a) SoC XYZ used two versions:
  - SD_3.0_SDIO_3.0_eMMC_4.4__AHB_Host_Controller.pdf
  - SD_3.0_SDIO_3.0_eMMC_4.5__Host_Controller.pdf
b) That the compatible suffixes were defined as "sd30-emmc44" and
"sd30-emmc45" respectively
c) That the chip-specific init is the same for both.

What would be the recommended way of dealing with that at DT/driver level?

1) XYZ's DT1: compatible = "arasan,sdhci-sd30-emmc44", "XYZ,sdhci"
         DT2: compatible = "arasan,sdhci-sd30-emmc45", "XYZ,sdhci"
   driver: match "XYZ,sdhci" for chip-specific init, and then leaves
"arasan,sdhci-sd30-emmc44" or arasan,sdhci-sd30-emmc45" for generic part

2) XYZ's DT1: compatible = "XYZ,arasan-sdhci-sd30-emmc44"
         DT2: compatible = "XYZ,arasan-sdhci-sd30-emmc45"
   driver: match "XYZ,arasan-sdhci-sd30-emmc44" or "XYZ,arasan-sdhci-sd30-emmc45"
for chip-specific init and generic parts

3) XYZ's DT1: compatible = "arasan,sdhci-sd30-emmc44"
         DT2: compatible = "arasan,sdhci-sd30-emmc45"
   driver: match "arasan,sdhci-sd30-emmc44" or "arasan,sdhci-sd30-emmc45" for
generic part; chip-specific init done somewhere else (bootloader?)

4) something else?

How would those solutions be affected if condition c) was changed to
"chip-specific init is different for both"?


> 
> Regards.
> 
