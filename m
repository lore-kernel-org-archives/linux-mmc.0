From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 1/3] mmc: atmel-mci: correct data timeout computation
Date: Wed, 21 Mar 2012 19:26:04 +0300
Message-ID: <4F6A011C.3000900@mvista.com>
References: <1332344483-3915-1-git-send-email-ludovic.desroches@atmel.com> <1332344483-3915-2-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47477 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759141Ab2CUP1I (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Mar 2012 11:27:08 -0400
Received: by bkcik5 with SMTP id ik5so1003839bkc.19
        for <linux-mmc@vger.kernel.org>; Wed, 21 Mar 2012 08:27:07 -0700 (PDT)
In-Reply-To: <1332344483-3915-2-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ludovic.desroches@atmel.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, plagnioj@jcrosoft.com, nicolas.ferre@atmel.com

Hello.

On 03/21/2012 06:41 PM, ludovic.desroches@atmel.com wrote:

> From: Ludovic Desroches<ludovic.desroches@atmel.com>

> The HSMCI operates at a rate of up to Master Clock divided by two.

> Signed-off-by: Ludovic Desroches<ludovic.desroches@atmel.com>
> ---
>   drivers/mmc/host/atmel-mci.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)

> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index e4449a5..e161452 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -480,7 +480,7 @@ err:
>   static inline unsigned int atmci_ns_to_clocks(struct atmel_mci *host,
>   					unsigned int ns)
>   {
> -	return (ns * (host->bus_hz / 1000000) + 999) / 1000;
> +	return (ns * ((host->bus_hz/2) / 1000000) + 999) / 1000;

    Why don't you keep the notation by addign spaces around '/'?
    BTW, could use DIV_ROUND_UP() here.

WBR, Sergei
