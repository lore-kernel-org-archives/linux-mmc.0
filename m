From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: core: apply NO_CMD23 quirk to an ATP card
Date: Fri, 22 Sep 2017 10:42:41 +0200
Message-ID: <CAPDyKFp5JJUp7Rec=eFZd_m9yVKbO91CNR_HbN+rpUm5KTYJgA@mail.gmail.com>
References: <1504998772.4004.2.camel@googlemail.com> <1505000687.23171.20.camel@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:54026 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751808AbdIVImm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Sep 2017 04:42:42 -0400
Received: by mail-it0-f45.google.com with SMTP id 85so646211ith.2
        for <linux-mmc@vger.kernel.org>; Fri, 22 Sep 2017 01:42:42 -0700 (PDT)
In-Reply-To: <1505000687.23171.20.camel@googlemail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chf.fritz@googlemail.com
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 10 September 2017 at 01:44, Christoph Fritz <chf.fritz@googlemail.com> wrote:
> To get an ATP card work reliable on a high speed bus, CMD23 needs
> to be disabled.
>
> Without this patch:
>
>  $ dd if=/dev/urandom of=/mnt/test bs=1M count=10
>
>     <mmc0: starting CMD23 arg 00000400 flags 00000015>
>     mmc0: starting CMD25 arg 00a71f00 flags 000000b5
>     mmc0:     blksz 512 blocks 1024 flags 00000100 tsac 3000 ms nsac 0
>     mmc0:     CMD12 arg 00000000 flags 0000049d
>     sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
>     mmc0: Timeout waiting for hardware interrupt.

Seems like you are using some sdhci variant. Would it be possible for
you to test this card on another platform? That to make sure it's not
a driver thing.

>
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> ---
> Changes since v1:
>  - s/CMD32/CMD23
>
>  drivers/mmc/core/card.h   | 1 +
>  drivers/mmc/core/quirks.h | 6 ++++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index f06cd91..af9c48c 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -75,6 +75,7 @@ struct mmc_fixup {
>  #define EXT_CSD_REV_ANY (-1u)
>
>  #define CID_MANFID_SANDISK      0x2
> +#define CID_MANFID_ATP          0x9
>  #define CID_MANFID_TOSHIBA      0x11
>  #define CID_MANFID_MICRON       0x13
>  #define CID_MANFID_SAMSUNG      0x15
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index fb72593..3205f0e 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -52,6 +52,12 @@ static const struct mmc_fixup mmc_blk_fixups[] = {
>                   MMC_QUIRK_BLK_NO_CMD23),
>
>         /*
> +        * Some SD cards lockup while using CMD23 multiblock transfers.
> +        */
> +       MMC_FIXUP("AF SD", CID_MANFID_ATP, CID_OEMID_ANY, add_quirk_sd,
> +                 MMC_QUIRK_BLK_NO_CMD23),

Is really all ATP cards having this problem? Perhaps we should
consider making this a bit more fine grained?

On the other hand, this may be the safest way to do it...

> +
> +       /*
>          * Some MMC cards need longer data read timeout than indicated in CSD.
>          */
>         MMC_FIXUP(CID_NAME_ANY, CID_MANFID_MICRON, 0x200, add_quirk_mmc,
> --
> 2.1.4
>

Kind regards
Uffe
