From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: core: Fix bug on signal voltage switch failure
Date: Fri, 1 Apr 2016 10:29:08 +0300
Message-ID: <56FE2344.6060702@intel.com>
References: <1459433831-4162-1-git-send-email-naveenkumar.parna@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:49303 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753293AbcDAHdA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 1 Apr 2016 03:33:00 -0400
In-Reply-To: <1459433831-4162-1-git-send-email-naveenkumar.parna@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Naveen Kumar Parna <naveenkumar.parna@gmail.com>, ulf.hansson@linaro.org, chris@printf.net
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 31/03/16 17:17, Naveen Kumar Parna wrote:
> When switching SD and SDIO cards from 3.3V to 1.8V signal level fails, a bug in sdhci_set_power() will trigger.
> To fix the kernel crash during recovery from signal voltage switch failure, OCR should be reset to avail voltage mask before power-cycle the card.
> 
> Signed-off-by: Naveen Kumar Parna <naveenkumar.parna@gmail.com>
> ---
>  drivers/mmc/core/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index f26a5f1..e7eb427 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1477,6 +1477,8 @@ power_cycle:
>  	if (err) {
>  		pr_debug("%s: Signal voltage switch failed, "
>  			"power cycling card\n", mmc_hostname(host));
> +		/* Reset OCR mask */
> +		ocr =  host->ocr_avail;
>  		mmc_power_cycle(host, ocr);
>  	}
>  
> 


Is this the same as the following?


commit d9bfbb95ed598a09cf336adb0f190ee0ff802f0d
Author: Adrian Hunter <adrian.hunter@intel.com>
Date:   Thu Nov 26 14:00:47 2015 +0200

    mmc: sdio: Fix invalid vdd in voltage switch power cycle

    The 'ocr' parameter passed to mmc_set_signal_voltage()
    defines the power-on voltage used when power cycling
    after a failure to set the voltage.  However, in the
    case of mmc_sdio_init_card(), the value passed has the
    R4_18V_PRESENT flag set which is not valid for power-on
    and results in an invalid vdd.  Fix by passing the card's
    ocr value which does not have the flag.

    Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
    Cc: stable@vger.kernel.org # v3.13+
    Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

