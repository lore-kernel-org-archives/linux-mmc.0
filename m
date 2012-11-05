From: Philip Rakity <prakity@nvidia.com>
Subject: Re: UHS-I voltage switching on OLPC XO-1.75
Date: Mon, 5 Nov 2012 14:20:36 +0100
Message-ID: <39289E1F-1E14-4A2D-8ACD-8F8E84342FB4@nvidia.com>
References: <CAMLZHHQfQ26E+BH2sqV9CGyso+uuKHC=WMaqehzBo9_Gr_kyPQ@mail.gmail.com>
 <10400F30-0A08-4B95-9C62-018A3AD4068B@nvidia.com>
 <87hap4b3f6.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:10283 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932319Ab2KENU5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Nov 2012 08:20:57 -0500
In-Reply-To: <87hap4b3f6.fsf@octavius.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Daniel Drake <dsd@laptop.org>, Johan Rudholm <jrudholm@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>



On Nov 5, 2012, at 1:11 PM, Chris Ball <cjb@laptop.org> wrote:

> Hi,
> 
> On Mon, Nov 05 2012, Philip Rakity wrote:
>> Hi Daneil, Chris,
>> 
>> I reviewed kevin's patch in September which fixes this issue.  Chris
>> -- can we pull it into mmc-next ?  This patch is okay as a standalone
>> change.

That was the original intent.

The question is what to do if no regulator.  regulator_get was returning NULL in Daniel;s case.
IS_ERR patch was not taken so UHS support was removed.  
The intent of the original code was to remove UHS support if there was a regulator but it could not support voltage switching.

Phlip

>> 
>> From: Philip Rakity <prakity <at> marvell.com>
>> Subject: Re: [PATCH v2 5/8] mmc: sdhci: fix null return check of regulator_get
>> Newsgroups: gmane.linux.kernel.mmc
>> Date: 2012-09-24 15:02:34 GMT (5 weeks, 6 days, 21 hours and 44 minutes ago)
> 
> It sounds like I misread this patch, then -- I understood it as only
> affecting whether a pr_info() call is made, which would not fix a
> voltage switching bug.  What am I missing?  (Dan, here's a copy of
> Kevin's patch.)
> 
> 
> From: Kevin Liu <kliu5@marvell.com>
> 
> regulator_get() returns NULL when CONFIG_REGULATOR not defined,
> which should not print out the warning.
> 
> Reviewed-by: Philip Rakity <prakity@marvell.com>
> Signed-off-by: Bin Wang <binw@marvell.com>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>
> ---
> drivers/mmc/host/sdhci.c |   18 ++++++++++++------
> 1 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 8e6a6f0..0104ae9 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2845,9 +2845,12 @@ int sdhci_add_host(struct sdhci_host *host)
> 
> 	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
> 	host->vqmmc = regulator_get(mmc_dev(mmc), "vqmmc");
> -	if (IS_ERR(host->vqmmc)) {
> -		pr_info("%s: no vqmmc regulator found\n", mmc_hostname(mmc));
> -		host->vqmmc = NULL;
> +	if (IS_ERR_OR_NULL(host->vqmmc)) {
> +		if (PTR_ERR(host->vqmmc) < 0) {
> +			pr_info("%s: no vqmmc regulator found\n",
> +				mmc_hostname(mmc));
> +			host->vqmmc = NULL;
> +		}
> 	}
> 	else if (regulator_is_supported_voltage(host->vqmmc, 1800000, 1800000))
> 		regulator_enable(host->vqmmc);
> @@ -2903,9 +2906,12 @@ int sdhci_add_host(struct sdhci_host *host)
> 	ocr_avail = 0;
> 
> 	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
> -	if (IS_ERR(host->vmmc)) {
> -		pr_info("%s: no vmmc regulator found\n", mmc_hostname(mmc));
> -		host->vmmc = NULL;
> +	if (IS_ERR_OR_NULL(host->vmmc)) {
> +		if (PTR_ERR(host->vmmc) < 0) {
> +			pr_info("%s: no vmmc regulator found\n",
> +				mmc_hostname(mmc));
> +			host->vmmc = NULL;
> +		}
> 	} else
> 		regulator_enable(host->vmmc);
> 
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
