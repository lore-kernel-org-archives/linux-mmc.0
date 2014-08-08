From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] mmc: include linux/types.h for bool definition in
 atmel-mci.h
Date: Fri, 8 Aug 2014 14:45:47 +0200
Message-ID: <20140808124547.GK27338@ldesroches-Latitude-E6320>
References: <1407417246-29709-1-git-send-email-egtvedt@samfundet.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:31838 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593AbaHHMpp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Aug 2014 08:45:45 -0400
Content-Disposition: inline
In-Reply-To: <1407417246-29709-1-git-send-email-egtvedt@samfundet.no>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: linux-mmc@vger.kernel.org, ludovic.desroches@atmel.com

On Thu, Aug 07, 2014 at 03:14:06PM +0200, Hans-Christian Egtvedt wrote:
> This patch adds an include of linux/types.h to make sure bool is defined
> before utilized in this header file.
> 
> Signed-off-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks

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
>  #define ATMCI_MAX_NR_SLOTS	2
>  
>  /**
> -- 
> 1.9.1
> 
