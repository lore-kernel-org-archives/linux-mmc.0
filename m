From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH] Use u64 to calculate the timeout value to avoid overflow
Date: Mon, 26 Nov 2012 01:09:53 -0800
Message-ID: <20121126090953.GA11065@lizard>
References: <1353918959-12146-1-git-send-email-Haijun.Zhang@freescale.com>
 <1353918959-12146-2-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:33881 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510Ab2KZJNI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Nov 2012 04:13:08 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so3630810dak.19
        for <linux-mmc@vger.kernel.org>; Mon, 26 Nov 2012 01:13:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1353918959-12146-2-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chris Ball <cjb@laptop.org>

On Mon, Nov 26, 2012 at 04:35:59PM +0800, Haijun Zhang wrote:
> As data timeout_ns use u64 to avoid overflow.
> So we use macro div_u64 to perform a division.
[...]
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -593,17 +593,16 @@ static void atmci_timeout_timer(unsigned long data)
>  	tasklet_schedule(&host->tasklet);
>  }
>  
> -static inline unsigned int atmci_ns_to_clocks(struct atmel_mci *host,
> -					unsigned int ns)
> +static inline unsigned int atmci_ns_to_clocks(struct atmel_mci *host, u64 ns)
>  {
>  	/*
>  	 * It is easier here to use us instead of ns for the timeout,
>  	 * it prevents from overflows during calculation.
>  	 */
> -	unsigned int us = DIV_ROUND_UP(ns, 1000);
> +	u64 us = DIV_ROUND_UP_ULL(ns, 1000);
>  
>  	/* Maximum clock frequency is host->bus_hz/2 */
> -	return us * (DIV_ROUND_UP(host->bus_hz, 2000000));
> +	return (u32)(us * (DIV_ROUND_UP_ULL(host->bus_hz, 2000000)));

Why do you need u32 cast here?..

Thanks,
Anton.
