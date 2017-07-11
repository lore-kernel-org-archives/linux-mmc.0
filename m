From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mxcmmc: check the return value of mxcmci_finish_data
Date: Tue, 11 Jul 2017 16:44:25 +0200
Message-ID: <CAPDyKFrQmARVB0xe=gkeJEYP7XJedy_mvssYsQhZt+ePNhybvQ@mail.gmail.com>
References: <1499328552-83340-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34076 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933435AbdGKOo0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jul 2017 10:44:26 -0400
Received: by mail-qk0-f178.google.com with SMTP id d78so2749354qkb.1
        for <linux-mmc@vger.kernel.org>; Tue, 11 Jul 2017 07:44:26 -0700 (PDT)
In-Reply-To: <1499328552-83340-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 6 July 2017 at 10:09, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> We got a compile warning for mxcmmc,
>
> drivers/mmc/host/mxcmmc.c: In function 'mxcmci_data_done':
> drivers/mmc/host/mxcmmc.c:661:6: warning: variable 'data_error' set but
> not used [-Wunused-but-set-variable]
>
> The easiest method is to remove the data_error. But looking into
> the code closely, I think we should check the return value of
> mxcmci_finish_data as if it got data->error(the same as data_error),
> we shouldn't try to read the response.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/mxcmmc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index fb3ca82..3814942 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -681,6 +681,9 @@ static void mxcmci_data_done(struct mxcmci_host *host, unsigned int stat)
>
>         spin_unlock_irqrestore(&host->lock, flags);
>
> +       if (data_error)
> +               return;
> +
>         mxcmci_read_response(host, stat);
>         host->cmd = NULL;
>
> --
> 1.9.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
