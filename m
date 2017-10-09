From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH 00/11] mmc: document mmc_regulator_get_supply and fix
 users
Date: Mon, 9 Oct 2017 10:34:20 +0000
Message-ID: <TY1PR06MB089514378005B338B7FEF16FC0740@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <20171007103658.16868-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor1.renesas.com ([210.160.252.171]:17714 "EHLO
        relmlie4.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753964AbdJIKeZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Oct 2017 06:34:25 -0400
In-Reply-To: <20171007103658.16868-1-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

Hi Wolfram,

thank you for putting me in CC, and of course I agree with the changes you =
are
suggesting. Have you tried running ./scripts/checkpatch.pl?

Thanks,
Fab

>
> Fix the drivers and add some docs according to the outcome of this discus=
sion
> [1] we had recently. The motivation from the patch description:
>
> Bail out everytime when mmc_regulator_get_supply() returns an errno, not =
only
> when probing gets deferred. This is currently a no-op, because this funct=
ion
> only returns -EPROBE_DEFER or 0 right now. But if it will throw another e=
rror
> somewhen, it will be for a reason. (This still doesn't change that gettin=
g
> regulators is optional, so 0 can still mean no regulators found). So, let=
 us a)
> be future proof and b) have driver code which is easier to understand.
>
> The patches have been created with coccinelle. A branch can be found here=
:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/mmc-g=
et-supply-docs
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
> 2.11.0




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
