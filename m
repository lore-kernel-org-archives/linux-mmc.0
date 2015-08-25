From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] mmc: usdhi6rol0: fix ack register write
Date: Tue, 25 Aug 2015 14:07:24 +0200
Message-ID: <CAPDyKFqvd3aOgx2aBsM9Pk7GwEAHkP+xDs5VCS+OHqfiJXp9ug@mail.gmail.com>
References: <1439991696-28488-1-git-send-email-rabin.vincent@axis.com>
	<1439991696-28488-3-git-send-email-rabin.vincent@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38093 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932534AbbHYMHZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2015 08:07:25 -0400
Received: by igfj19 with SMTP id j19so9188854igf.1
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2015 05:07:24 -0700 (PDT)
In-Reply-To: <1439991696-28488-3-git-send-email-rabin.vincent@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rabin Vincent <rabin.vincent@axis.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc <linux-mmc@vger.kernel.org>, Rabin Vincent <rabinv@axis.com>

On 19 August 2015 at 15:41, Rabin Vincent <rabin.vincent@axis.com> wrote:
> The intent appears to be to clear only the bits which are set in status
> (by setting them to zero in the ack write), like in the other interrupt
> handlers, and not to always clear everything (by always writing zero).
> Use the correct not operator.
>
> Signed-off-by: Rabin Vincent <rabin.vincent@axis.com>

Thanks, applied for next!

Kind regards
Uffe


> ---
>  drivers/mmc/host/usdhi6rol0.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
> index 4188e84e..b505cbc2 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -1611,7 +1611,7 @@ static irqreturn_t usdhi6_cd(int irq, void *dev_id)
>                 return IRQ_NONE;
>
>         /* Ack */
> -       usdhi6_write(host, USDHI6_SD_INFO1, !status);
> +       usdhi6_write(host, USDHI6_SD_INFO1, ~status);
>
>         if (!work_pending(&mmc->detect.work) &&
>             (((status & USDHI6_SD_INFO1_CARD_INSERT) &&
> --
> 1.7.10.4
>
