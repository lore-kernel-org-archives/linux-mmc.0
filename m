From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V5 08/15] mmc: mmc: Comment that callers need to hold
 re-tuning if the card is put to sleep
Date: Thu, 16 Apr 2015 11:01:51 +0200
Message-ID: <CAPDyKFoT-dz1BOVhBw-Y4xGmE7adM-1mSVUgj-ckWdMB2o2ikg@mail.gmail.com>
References: <1429017146-15981-1-git-send-email-adrian.hunter@intel.com>
	<1429017146-15981-9-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:33550 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757162AbbDPJBx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2015 05:01:53 -0400
Received: by oblw8 with SMTP id w8so38276330obl.0
        for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2015 02:01:51 -0700 (PDT)
In-Reply-To: <1429017146-15981-9-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 14 April 2015 at 15:12, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Currently "mmc sleep" is only used before power off and
> is not paired with waking up.  If that ever changed,
> re-tuning might need to be held, so add a comment for that.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/mmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index c84131e..53a9cb3 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1504,6 +1504,7 @@ static int mmc_can_sleep(struct mmc_card *card)
>         return (card && card->ext_csd.rev >= 3);
>  }
>
> +/* If necessary, callers must hold re-tuning */

Instead of adding a comment, let's fix what needs to be fixed.

I believe the proper thing would be to disable re-tuning when the card
is about to enter system PM sleep state. So somewhere early in
_mmc_suspend() we should disable re-tune. Likewise for SD and SDIO.

>  static int mmc_sleep(struct mmc_host *host)
>  {
>         struct mmc_command cmd = {0};
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kind regards
Uffe
