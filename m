From: Arend van Spriel <arend@broadcom.com>
Subject: Re: [PATCH V2 15/15] mmc: core: Don't print reset warning if reset
 is not supported
Date: Mon, 9 Feb 2015 10:33:48 +0100
Message-ID: <54D87EFC.9060404@broadcom.com>
References: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com> <1422522030-17793-16-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:43035 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759875AbbBIJdv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Feb 2015 04:33:51 -0500
In-Reply-To: <1422522030-17793-16-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>

On 01/29/15 10:00, Adrian Hunter wrote:
> Check the error code for EOPNOTSUPP and do not print
> reset warning in that case.
>
> Signed-off-by: Adrian Hunter<adrian.hunter@intel.com>
> ---
>   drivers/mmc/core/core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 392a150..d439bf0 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2368,7 +2368,8 @@ int mmc_hw_reset(struct mmc_host *host)
>   	ret = host->bus_ops->reset(host);
>   	mmc_bus_put(host);
>
> -	pr_warn("%s: tried to reset card\n", mmc_hostname(host));
> +	if (ret != -EOPNOTSUPP)
> +		pr_warn("%s: tried to reset card\n", mmc_hostname(host));

Guess you don't want this message either if ret is zero.

Gr. Avs

>   	return ret;
>   }

