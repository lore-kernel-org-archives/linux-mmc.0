From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: meson-gx: add ddr-access-quirk property
Date: Tue, 14 May 2019 19:50:34 +0200
Message-ID: <CAFBinCAhTeywLZRBhcX_myktU9k4_YcjsjgCeTHEkP7SX8JCMQ@mail.gmail.com>
References: <20190513091548.16674-1-narmstrong@baylibre.com> <20190513091548.16674-2-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190513091548.16674-2-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: ulf.hansson@linaro.org, khilman@baylibre.com, devicetree@vger.kernel.org, baylibre-upstreaming@groups.io, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Neil,

On Mon, May 13, 2019 at 11:16 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On the Amlogic G12A SoC family, (only) the SDIO controller has a bug which
> makes any DDR access from the MMC controller fail.
>
> Add the amlogic,ddr-access-quirk property so signal this particular
> controller has this bug and needs a quirk to work properly.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

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
(I believe we cannot use a standard property like "dma-ranges" to
disable DMA access)
personally I prefer "amlogic,no-direct-memory-access" or
"amlogic,no-ddr-access", but if Rob is happy with the current naming
then I'm happy as well


Regards
Martin
