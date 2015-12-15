From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: It is not an error for the card to be removed while
 suspended
Date: Tue, 15 Dec 2015 13:01:04 +0900
Message-ID: <566F9080.6030903@samsung.com>
References: <1450101087-24391-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:38101 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057AbbLOEBH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2015 23:01:07 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NZD02EB4SHTRR40@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 15 Dec 2015 13:01:05 +0900 (KST)
In-reply-to: <1450101087-24391-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi, Adrian.

On 12/14/2015 10:51 PM, Adrian Hunter wrote:
> A card can be removed while it is runtime suspended.
> Do not print an error message.

Well, if card is non-removable (in case of eMMC, card can be non-removable),
 it needs to print the error message?
I'm not sure what's correct..but just my opinion.

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/mmc.c | 2 +-
>  drivers/mmc/core/sd.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 549c56e8cf6b..bf49e44571f2 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1935,7 +1935,7 @@ static int mmc_runtime_resume(struct mmc_host *host)
>  	int err;
>  
>  	err = _mmc_resume(host);
> -	if (err)
> +	if (err && err != -ENOMEDIUM)
>  		pr_err("%s: error %d doing runtime resume\n",
>  			mmc_hostname(host), err);
>  
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 8f3b46a56b3d..f2b164b214ae 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1158,7 +1158,7 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
>  	int err;
>  
>  	err = _mmc_sd_resume(host);
> -	if (err)
> +	if (err && err != -ENOMEDIUM)
>  		pr_err("%s: error %d doing runtime resume\n",
>  			mmc_hostname(host), err);
>  
> 

