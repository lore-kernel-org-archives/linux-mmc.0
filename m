From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 0/5] mmc: add stm32 sdmmc controller
Date: Thu, 1 Mar 2018 10:06:28 +0100
Message-ID: <CAPDyKFpfPAaLRZLqpyi6RwC1-=7Ao=u+OmEfHaYBABzd_-BKAw@mail.gmail.com>
References: <1519832844-28068-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1519832844-28068-1-git-send-email-ludovic.Barre@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Gerald Baeza <gerald.baeza@st.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Ludovic,

On 28 February 2018 at 16:47, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch serie adds support of stm32 SDMMC controller.
> stm32h7 is the first SoC to use stm32 SDMMC controller
> (previous SoC had pl180 controller).

I am a not convinced this isn't a new improved variant of the pl180.
According to register layout and the code you submitted in patch2,
there are great similarities to pl180 and the mmci driver.

In other words, it more sounds like an improved variant of pl180,
hence I am thinking that you should try to extend the mmci driver
instead. Could you please have a look at that, unless you can specify
more exactly why that isn't suitable?

>
> The SDMMC features include the following:
> -Full compliance with MultiMediaCard System Specification Version 4.51.
>  Card support for three different databus modes:
>  1-bit (default), 4-bit and 8-bit.
> -Full compliance with SD memory card specifications version 4.1.
>  SDR104 speed limited to maximum allowed I/O speed, SPI mode and
>  UHS-II mode not supported.
> -Full compliance with SDIO card specification version 4.0.
>
> change V2:
> -dt-bindings: properties name
> st,dir-output-high; st,neg-edge; st,use-ckin
> -dt-bindings: node example s/sdmmc@/mmc@/g
> -removes return of enable/disable_imask functions
> -adds dev_warn if clk divisor is too short.
> -replaces overprotection of n_elem by fail of dma_map_sg
> -removes shortcut host->base
> -Use device_property_present
>
> Ludovic Barre (5):
>   dt-bindings: mmc: document the stm32 sdmmc bindings
>   mmc: add stm32 sdmmc controller driver
>   ARM: dts: stm32: add sdmmc support for stm32h743
>   ARM: dts: stm32: add sdmmc1 support for stm32h743i-eval
>   ARM: configs: stm32: add mmc and ext2/3/4 support
>
>  .../devicetree/bindings/mmc/st,stm32-sdmmc.txt     |  35 +
>  arch/arm/boot/dts/stm32h743-pinctrl.dtsi           |  26 +
>  arch/arm/boot/dts/stm32h743.dtsi                   |  26 +
>  arch/arm/boot/dts/stm32h743i-eval.dts              |  11 +
>  arch/arm/configs/stm32_defconfig                   |   4 +-
>  drivers/mmc/host/Kconfig                           |   8 +
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/stm32-sdmmc.c                     | 708 +++++++++++++++++++++
>  drivers/mmc/host/stm32-sdmmc.h                     | 220 +++++++
>  9 files changed, 1038 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/st,stm32-sdmmc.txt
>  create mode 100644 drivers/mmc/host/stm32-sdmmc.c
>  create mode 100644 drivers/mmc/host/stm32-sdmmc.h
>
> --
> 2.7.4
>

Kind regards
Uffe
