From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/6] Add multiple GPIO and external clock to MMC pwrseq_simple
Date: Fri, 30 Jan 2015 12:13:52 +0100
Message-ID: <CAPDyKFqx-dhhVmtGnP2YpmR63Y20Ns=YyxnYrE2ewTuNXPA7Ag@mail.gmail.com>
References: <1422543608-24704-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1422543608-24704-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Kukjin Kim <kgene@kernel.org>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Arend van Spriel <arend@broadcom.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 29 January 2015 at 16:00, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> Hello Ulf,
>
> Many WLAN chips attached to an SDIO interface needs more than one GPIO
> for their reset sequence and also an external clock to be operational.
>
> Since this is very common, this series extend the simple MMC power sequence
> to support more than one reset GPIO and also an optional external clock.
>
> This is the third version of the series that addressed issues pointed out
> in the previous versions.
>
> The series depend on v4 "mmc: core: Add support for MMC power sequences":
>
> http://comments.gmane.org/gmane.linux.kernel.mmc/30665
>
> Javier Martinez Canillas (6):
>   mmc: pwrseq: Document that simple sequence support more than one GPIO
>   mmc: pwrseq_simple: Extend to support more pins
>   mmc: pwrseq: Document optional clock for the simple power sequence
>   mmc: pwrseq_simple: Add optional reference clock support
>   ARM: dts: exynos5250-snow: Enable wifi power-on
>   ARM: dts: exynos5250-snow: Add cap-sdio-irq to wifi mmc node
>
>  .../devicetree/bindings/mmc/mmc-pwrseq-simple.txt  | 11 ++-
>  arch/arm/boot/dts/exynos5250-snow.dts              | 26 ++++++-
>  drivers/mmc/core/pwrseq_simple.c                   | 89 ++++++++++++++++++----
>  3 files changed, 107 insertions(+), 19 deletions(-)
>
> Patch #1 extends the simple MMC power sequence DT binding to support more
> than one GPIO and patch #2 adds the actual implementation.
>
> In the same way, patch #3 and #4 extend the simple MMC power sequence DT
> binding and pwrseq_simple driver to support an optional external clock.
>
> Finally as an example, patch #5 and patch #6 adds support for the wifi
> chip in the Exynos5250 Snow that needs all these resources. These two
> patches were added to the series only for completeness and should be
> picked by Kukjin through his linux-samsung tree.
>
> Best regards,
> Javier

Thanks Javier! I have applied patch 1 -> 4 for my next branch.

I made some minor fix to patch4, I send a separate response to that
patch so you know.

Kind regards
Uffe
