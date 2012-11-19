From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 2/2] Powerpc/eSDHC: Add limit to data and erase timeout
 value calculation
Date: Sun, 18 Nov 2012 21:04:39 -0800
Message-ID: <20121119050439.GA29095@lizard>
References: <1353296310-10786-1-git-send-email-Haijun.Zhang@freescale.com>
 <1353296310-10786-2-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:32909 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab2KSFHw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Nov 2012 00:07:52 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so172285pad.19
        for <linux-mmc@vger.kernel.org>; Sun, 18 Nov 2012 21:07:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1353296310-10786-2-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>

On Mon, Nov 19, 2012 at 11:38:29AM +0800, Haijun Zhang wrote:
> Some cards apply too larg timeout value for host to response,
> So limit the maximum data transfer timeout value and maximum erase
> timeout value to aviod timeout issue.
> 
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>

Ditto about the sign-off, it's inappropriate in this case.

[...]
> @@ -721,6 +722,10 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
>  				data->timeout_ns =  100000000;	/* 100ms */
>  		}
>  	}
> +
> +	if (host->max_discard_to &&
> +		host->max_discard_to < div_u64(data->timeout_ns, 1000000))

Still wrong indentation.

> +		data->timeout_ns = (u64)host->max_discard_to * 1000000;
>  }
>  EXPORT_SYMBOL(mmc_set_data_timeout);
