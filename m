From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] sdhci-pxa: add platform specific code for UHS signaling
Date: Thu, 28 Apr 2011 12:37:01 -0700
Message-ID: <9E24E04C-677E-48F7-8EE3-20FE4603D3A2@marvell.com>
References: <95F7D594-60D3-49AA-87DA-63B5970D9787@marvell.com>
 <6C03668EAF45B747AF947A1603D1B300EB72D365@SAUSEXMBP01.amd.com>
 <E043CE35-CAF8-4D3A-987D-E2FB363FCD66@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:51793 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753302Ab1D1TlW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Apr 2011 15:41:22 -0400
In-Reply-To: <E043CE35-CAF8-4D3A-987D-E2FB363FCD66@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <Arindam.Nath@amd.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Arindam,


On Apr 26, 2011, at 8:24 AM, Philip Rakity wrote:

> 
> On Apr 25, 2011, at 11:36 PM, Nath, Arindam wrote:
> 
>> Hi Philip,
>> 
>> 
>>> -----Original Message-----
>>> From: Philip Rakity [mailto:prakity@marvell.com]
>>> Sent: Saturday, April 23, 2011 1:56 AM
>>> To: linux-mmc@vger.kernel.org
>>> Cc: Nath, Arindam
>>> Subject: [PATCH] sdhci-pxa: add platform specific code for UHS
>>> signaling
>>> 
>>> 
>>> Marvell controller requires 1.8V bit in UHS control register 2
>>> be set when doing UHS.  eMMC does not require 1.8V for DDR.
>>> add platform code to handle this.
>>> 
>>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>>> ---
>>> drivers/mmc/host/sdhci-pxa.c |   38
>>> ++++++++++++++++++++++++++++++++++++++
>>> 1 files changed, 38 insertions(+), 0 deletions(-)
>>> 
>>> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-
>>> pxa.c
>>> index 0e64d66..279d677 100644
>>> --- a/drivers/mmc/host/sdhci-pxa.c
>>> +++ b/drivers/mmc/host/sdhci-pxa.c
>>> @@ -94,7 +94,42 @@ static void platform_reset_exit(struct sdhci_host
>>> *host, u8 mask)
>>> 	}
>>> }
>>> 
>>> +static int set_uhs_signaling(struct sdhci_host *host, unsigned int
>>> uhs)
>>> +{
>>> +	u16 ctrl_2;
>>> +
>>> +	/*
>>> +	 * Set V18_EN -- UHS modes do not work without this.
>>> +	 * does not change signaling voltage
>>> +	 */
>>> +	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>> +
>>> +		/* Select Bus Speed Mode for host */
>>> +	ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
>>> +	if (uhs == MMC_TIMING_UHS_SDR12)
>>> +		ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
>>> +	else if (uhs == MMC_TIMING_UHS_SDR25)
>>> +		ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
>>> +	else if (uhs == MMC_TIMING_UHS_SDR50) {
>>> +		ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
>>> +		ctrl_2 |= SDHCI_CTRL_VDD_180;
>>> +	}
>>> +	else if (uhs == MMC_TIMING_UHS_SDR104) {
>>> +		ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
>>> +		ctrl_2 |= SDHCI_CTRL_VDD_180;
>>> +	}
>>> +	else if (uhs == MMC_TIMING_UHS_DDR50) {
>>> +		ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
>>> +		ctrl_2 |= SDHCI_CTRL_VDD_180;
>>> +	}
>> 
>> Since SDR12 and SDR25 are also UHS modes, don't we need to set 1.8V signaling for them as well?
>> 
> will double check with hardware folks.

Do NOT need to set VDD_180 for low speeds.  Code is correct.

> 
>>> +	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> 
> 
>> 
>> I am not sure about your controller, but as per the spec, we need to reset SDCLK before enabling 1.8V, and then re-enable SDCLK. Also there is a delay of 5ms between these two. Is that a concern here?
>> 
> 
> The bit must be set -- no need for 5ms delay since it does not control any power source.  Internal.
> 
>>> +	pr_debug("%s:%s uhs = %d, ctrl_2 = %04X\n",
>>> +		__func__, mmc_hostname(host->mmc), uhs, ctrl_2);
>>> +	return 0;
>>> +}
>> 
>> Since, we are just returning 0 from this function, why not use *void* return type instead?
>> 
>> Thanks,
>> Arindam
>> 
>> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

