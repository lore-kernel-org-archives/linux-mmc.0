From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: core: apply NO_CMD23 quirk to some specific cards
Date: Mon, 11 Dec 2017 14:00:37 +0100
Message-ID: <CAPDyKFpo5JC6W2SFeS9_bkWO=bH6JFT48o3dQpMYKSi6FKu+yQ@mail.gmail.com>
References: <1504998772.4004.2.camel@googlemail.com> <1505000687.23171.20.camel@googlemail.com>
 <CAPDyKFp5JJUp7Rec=eFZd_m9yVKbO91CNR_HbN+rpUm5KTYJgA@mail.gmail.com>
 <27444e34-fcad-2244-5125-fc31a5755a12@rock-chips.com> <1506196286.1683.7.camel@googlemail.com>
 <10a81e7b-fe56-be68-dc46-4cf2870fd7a2@rock-chips.com> <1506338583.2143.5.camel@googlemail.com>
 <54d00dd9-a733-0319-e6d2-6ea77a49afa2@rock-chips.com> <1512394717.27568.11.camel@googlemail.com>
 <1512859465.7186.4.camel@googlemail.com> <1512859675.7186.8.camel@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:37613 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbdLKNAk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Dec 2017 08:00:40 -0500
Received: by mail-it0-f65.google.com with SMTP id d137so15539121itc.2
        for <linux-mmc@vger.kernel.org>; Mon, 11 Dec 2017 05:00:40 -0800 (PST)
In-Reply-To: <1512859675.7186.8.camel@googlemail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 9 December 2017 at 23:47, Christoph Fritz <chf.fritz@googlemail.com> wrote:
> To get an usdhc Apacer and some ATP SD cards work reliable, CMD23 needs
> to be disabled.  This has been tested on i.MX6 (sdhci-esdhc) and rk3288
> (dw_mmc-rockchip).
>
> Without this patch on i.MX6 (sdhci-esdhc):
>
>  $ dd if=/dev/urandom of=/mnt/test bs=1M count=10 conv=fsync
>
>     | <mmc0: starting CMD23 arg 00000400 flags 00000015>
>     | mmc0: starting CMD25 arg 00a71f00 flags 000000b5
>     | mmc0:     blksz 512 blocks 1024 flags 00000100 tsac 3000 ms nsac 0
>     | mmc0:     CMD12 arg 00000000 flags 0000049d
>     | sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
>     | mmc0: Timeout waiting for hardware interrupt.
>
> Without this patch on rk3288 (dw_mmc-rockchip):
>
>     | mmc1: Card stuck in programming state! mmcblk1 card_busy_detect
>     | dwmmc_rockchip ff0c0000.dwmmc: Busy; trying anyway
>     | mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz,
>     | actual 400000HZ div = 0)
>     | mmc1: card never left busy state
>     | mmc1: tried to reset card, got error -110
>     | blk_update_request: I/O error, dev mmcblk1, sector 139778
>     | Buffer I/O error on dev mmcblk1p1, logical block 131586, lost async
>     | page write
>
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>

Thanks, applied for fixes and added a stable tag (4.14+, since the
patch didn't apply to earlier versions).

If/when Shawn find some time to re-spin his series, adding support for
ACMD23 [1], we may be able to revert this change. Let's see.

However, using the quirks as a fix for stable is certainly a good approach.

Kind regards
Uffe

> ---
> Changes since v1:
>  - s/CMD32/CMD23
> Changes since v2:
>  - add an Apacer card
>  - adapt comment
>
>  drivers/mmc/core/card.h   | 2 ++
>  drivers/mmc/core/quirks.h | 8 ++++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index f06cd91..79a5b98 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -75,9 +75,11 @@ struct mmc_fixup {
>  #define EXT_CSD_REV_ANY (-1u)
>
>  #define CID_MANFID_SANDISK      0x2
> +#define CID_MANFID_ATP          0x9
>  #define CID_MANFID_TOSHIBA      0x11
>  #define CID_MANFID_MICRON       0x13
>  #define CID_MANFID_SAMSUNG      0x15
> +#define CID_MANFID_APACER       0x27
>  #define CID_MANFID_KINGSTON     0x70
>  #define CID_MANFID_HYNIX       0x90
>
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index 9107f0b..d4ff9d8 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -53,6 +53,14 @@ static const struct mmc_fixup mmc_blk_fixups[] = {
>                   MMC_QUIRK_BLK_NO_CMD23),
>
>         /*
> +        * Some SD cards lockup while using CMD23 multiblock transfers.
> +        */
> +       MMC_FIXUP("AF SD", CID_MANFID_ATP, CID_OEMID_ANY, add_quirk_sd,
> +                 MMC_QUIRK_BLK_NO_CMD23),
> +       MMC_FIXUP("APUSD", CID_MANFID_APACER, 0x5048, add_quirk_sd,
> +                 MMC_QUIRK_BLK_NO_CMD23),
> +
> +       /*
>          * Some MMC cards need longer data read timeout than indicated in CSD.
>          */
>         MMC_FIXUP(CID_NAME_ANY, CID_MANFID_MICRON, 0x200, add_quirk_mmc,
> --
> 2.1.4
>
