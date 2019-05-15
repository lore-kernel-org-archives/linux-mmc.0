From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: meson-gx: add ddr-access-quirk property
Date: Wed, 15 May 2019 13:37:29 +0200
Message-ID: <CAPDyKFr9HVLNpqncs6YhGvqPdXCk6mtVSPVcWDvmnrKiNB+ACQ@mail.gmail.com>
References: <20190513091548.16674-1-narmstrong@baylibre.com> <20190513091548.16674-2-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190513091548.16674-2-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, DTML <devicetree@vger.kernel.org>, baylibre-upstreaming@groups.io, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 13 May 2019 at 11:16, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On the Amlogic G12A SoC family, (only) the SDIO controller has a bug which
> makes any DDR access from the MMC controller fail.
>
> Add the amlogic,ddr-access-quirk property so signal this particular
> controller has this bug and needs a quirk to work properly.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> index 13e70409e8ac..f8914dab06c6 100644
> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> @@ -22,6 +22,10 @@ Required properties:
>    clock rate requested by the MMC core.
>  - resets     : phandle of the internal reset line
>
> +Optional properties:
> +- amlogic,ddr-access-quirk: set when HW cannot access the DDR memory, like on
> +  the G12A SDIO controller.

As stated on the other patch, may I suggest to use DRAM instead of DDR.

Moreover, please mention that this is about the internal DMA support
of the controller.

> +
>  Example:
>
>         sd_emmc_a: mmc@70000 {
> --
> 2.21.0
>

Kind regards
Uffe
