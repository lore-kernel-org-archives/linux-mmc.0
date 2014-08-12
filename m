From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: include linux/types.h for bool definition in atmel-mci.h
Date: Tue, 12 Aug 2014 13:58:45 +0200
Message-ID: <CAPDyKFqMmTVG4DPKYDdd=ekmtPJ2ZKGWa=JqrLNztWfjj8f1oQ@mail.gmail.com>
References: <1407417246-29709-1-git-send-email-egtvedt@samfundet.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:61781 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbaHLL6q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Aug 2014 07:58:46 -0400
Received: by mail-qc0-f181.google.com with SMTP id x13so2699090qcv.40
        for <linux-mmc@vger.kernel.org>; Tue, 12 Aug 2014 04:58:45 -0700 (PDT)
In-Reply-To: <1407417246-29709-1-git-send-email-egtvedt@samfundet.no>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ludovic Desroches <ludovic.desroches@atmel.com>

On 7 August 2014 15:14, Hans-Christian Egtvedt <egtvedt@samfundet.no> wrote:
> This patch adds an include of linux/types.h to make sure bool is defined
> before utilized in this header file.
>
> Signed-off-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

Thanks! Queued for 3.18.

Kind regards
Uffe

> ---
>  include/linux/atmel-mci.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/atmel-mci.h b/include/linux/atmel-mci.h
> index 4c7a4b2..91b77f8 100644
> --- a/include/linux/atmel-mci.h
> +++ b/include/linux/atmel-mci.h
> @@ -1,6 +1,8 @@
>  #ifndef __LINUX_ATMEL_MCI_H
>  #define __LINUX_ATMEL_MCI_H
>
> +#include <linux/types.h>
> +
>  #define ATMCI_MAX_NR_SLOTS     2
>
>  /**
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
