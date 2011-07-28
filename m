From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci: fix retuning timer wrongly deleted in sdhci_tasklet_finish
Date: Thu, 28 Jul 2011 18:28:13 -0400
Message-ID: <m2fwlqjb0i.fsf@bob.laptop.org>
References: <1310362031-8186-1-git-send-email-Aaron.Lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35739 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756079Ab1G1W2R (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Jul 2011 18:28:17 -0400
In-Reply-To: <1310362031-8186-1-git-send-email-Aaron.Lu@amd.com> (Aaron Lu's
	message of "Mon, 11 Jul 2011 13:27:11 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <Aaron.Lu@amd.com>
Cc: Arindam Nath <arindam.nath@amd.com>, linux-mmc@vger.kernel.org

Hi Aaron,

On Mon, Jul 11 2011, Aaron Lu wrote:
> Currently, the retuning timer for retuning mode 1 will be deleted in
> function sdhci_tasklet_finish after a mmc request done, which will make
> retuning timing never trigger again. This patch fixed this problem.
>
> Signed-off-by: Aaron Lu <Aaron.Lu@amd.com>
> ---
>  drivers/mmc/host/sdhci.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 91d9892..6250bac 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1863,9 +1863,6 @@ static void sdhci_tasklet_finish(unsigned long param)
>  
>  	del_timer(&host->timer);
>  
> -	if (host->version >= SDHCI_SPEC_300)
> -		del_timer(&host->tuning_timer);
> -
>  	mrq = host->mrq;
>  
>  	/*

Pushed to mmc-next for 3.1 with Philip's Reviewed-by, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
