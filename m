From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH RESEND v10 0/7] mmc: omap_hsmmc: pbias dt and cleanup
Date: Wed, 26 Feb 2014 15:04:03 +0100
Message-ID: <530DF453.40201@epfl.ch>
References: <1389627375-9107-1-git-send-email-balajitk@ti.com> <1392821801-29673-1-git-send-email-balajitk@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1392821801-29673-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>, linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, chris@printf.net, tony@atomide.com
Cc: broonie@kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 02/19/2014 03:56 PM, Balaji T K wrote:
> Few cleanups to reduce code indent,
> Add pbias_regulator support and adapt omap_hsmmc to use pbias regulator
> to configure required voltage on mmc1 pad(SD card) i/o rails on OMAP SoCs.
> 

I tested on both OMAP3630 (Overo Storm) and OMAP4430 (DuoVero). The
rootfs is mounted on mmc1 and works as usual. Here is what I can see:

- pbias-supply is parsed from DT
- VMMC1 is set to 3V
- According to the debugfs entry, we are working at 3V signaling
- By dumping CONTROL_PBIASLITE, bit MMC1_PBIASLITE_VMODE
(PBIASLITEVMODE0 on OMAP3) is set to 1 (-> 3V)

Do you see any other tests that I could run to validate your patches?
Otherwise:

Tested-by: Florian Vaussard <florian.vaussard@epfl.ch>

> Balaji T K (7):
>   mmc: omap_hsmmc: use devm_regulator API
>   mmc: omap_hsmmc: handle vcc and vcc_aux independently
>   regulator: add pbias regulator support
>   mmc: omap_hsmmc: adapt hsmmc to use pbias regulator
>   ARM: dts: add pbias dt node
>   ARM: OMAP: enable SYSCON and REGULATOR_PBIAS in omap2plus_defconfig
>   mmc: omap_hsmmc: remove pbias workaround
> 
>  .../bindings/regulator/pbias-regulator.txt         |   27 ++
>  arch/arm/boot/dts/dra7.dtsi                        |   17 ++
>  arch/arm/boot/dts/omap2430.dtsi                    |   17 ++
>  arch/arm/boot/dts/omap3.dtsi                       |   17 ++
>  arch/arm/boot/dts/omap4.dtsi                       |   17 ++
>  arch/arm/boot/dts/omap5.dtsi                       |   17 ++
>  arch/arm/configs/omap2plus_defconfig               |    2 +
>  drivers/mmc/host/omap_hsmmc.c                      |  111 +++++----
>  drivers/regulator/Kconfig                          |    9 +
>  drivers/regulator/Makefile                         |    1 +
>  drivers/regulator/pbias-regulator.c                |  255 ++++++++++++++++++++
>  11 files changed, 441 insertions(+), 49 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/pbias-regulator.txt
>  create mode 100644 drivers/regulator/pbias-regulator.c
> 
