From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 0/3] mmc: tmio: Use modern PM ops
Date: Fri, 8 Nov 2013 13:16:56 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1311081309140.22449@axis700.grange>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:62615 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683Ab3KHMQ7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Nov 2013 07:16:59 -0500
In-Reply-To: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

Hi Ulf,

A general question concerning this your effort just occurred to me: what 
if runtime PM is disabled on a system? Will the clock(s) then at all be 
enabled? Doesn't one need for such a case either a fall-back to statically 
enable clock in .probe() and disable in .remove() or should such drivers 
select PM_RUNTIME?

Thanks
Guennadi

On Tue, 5 Nov 2013, Ulf Hansson wrote:

> This patchset converts tmio and sh_mobile_sdhi to use the modern PM ops.
> 
> Ulf Hansson (3):
>   mmc: sh_mobile_sdhi: Use modern PM macros to define pm callbacks
>   mmc: tmio_mmc: Convert from legacy to modern PM ops
>   mmc: tmio: Adapt to proper PM configs for exported functions
> 
>  drivers/mmc/host/sh_mobile_sdhi.c |    8 ++++----
>  drivers/mmc/host/tmio_mmc.c       |   32 ++++++++++++++++++--------------
>  drivers/mmc/host/tmio_mmc.h       |    7 +++----
>  drivers/mmc/host/tmio_mmc_pio.c   |    7 ++++---
>  4 files changed, 29 insertions(+), 25 deletions(-)
> 
> -- 
> 1.7.9.5
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
