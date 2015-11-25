From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/3] MAINTAINERS: remove atmel-mci-regs.h file
Date: Wed, 25 Nov 2015 17:33:54 +0100
Message-ID: <CAPDyKFoG=GP7DU_QFtA-u97RP8NAR8Ga+6vVM_aFrFMCej=vxA@mail.gmail.com>
References: <1448292452-5786-1-git-send-email-ludovic.desroches@atmel.com>
	<1448292452-5786-2-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36809 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817AbbKYQdz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2015 11:33:55 -0500
Received: by ykdr82 with SMTP id r82so61317704ykd.3
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2015 08:33:54 -0800 (PST)
In-Reply-To: <1448292452-5786-2-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>

On 23 November 2015 at 16:27, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:
> Remove atmel-mci-regs.h file since it has been merged in atmel-mci.c.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b2ab9fc..1df3df3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1904,7 +1904,6 @@ ATMEL AT91 / AT32 MCI DRIVER
>  M:     Ludovic Desroches <ludovic.desroches@atmel.com>
>  S:     Maintained
>  F:     drivers/mmc/host/atmel-mci.c
> -F:     drivers/mmc/host/atmel-mci-regs.h
>
>  ATMEL AT91 / AT32 SERIAL DRIVER
>  M:     Nicolas Ferre <nicolas.ferre@atmel.com>
> --
> 2.5.0
>
