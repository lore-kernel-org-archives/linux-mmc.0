From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 26/27] mmc: mmci: add DT bindings for STM32 sdmmc
Date: Mon, 1 Oct 2018 11:30:58 +0200
Message-ID: <CAPDyKFoiZMnYqtp_FofYEV=xKD+Azb2qKf=R=LdRsE+doxqW+A@mail.gmail.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com> <1537523181-14578-27-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537523181-14578-27-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Gerald Baeza <gerald.baeza@st.com>, Loic Pallardy <loic.pallardy@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

On 21 September 2018 at 11:46, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> STM32 sdmmc variant has support to:
> -Indicate signal directions (only one property
> for d0dir, d123dir, cmd_dir)
> -Select command and data phase relation.
> -Select "clock in" from an external driver.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
> change v3:
> -remove space at end of "st,use-ckin "
>
>  Documentation/devicetree/bindings/mmc/mmci.txt | 9 +++++++++

Please split this. DT doc changes should be separate patches.

>  drivers/mmc/host/mmci.c                        | 6 ++++++
>  drivers/mmc/host/mmci.h                        | 1 +
>  3 files changed, 16 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
> index e952707..d678933 100644
> --- a/Documentation/devicetree/bindings/mmc/mmci.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmci.txt
> @@ -19,6 +19,7 @@ Optional properties:
>                             the ID provided by the HW
>  - vqmmc-supply           : phandle to the regulator device tree node, mentioned
>                             as the VCCQ/VDD_IO supply in the eMMC/SD specs.
> +specific for ux500 variant:
>  - st,sig-dir-dat0        : bus signal direction pin used for DAT[0].
>  - st,sig-dir-dat2        : bus signal direction pin used for DAT[2].
>  - st,sig-dir-dat31       : bus signal direction pin used for DAT[3] and DAT[1].
> @@ -26,6 +27,14 @@ Optional properties:
>  - st,sig-dir-cmd         : cmd signal direction pin used for CMD.
>  - st,sig-pin-fbclk       : feedback clock signal pin used.
>
> +specific for sdmmc variant:
> +- st,sig-dir             : signal direction polarity used for cmd, dat0 dat123.
> +- st,neg-edge            : data & command phase relation, generated on
> +                           sd clock falling edge.
> +- st,use-ckin            : use ckin pin from an external driver to sample
> +                           the receive data (example: with voltage
> +                          switch transceiver).

[...]

Kind regards
Uffe
