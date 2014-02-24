From: Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [PATCH 5/5] mmc: sdhci-spear: use generic card detection gpio
 support
Date: Mon, 24 Feb 2014 11:41:48 +0530
Message-ID: <20140224061148.GB3905@pratyush-vbox>
References: <20140221103710.GB21483@n2100.arm.linux.org.uk>
 <E1WGnXs-0007Jw-0M@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:50522 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750739AbaBXGM4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Feb 2014 01:12:56 -0500
Content-Disposition: inline
In-Reply-To: <E1WGnXs-0007Jw-0M@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Mohit KUMAR DCG <Mohit.KUMAR@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Viresh Kumar <viresh.linux@gmail.com>, Chris Ball <chris@printf.net>, spear-devel <spear-devel@list.st.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Russell,

On Fri, Feb 21, 2014 at 06:41:28PM +0800, Russell King wrote:
> sdhci has support for using GPIOs for card detection.  If we have a
> GPIO specified, we can use that directly, without needing our own
> interrupt handler.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/mmc/host/sdhci-spear.c | 78 +++++++++---------------------------------
>  1 file changed, 16 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
> index 00a73b1a6444..af3338fb0762 100644
> --- a/drivers/mmc/host/sdhci-spear.c
> +++ b/drivers/mmc/host/sdhci-spear.c

To get mmc_gpio_request_cd declaration 

#include <linux/mmc/slot-gpio.h>

is needed.

Regards
Pratyush
