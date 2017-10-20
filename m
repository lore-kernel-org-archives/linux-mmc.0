From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 00/11] mmc: document mmc_regulator_get_supply and fix users
Date: Fri, 20 Oct 2017 12:02:58 +0200
Message-ID: <CAPDyKFqMu6u_0DSof+EHa1SwF6gtPPLxC7yS23xVoxemcBfPAw@mail.gmail.com>
References: <20171014191719.2129-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:49774 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752783AbdJTKC7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Oct 2017 06:02:59 -0400
Received: by mail-it0-f67.google.com with SMTP id y15so13377592ita.4
        for <linux-mmc@vger.kernel.org>; Fri, 20 Oct 2017 03:02:59 -0700 (PDT)
In-Reply-To: <20171014191719.2129-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>

On 14 October 2017 at 21:17, Wolfram Sang
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
> Changes since v1:
>         * fix checkpatch warnings about too long commit message lines
>         * fix a typo in patch 1 ('separately')
>
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

Thanks, applied for next!

Kind regards
Uffe
