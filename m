From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 00/11] mmc: document mmc_regulator_get_supply and fix users
Date: Tue, 10 Oct 2017 09:03:59 +0200
Message-ID: <CAPDyKFoAZri8N79eZMFJeT6bN19XZPCvCD6oBmr5EXCj_KSTVQ@mail.gmail.com>
References: <20171007103658.16868-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171007103658.16868-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>
List-Id: linux-mmc@vger.kernel.org

On 7 October 2017 at 12:36, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Fix the drivers and add some docs according to the outcome of this discussion
> [1] we had recently. The motivation from the patch description:
>
> Bail out everytime when mmc_regulator_get_supply() returns an errno, not only
> when probing gets deferred. This is currently a no-op, because this function
> only returns -EPROBE_DEFER or 0 right now. But if it will throw another error
> somewhen, it will be for a reason. (This still doesn't change that getting
> regulators is optional, so 0 can still mean no regulators found). So, let us a)
> be future proof and b) have driver code which is easier to understand.
>
> The patches have been created with coccinelle. A branch can be found here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/mmc-get-supply-docs
>
> Looking forward to comments!
>
> Kind regards,
>
>    Wolfram
>
> [1] https://patchwork.kernel.org/patch/9965823/
>
> Wolfram Sang (11):
>   mmc: add kerneldoc to mmc_regulator_get_supply()
>   mmc: cavium: catch all errors when getting regulators
>   mmc: dw_mmc: catch all errors when getting regulators
>   mmc: meson-gx-mmc: catch all errors when getting regulators
>   mmc: meson-mx-sdio: catch all errors when getting regulators
>   mmc: mmci: catch all errors when getting regulators
>   mmc: mtk-sd: catch all errors when getting regulators
>   mmc: mxcmmc: catch all errors when getting regulators
>   mmc: omap_hsmmc: catch all errors when getting regulators
>   mmc: sdhci: catch all errors when getting regulators
>   mmc: usdhi6rol0: catch all errors when getting regulators
>
>  drivers/mmc/core/core.c          | 10 ++++++++++
>  drivers/mmc/host/cavium.c        |  2 +-
>  drivers/mmc/host/dw_mmc.c        |  2 +-
>  drivers/mmc/host/meson-gx-mmc.c  |  2 +-
>  drivers/mmc/host/meson-mx-sdio.c |  2 +-
>  drivers/mmc/host/mmci.c          |  2 +-
>  drivers/mmc/host/mtk-sd.c        |  2 +-
>  drivers/mmc/host/mxcmmc.c        |  2 +-
>  drivers/mmc/host/omap_hsmmc.c    |  2 +-
>  drivers/mmc/host/sdhci.c         |  2 +-
>  drivers/mmc/host/usdhi6rol0.c    |  2 +-
>  11 files changed, 20 insertions(+), 10 deletions(-)
>
> --

Looks good to me, however as pointed out by Fabrizio, you could run a
round of checkpatch (mainly about commit message format).

Or perhaps even coccinelle needs an update to be adopted to
requirement from checkpatch?

Kind regards
Uffe
