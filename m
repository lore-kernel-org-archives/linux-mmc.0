From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sd: warn if card stays busy during init
Date: Mon, 16 Jun 2014 12:20:35 +0200
Message-ID: <CAPDyKFof=SfG2Dw3YVX2TNH7ts7nCHR+LYWHT1WS39vXxKHANw@mail.gmail.com>
References: <1400854503-9945-1-git-send-email-johanru@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:48541 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278AbaFPKUg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jun 2014 06:20:36 -0400
Received: by mail-qc0-f171.google.com with SMTP id w7so7490124qcr.2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jun 2014 03:20:35 -0700 (PDT)
In-Reply-To: <1400854503-9945-1-git-send-email-johanru@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <johan.rudholm@axis.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Jesper Nilsson <jespern@axis.com>, Johan Rudholm <jrudholm@gmail.com>, Johan Rudholm <johanru@axis.com>

On 23 May 2014 16:15, Johan Rudholm <johan.rudholm@axis.com> wrote:
> The initialization of some SD-cards fails because the card never
> leaves the busy state. Aid trouble shooting by indicating this in the
> kernel log.
>
> Signed-off-by: Johan Rudholm <johanru@axis.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/core/sd_ops.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index 274ef00..48d0c93 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -184,6 +184,9 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>                 mmc_delay(10);
>         }
>
> +       if (!i)
> +               pr_err("%s: card never left busy state\n", mmc_hostname(host));
> +
>         if (rocr && !mmc_host_is_spi(host))
>                 *rocr = cmd.resp[0];
>
> --
> 1.7.2.5
>
