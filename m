From: Stefan Roese <stefan.roese@gmail.com>
Subject: Re: [PATCH RESEND v10 0/7] mmc: omap_hsmmc: pbias dt and cleanup
Date: Wed, 26 Feb 2014 09:51:39 +0100
Message-ID: <530DAB1B.6000406@gmail.com>
References: <1389627375-9107-1-git-send-email-balajitk@ti.com> <1392821801-29673-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1392821801-29673-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>, linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, chris@printf.net, tony@atomide.com
Cc: broonie@kernel.org
List-Id: linux-mmc@vger.kernel.org

On 19.02.2014 15:56, Balaji T K wrote:
> Few cleanups to reduce code indent,
> Add pbias_regulator support and adapt omap_hsmmc to use pbias regulator
> to configure required voltage on mmc1 pad(SD card) i/o rails on OMAP SoCs.
>
> Balaji T K (7):
>    mmc: omap_hsmmc: use devm_regulator API
>    mmc: omap_hsmmc: handle vcc and vcc_aux independently
>    regulator: add pbias regulator support
>    mmc: omap_hsmmc: adapt hsmmc to use pbias regulator
>    ARM: dts: add pbias dt node
>    ARM: OMAP: enable SYSCON and REGULATOR_PBIAS in omap2plus_defconfig
>    mmc: omap_hsmmc: remove pbias workaround
>
>   .../bindings/regulator/pbias-regulator.txt         |   27 ++
>   arch/arm/boot/dts/dra7.dtsi                        |   17 ++
>   arch/arm/boot/dts/omap2430.dtsi                    |   17 ++
>   arch/arm/boot/dts/omap3.dtsi                       |   17 ++
>   arch/arm/boot/dts/omap4.dtsi                       |   17 ++
>   arch/arm/boot/dts/omap5.dtsi                       |   17 ++
>   arch/arm/configs/omap2plus_defconfig               |    2 +
>   drivers/mmc/host/omap_hsmmc.c                      |  111 +++++----
>   drivers/regulator/Kconfig                          |    9 +
>   drivers/regulator/Makefile                         |    1 +
>   drivers/regulator/pbias-regulator.c                |  255 ++++++++++++++++++++
>   11 files changed, 441 insertions(+), 49 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/regulator/pbias-regulator.txt
>   create mode 100644 drivers/regulator/pbias-regulator.c

This patch series (its v11 even though this mail has the subject v10) 
fixes problems I'm experiencing with MMC detection on some OMAP3 based 
boards. So:

Tested-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

