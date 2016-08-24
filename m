From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RESEND] mmc: core: add error message when switching fails
 in mmc_select_hs()
Date: Wed, 24 Aug 2016 11:31:44 +0200
Message-ID: <CAPDyKFrvjq-+7mnkF46XHoPNDuvxqxkOOqUiFDFw8mp3FErodQ@mail.gmail.com>
References: <1471945807-6962-1-git-send-email-js07.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35576 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754624AbcHXJb6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Aug 2016 05:31:58 -0400
Received: by mail-wm0-f44.google.com with SMTP id f65so192842733wmi.0
        for <linux-mmc@vger.kernel.org>; Wed, 24 Aug 2016 02:31:46 -0700 (PDT)
In-Reply-To: <1471945807-6962-1-git-send-email-js07.lee@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jungseung Lee <js07.lee@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 23 August 2016 at 11:50, Jungseung Lee <js07.lee@samsung.com> wrote:
> The switch failure message in mmc_select_timing had been removed
> since that is invalid: commit 0400ed0a083a ("mmc: core: remove the
> invalid message in mmc_select_timing")
>
> Now, in the case when mmc_select_hs return error in mmc_select_timing,
> there is nothing to print failure message.
> Let's make for mmc_select_hs() print message itself in the failure case.
>
> Signed-off-by: Jungseung Lee <js07.lee@samsung.com>
> ---
>  drivers/mmc/core/mmc.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index f2d185c..e07fcce 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1018,6 +1018,7 @@ static int mmc_switch_status(struct mmc_card *card)
>   */
>  static int mmc_select_hs(struct mmc_card *card)
>  {
> +       struct mmc_host *host = card->host;

No need for local variable here, just use card->host below instead.

>         int err;
>
>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> @@ -1029,6 +1030,10 @@ static int mmc_select_hs(struct mmc_card *card)
>                 err = mmc_switch_status(card);
>         }
>
> +       if (err)
> +               pr_err("%s: switch to high-speed failed, err:%d\n",
> +                       mmc_hostname(host), err);

I think a pr_warn() would be better as mmc_select_timing() uses the
legacy speed mode when err == -EBADMSG.

> +
>         return err;
>  }
>
> @@ -1265,11 +1270,8 @@ static int mmc_select_hs400es(struct mmc_card *card)
>
>         /* Switch card to HS mode */
>         err = mmc_select_hs(card);
> -       if (err) {
> -               pr_err("%s: switch to high-speed failed, err:%d\n",
> -                       mmc_hostname(host), err);
> +       if (err)
>                 goto out_err;
> -       }
>
>         err = mmc_switch_status(card);
>         if (err)
> --
> 1.7.9.5
>

Kind regards
Uffe
