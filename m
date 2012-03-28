From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v2 1/3] mmc: atmel-mci: correct data timeout computation
Date: Wed, 28 Mar 2012 13:44:37 +0200
Message-ID: <4F72F9A5.60900@atmel.com>
References: <1332344483-3915-2-git-send-email-ludovic.desroches@atmel.com> <1332930513-14893-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:52238 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932285Ab2C1Lou (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Mar 2012 07:44:50 -0400
In-Reply-To: <1332930513-14893-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ludovic.desroches@atmel.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 03/28/2012 12:28 PM, ludovic.desroches@atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> The HSMCI operates at a rate of up to Master Clock divided by two.
> Moreover previous calculation can cause overflows and so wrong
> timeouts.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> Cc: stable <stable@vger.kernel.org>
> ---
>  drivers/mmc/host/atmel-mci.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index e4449a5..3a57964 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -480,7 +480,14 @@ err:
>  static inline unsigned int atmci_ns_to_clocks(struct atmel_mci *host,
>  					unsigned int ns)
>  {
> -	return (ns * (host->bus_hz / 1000000) + 999) / 1000;
> +	/*
> +	 * It is easier here to use us instead of ns for the timeout,
> +	 * it prevents from overflows during calculation.
> +	 */
> +	unsigned int us = DIV_ROUND_UP(ns, 1000);
> +
> +	/* Maximum clock frequency is host->bus_hz/2 */
> +	return us * (DIV_ROUND_UP(host->bus_hz, 2000000));
>  }
>  
>  static void atmci_set_timeout(struct atmel_mci *host,


-- 
Nicolas Ferre
