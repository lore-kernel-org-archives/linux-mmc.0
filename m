From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: card.h: Use NULL instead of 0 for END_FIXUP
Date: Wed, 9 Apr 2014 11:33:41 +0200
Message-ID: <CAPDyKFrGhX1R6HsVF_r=MTGXg_06xEe1WL3YCaywhKWq19TLFQ@mail.gmail.com>
References: <1396662168-6501-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:43092 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbaDIJdm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Apr 2014 05:33:42 -0400
Received: by mail-qg0-f46.google.com with SMTP id 63so1896743qgz.19
        for <linux-mmc@vger.kernel.org>; Wed, 09 Apr 2014 02:33:41 -0700 (PDT)
In-Reply-To: <1396662168-6501-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>

On 5 April 2014 03:42, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Fix the following sparse warnings:
>
> drivers/mmc/card/block.c:2421:9: warning: Using plain integer as NULL pointer
>
> drivers/mmc/core/quirks.c:69:9: warning: Using plain integer as NULL pointer
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  include/linux/mmc/card.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index b730272..aa7e57f 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -353,7 +353,7 @@ struct mmc_fixup {
>  #define CID_OEMID_ANY ((unsigned short) -1)
>  #define CID_NAME_ANY (NULL)
>
> -#define END_FIXUP { 0 }
> +#define END_FIXUP { NULL }
>
>  #define _FIXUP_EXT(_name, _manfid, _oemid, _rev_start, _rev_end,       \
>                    _cis_vendor, _cis_device,                            \
> --
> 1.8.3.2
>
