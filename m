From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: debugfs: add runtime pm when cat ios or clock file
 node
Date: Mon, 24 Apr 2017 10:16:12 +0300
Message-ID: <d3a75424-1ae6-cbc6-ca1e-72a2768bf2ad@intel.com>
References: <1493017393-13785-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:51660 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1166049AbdDXHWH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Apr 2017 03:22:07 -0400
In-Reply-To: <1493017393-13785-1-git-send-email-haibo.chen@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@nxp.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, aisheng.dong@nxp.com

On 24/04/17 10:03, Haibo Chen wrote:
> MMC core code add 'MMC_CAP_RUNTIME_RESUME', postpone the real card
> resume operation from bus_resume to bus_runtime_resume. So after
> system resume, for non-removable-card, it still not really resume.
> At this point, if user cat the ios or clock node, only can get zero
> data although the mmc/sd card is still present.

If you ask me, getting zero is correct.

> 
> This patch add mmc_get_card() to make sure card really resume back
> when user cat ios or clock debugfs file node, then user can get the
> correct information.

Can't the user runtime resume the card / host controller and then look at ios?

> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/core/debugfs.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index a1fba57..23ec9d3 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -58,6 +58,9 @@ static int mmc_ios_show(struct seq_file *s, void *data)
>  	struct mmc_ios	*ios = &host->ios;
>  	const char *str;
>  
> +	if (host->card)
> +		mmc_get_card(host->card);
> +
>  	seq_printf(s, "clock:\t\t%u Hz\n", ios->clock);
>  	if (host->actual_clock)
>  		seq_printf(s, "actual clock:\t%u Hz\n", host->actual_clock);
> @@ -194,6 +197,9 @@ static int mmc_ios_show(struct seq_file *s, void *data)
>  	}
>  	seq_printf(s, "driver type:\t%u (%s)\n", ios->drv_type, str);
>  
> +	if (host->card)
> +		mmc_put_card(host->card);
> +
>  	return 0;
>  }
>  
> @@ -213,7 +219,11 @@ static int mmc_clock_opt_get(void *data, u64 *val)
>  {
>  	struct mmc_host *host = data;
>  
> +	if (host->card)
> +		mmc_get_card(host->card);
>  	*val = host->ios.clock;
> +	if (host->card)
> +		mmc_put_card(host->card);
>  
>  	return 0;
>  }
> 

