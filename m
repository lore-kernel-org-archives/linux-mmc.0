From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] sdhci-tegra: fix linux/module.h included twice
Date: Wed, 15 Feb 2012 14:10:37 -0500
Message-ID: <4F3C032D.7080905@windriver.com>
References: <1329328466-4627-1-git-send-email-danny.kukawka@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:53280 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650Ab2BOTL1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2012 14:11:27 -0500
In-Reply-To: <1329328466-4627-1-git-send-email-danny.kukawka@bisect.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Danny Kukawka <danny.kukawka@bisect.de>
Cc: Chris Ball <cjb@laptop.org>, Danny Kukawka <dkukawka@suse.de>, Olof Johansson <olof@lixom.net>, Stephen Warren <swarren@nvidia.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 12-02-15 12:54 PM, Danny Kukawka wrote:
> Remove double include of linux/module.h.
> 
> Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>

Hi Danny,

We've already got these covered all in one go.

https://lkml.org/lkml/2012/2/4/134

Thanks,
Paul.

---

> ---
>  drivers/mmc/host/sdhci-tegra.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 78a36eb..cb34856 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -23,7 +23,6 @@
>  #include <linux/gpio.h>
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/host.h>
> -#include <linux/module.h>
>  
>  #include <asm/gpio.h>
>  
