From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: sd: Remove superfluous error code assignment
Date: Tue, 15 Sep 2015 13:34:41 +0200
Message-ID: <CAPDyKFoBZPGRPqOJc5upj5dyotr1RMRbwdjXoJLU6Q-uCDagzw@mail.gmail.com>
References: <1441816398-4330-1-git-send-email-yszhou4tech@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37528 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbbIOLem (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Sep 2015 07:34:42 -0400
Received: by wicfx3 with SMTP id fx3so22905559wic.0
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2015 04:34:41 -0700 (PDT)
In-Reply-To: <1441816398-4330-1-git-send-email-yszhou4tech@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yousong Zhou <yszhou4tech@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 9 September 2015 at 18:33, Yousong Zhou <yszhou4tech@gmail.com> wrote:
> Signed-off-by: Yousong Zhou <yszhou4tech@gmail.com>

Thanks, applied for next!

I will comment on patch2 and patch3 separately.

Kind regards
Uffe

> ---
>  drivers/mmc/core/sd.c |    2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 4e7366a..e28ebf3 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -357,8 +357,6 @@ int mmc_sd_switch_hs(struct mmc_card *card)
>         if (card->sw_caps.hs_max_dtr == 0)
>                 return 0;
>
> -       err = -EIO;
> -
>         status = kmalloc(64, GFP_KERNEL);
>         if (!status) {
>                 pr_err("%s: could not allocate a buffer for "
> --
> 1.7.10.4
>
