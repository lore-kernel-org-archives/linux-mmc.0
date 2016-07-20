From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-msm: Do not reset the controller if no card in
 the slot
Date: Wed, 20 Jul 2016 13:57:19 +0300
Message-ID: <578F590F.1070706@intel.com>
References: <1466785499-7563-1-git-send-email-georgi.djakov@linaro.org>
 <20160718174619.GI13516@tuxbot>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:7815 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510AbcGTLB4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Jul 2016 07:01:56 -0400
In-Reply-To: <20160718174619.GI13516@tuxbot>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>, Georgi Djakov <georgi.djakov@linaro.org>
Cc: ulf.hansson@linaro.org, iivanov.xz@gmail.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org

On 18/07/16 20:46, Bjorn Andersson wrote:
> On Fri 24 Jun 09:24 PDT 2016, Georgi Djakov wrote:
> 
>> The controller does not clear the "reset bit" when it is reset without
>> a card in the slot. Because of this, the following error message is seen
>> while booting with no plugged SD card.
>>
>> mmc1: Reset 0x1 never completed.
>>
>> Add the SDHCI_QUIRK_NO_CARD_NO_RESET quirk to avoid this.
>>
>> Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> 
> Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Be aware that SDHCI_QUIRK_NO_CARD_NO_RESET is not well implemented.  It can
result in ->get_cd() being called under spinlock which could be a problem if
a card detect GPIO is used and might sleep.  On the other hand, if you are
not using a card detect GPIO then it shouldn't be a problem.

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> Regards,
> Bjorn
> 
>> ---
>>  drivers/mmc/host/sdhci-msm.c |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index ac5700233e12..c613137ae91e 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -477,6 +477,7 @@ static const struct sdhci_ops sdhci_msm_ops = {
>>  
>>  static const struct sdhci_pltfm_data sdhci_msm_pdata = {
>>  	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
>> +		  SDHCI_QUIRK_NO_CARD_NO_RESET |
>>  		  SDHCI_QUIRK_SINGLE_POWER_WRITE,
>>  	.ops = &sdhci_msm_ops,
>>  };
> 

