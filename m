From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 2/3] mmc: sdhci-of-at91: introduce driver for the Atmel
 SDMMC
Date: Sat, 04 Jul 2015 10:30:28 +0200
Message-ID: <1435998628.20057.26.camel@tiscali.nl>
References: <1435933037-12889-1-git-send-email-ludovic.desroches@atmel.com>
	 <1435933037-12889-3-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lb2-smtp-cloud6.xs4all.net ([194.109.24.28]:42599 "EHLO
	lb2-smtp-cloud6.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751839AbbGEI5T (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Jul 2015 04:57:19 -0400
In-Reply-To: <1435933037-12889-3-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: ulf.hansson@linaro.org, nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com

A nit only: a license mismatch.

On vr, 2015-07-03 at 16:17 +0200, Ludovic Desroches wrote:
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> 
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or (at
> + * your option) any later version.

This states the license is GPL v2 or later.

> +MODULE_LICENSE("GPL v2");

And, according to include/linux/module.h, this states the license is
(only) GPL v2. So I think that either the comment at the top of this
file or the ident used in MODULE_LICENSE() needs to change.

Thanks,


Paul Bolle
