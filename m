From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PACTH v3] mmc: sdhci: Do not allow tuning procedure to be
 interrupted
Date: Wed, 17 Aug 2016 13:47:33 +0300
Message-ID: <eee256ca-3366-b25c-0936-0a80b1510325@intel.com>
References: <1471382729-28472-1-git-send-email-robert.foss@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:37208 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751294AbcHQKwD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Aug 2016 06:52:03 -0400
In-Reply-To: <1471382729-28472-1-git-send-email-robert.foss@collabora.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: robert.foss@collabora.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Bresticker <abrestic@chromium.org>, Kevin Cernekee <cernekee@chromium.org>, Benson Leung <bleung@chromium.org>
Cc: Christopher Freeman <cfreeman@nvidia.com>

On 17/08/16 00:25, robert.foss@collabora.com wrote:
> From: Christopher Freeman <cfreeman@nvidia.com>
> 
> wait_event_interruptible_timeout() will return early if the blocked
> process receives a signal, causing the driver to abort the tuning
> procedure and possibly leaving the controller in a bad state.  Since the
> tuning command is expected to complete quickly (<50ms) and we've set a
> timeout, use wait_event_timeout() instead.
> 
> Signed-off-by: Christopher Freeman <cfreeman@nvidia.com>
> Tested-by: Robert Foss <robert.foss@collabora.com>
> Signed-off-by: Robert Foss <robert.foss@collabora.com>
> Reviewed-by: Benson Leung <bleung@chromium.org>

The mmc block queues are kernel threads which I would expect ignore signals,
so I am curious how you hit this?

In any case:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 0e3d7c0..9e80203 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1960,7 +1960,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  
>  		spin_unlock_irqrestore(&host->lock, flags);
>  		/* Wait for Buffer Read Ready interrupt */
> -		wait_event_interruptible_timeout(host->buf_ready_int,
> +		wait_event_timeout(host->buf_ready_int,
>  					(host->tuning_done == 1),
>  					msecs_to_jiffies(50));
>  		spin_lock_irqsave(&host->lock, flags);
> 

