From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1] mmc: quirks: Fixup debug message
Date: Mon, 16 Jun 2014 10:55:29 +0200
Message-ID: <CAPDyKFrQNeyQi2BR3vD07e0-Hb7TXadS8xYZGDbPYQfsoBSHgQ@mail.gmail.com>
References: <1400585361-5194-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:40502 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754285AbaFPIza (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jun 2014 04:55:30 -0400
Received: by mail-qa0-f45.google.com with SMTP id v10so6970115qac.18
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jun 2014 01:55:29 -0700 (PDT)
In-Reply-To: <1400585361-5194-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 20 May 2014 13:29, Alexander Stein
<alexander.stein@systec-electronic.com> wrote:
> There is no need for an output like this:
>> mmcblk mmc1:0001: calling add_quirk_mmc+0x0/0x20
> Instead use this one:
>> mmcblk mmc1:0001: calling add_quirk_mmc
>
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/core/quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.c
> index 6c36fcc..dd1d1e0 100644
> --- a/drivers/mmc/core/quirks.c
> +++ b/drivers/mmc/core/quirks.c
> @@ -91,7 +91,7 @@ void mmc_fixup_device(struct mmc_card *card, const struct mmc_fixup *table)
>                     (f->cis_device == card->cis.device ||
>                      f->cis_device == (u16) SDIO_ANY_ID) &&
>                     rev >= f->rev_start && rev <= f->rev_end) {
> -                       dev_dbg(&card->dev, "calling %pF\n", f->vendor_fixup);
> +                       dev_dbg(&card->dev, "calling %pf\n", f->vendor_fixup);
>                         f->vendor_fixup(card, f->data);
>                 }
>         }
> --
> 1.8.5.5
>
