From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: mmc-moxart: CMD6 locks up the controller
Date: Fri, 3 Jun 2016 10:49:35 +0200
Message-ID: <CAPDyKFrFzGZpO1SQwpCUJOZAD3izPgubAmhhWDxeO+jETQgvgQ@mail.gmail.com>
References: <298c9ee5-37c7-6120-196d-860ec8eb0f9c@spinet.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37133 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbcFCIth (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Jun 2016 04:49:37 -0400
Received: by mail-wm0-f48.google.com with SMTP id z87so99380334wmh.0
        for <linux-mmc@vger.kernel.org>; Fri, 03 Jun 2016 01:49:37 -0700 (PDT)
In-Reply-To: <298c9ee5-37c7-6120-196d-860ec8eb0f9c@spinet.sk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michal Kadlic <michal.kadlic@spinet.sk>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jonas Jensen <jonas.jensen@gmail.com>

On 1 June 2016 at 15:10, Michal Kadlic <michal.kadlic@spinet.sk> wrote:
> Hello,
>
> newbie here, please bear with me...
>
> It seems that CMD6/SD_SWITCH request locks up the mmc-moxart controller. It
> does not respond to any command after CMD6.
> The fix suggested by Mr. Jonas Jensen <jonas.jensen@gmail.com>  is to ignore
> the SD_SWITCH request in moxart_request()
> My question is - looking at mmc_read_switch() in drivers/mmc/core/sd.c -
> would be -EINVAL a proper response in this case?

No, this seems like a bad solution to the problem.

If the SD_SWITCH command isn't working, then it's better to find out
*why* instead of only disable it. That's because it would mean to also
disable all higher speed modes for the cards.

BTW, under what circumstances does the lock up happens? In all cases
when trying to detect an inserted card?

Kind regards
Uffe

>
> This diff is against kernel 4.6.
>
> Best regards,
> Michal Kadlic
> ---
>
> diff -purN a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> --- a/drivers/mmc/host/moxart-mmc.c     2016-06-01 14:23:01.000000000 +0200
> +++ b/drivers/mmc/host/moxart-mmc.c     2016-06-01 14:37:08.856296102 +0200
> @@ -411,6 +411,14 @@ static void moxart_request(struct mmc_ho
>                 mrq->cmd->error = -ETIMEDOUT;
>                 goto request_done;
>         }
> +
> +       if (mrq->cmd->opcode == SD_SWITCH) {
> +
> +                /* CMD6 (at least in mode 0) locks up the controller
> +                 * so we have to ignore this request */
> +                mrq->cmd->error = -EINVAL;
> +                goto request_done;
> +        }
>
>         moxart_prepare_data(host);
>         moxart_send_command(host, host->mrq->cmd)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
