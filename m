From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/5] mmc: do not clear the host->pm_flags when suspend
Date: Thu, 11 Nov 2010 23:37:05 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1011112330420.13911@xanadu.home>
References: <1289402889-14160-1-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-2-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-3-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-4-git-send-email-peppe.cavallaro@st.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:50424 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755265Ab0KLEhG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Nov 2010 23:37:06 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LBR004YW8TIYLA0@vl-mh-mrz21.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Thu, 11 Nov 2010 23:36:54 -0500 (EST)
In-reply-to: <1289402889-14160-4-git-send-email-peppe.cavallaro@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: linux-mmc@vger.kernel.org

On Wed, 10 Nov 2010, Giuseppe CAVALLARO wrote:

> HC driver will be able to use the pm_flags to
> undestand if the system can be woken-up by the driver.
> So the mmc_suspend_host hasn't to reset this field
> in the host structure.
> 
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> ---
>  drivers/mmc/core/core.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 569e94d..6d2d6e4 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1276,7 +1276,6 @@ int mmc_suspend_host(struct mmc_host *host)
>  			mmc_claim_host(host);
>  			mmc_detach_bus(host);
>  			mmc_release_host(host);
> -			host->pm_flags = 0;
>  			err = 0;
>  		}
>  	}

This is wrong.  The host->pm_flags are set by SDIO function drivers to 
indicate they want the host controller to keep card power on when the 
host system is going to sleep.  In this case, the card has been removed, 
and therefore any flag is invalid and should be cleared.


Nicolas
