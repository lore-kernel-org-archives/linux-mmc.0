From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] mmc: sdhci: fix dma memory leak in sdhci_pre_req()
Date: Fri, 7 Aug 2015 11:34:31 +0200
Message-ID: <55C47BA7.1050500@suse.cz>
References: <1438939790-28310-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1438939790-28310-1-git-send-email-haibo.chen@freescale.com>
Sender: stable-owner@vger.kernel.org
To: Haibo Chen <haibo.chen@freescale.com>, ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, aisheng.dong@freescale.com, shawn.guo@linaro.org, stable@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 08/07/2015, 11:29 AM, Haibo Chen wrote:
> Currently one mrq->data maybe execute dma_map_sg() twice
> when mmc subsystem prepare over one new request, and the
> following log show up:
> 	sdhci[sdhci_pre_dma_transfer] invalid cookie: 24, next-cookie 25

Thanks, I will test it shortly.

> @@ -2157,16 +2147,10 @@ static void sdhci_pre_req(struct mmc_host *mmc, struct mmc_request *mrq,
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
>  
> -	if (mrq->data->host_cookie) {
> -		mrq->data->host_cookie = 0;
> -		return;
> -	}
> +	mrq->data->host_cookie = COOKIE_UNMAPPED;

Just one question. Should we warn if host_cookie != COOKIE_UNMAPPED
instead of the assignment? In other words, if the assignment is
mandatory, it deserves a comment why.

thanks,
-- 
js
suse labs
