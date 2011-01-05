From: viresh kumar <viresh.kumar@st.com>
Subject: Re: mmc_test mmc0:0001: Can't create file. Perhaps debugfs is	disabled
Date: Wed, 5 Jan 2011 09:07:07 +0530
Message-ID: <4D23E763.7060402@st.com>
References: <4D11E833.7000506@st.com> <20110104180113.GA17407@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:46242 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750995Ab1AEDhR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jan 2011 22:37:17 -0500
In-Reply-To: <20110104180113.GA17407@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>

On 01/04/2011 11:31 PM, Chris Ball wrote:
> Thanks, I've reproduced this now.  It's a bug.  The reason I hadn't seen
> it before is that my workflow is always to insert a card, then rmmod
> mmc_block && modprobe mmc_test -- this works because the debugfs dir is
> created late on the initial insertion, but still before mmc_test loads.
> I compiled a kernel with MMC and mmc_test built in, and no mmc_block
> support, and hit your bug.  
> 
> Here's your patch: could you send a Signed-off-by: line for it, please?
> 

Chris,

Actually i am bit new to LKML and i don't know if i should send the patch again
with signed-off or simply send a signed-off: in a similar way as we send
Acked-by:. Please tell me if i need to resend patch.

> From: Viresh Kumar <viresh.kumar@st.com>
> Date: Tue, 4 Jan 2011 12:55:14 -0500
> Subject: [PATCH] mmc: register debugfs dir before calling card probe function
> 
> This way, the probe function may register debugfs files if it wants to.
> 
> This fixes a bug with mmc_test where mmc_test_register_file_test() is
> called before the card's debugfs dir exists, and so it fails.
> ---
>  drivers/mmc/core/bus.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index af8dc6a..63667a8 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -303,14 +303,14 @@ int mmc_add_card(struct mmc_card *card)
>  			type, card->rca);
>  	}
>  
> -	ret = device_add(&card->dev);
> -	if (ret)
> -		return ret;
> -
>  #ifdef CONFIG_DEBUG_FS
>  	mmc_add_card_debugfs(card);
>  #endif
>  
> +	ret = device_add(&card->dev);
> +	if (ret)
> +		return ret;
> +
>  	mmc_card_set_present(card);
>  
>  	return 0;

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

-- 
viresh
