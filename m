From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: add fixup of broken CMD23 for Sandisk card
Date: Tue, 21 Jul 2015 13:12:12 +0200
Message-ID: <CAPDyKFprxey8TEsazXzuqcj6xF6Eg_z1_+x5RksbtySMhteohw@mail.gmail.com>
References: <1436499843-16527-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33846 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbbGULMN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jul 2015 07:12:13 -0400
Received: by qgeu79 with SMTP id u79so29921752qge.1
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jul 2015 04:12:12 -0700 (PDT)
In-Reply-To: <1436499843-16527-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 10 July 2015 at 05:44, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> Some Sandisk cards(such as "SDMB-32" and "SDM032" cards)
> can't support CMD23, and would generate CMD timeout. So add
> FIX-UP for these two types Sandisk cards.
>
> Error log:
> mmcblk0: timed out sending SET_BLOCK_COUNT command, card status 0x400900
> mmcblk0: timed out sending SET_BLOCK_COUNT command, card status 0x400900
> mmcblk0: timed out sending SET_BLOCK_COUNT command, card status 0x400900
> end_request: I/O error, dev mmcblk0, sector 0
> Buffer I/O error on device mmcblk0, logical block 0
> mmcblk0: timed out sending SET_BLOCK_COUNT command, card status 0x400900
>
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>

Thanks, applied!

Kind regards
Uffe

> ---
>  drivers/mmc/card/block.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index c9c3d20..d06b9ab 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -2406,6 +2406,10 @@ static const struct mmc_fixup blk_fixups[] =
>          *
>          * N.B. This doesn't affect SD cards.
>          */
> +       MMC_FIXUP("SDMB-32", CID_MANFID_SANDISK, CID_OEMID_ANY, add_quirk_mmc,
> +                 MMC_QUIRK_BLK_NO_CMD23),
> +       MMC_FIXUP("SDM032", CID_MANFID_SANDISK, CID_OEMID_ANY, add_quirk_mmc,
> +                 MMC_QUIRK_BLK_NO_CMD23),
>         MMC_FIXUP("MMC08G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
>                   MMC_QUIRK_BLK_NO_CMD23),
>         MMC_FIXUP("MMC16G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
> --
> 2.1.0.27.g96db324
>
