From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 3/3] sh_mmcif / PM: Use PM QoS requests, v2
Date: Tue, 6 Mar 2012 10:40:57 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1203061040130.9300@axis700.grange>
References: <201203040101.53177.rjw@sisk.pl> <201203042053.19314.rjw@sisk.pl>
 <201203042056.57012.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:62936 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844Ab2CFJlB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Mar 2012 04:41:01 -0500
In-Reply-To: <201203042056.57012.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>

On Sun, 4 Mar 2012, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Make sh_mmcif populate the pm_qos member of struct mmc_host, to
> let the core know that it should create the pm_latency_limit_ms
> host attribute for it, and set the default value of that attribute
> to 100 ms.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/mmc/host/sh_mmcif.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> Index: linux/drivers/mmc/host/sh_mmcif.c
> ===================================================================
> --- linux.orig/drivers/mmc/host/sh_mmcif.c
> +++ linux/drivers/mmc/host/sh_mmcif.c
> @@ -57,6 +57,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/module.h>
>  
> @@ -1327,6 +1328,12 @@ static int __devinit sh_mmcif_probe(stru
>  	if (ret < 0)
>  		goto clean_up2;
>  
> +	mmc->pm_qos = kzalloc(sizeof(*mmc->pm_qos), GFP_KERNEL);
> +	if (mmc->pm_qos)
> +		mmc->pm_qos->val = 100;

Same comments as for tmio_mmc: embed pm_qos and reduce the value?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
