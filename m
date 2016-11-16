From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCHv2 06/10] mmc: core: move the cookie's enum values from
 sdhci.h to mmc.h
Date: Wed, 16 Nov 2016 17:25:04 +0900
Message-ID: <89535076-4a77-64a5-68d9-ce15e03b8fb3@samsung.com>
References: <20161115101232.3854-1-jh80.chung@samsung.com>
 <CGME20161115101332epcas2p2c10c90b955b427a510ed8f9631b3fdfe@epcas2p2.samsung.com>
 <20161115101232.3854-7-jh80.chung@samsung.com>
 <12405f58-695d-03d8-407f-d7471e93a6de@samsung.com>
 <ecb4b5d0-4cbf-bf44-3287-f1580b2e990a@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:40592 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752169AbcKPIfG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2016 03:35:06 -0500
In-reply-to: <ecb4b5d0-4cbf-bf44-3287-f1580b2e990a@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, heiko@sntech.de, shawn.lin@rock-chips.com, robh+dt@kernel.org

On 11/16/2016 05:09 PM, Adrian Hunter wrote:
> On 16/11/16 09:53, Jaehoon Chung wrote:
>> Added Adrian for sdhci.h
>>
>> On 11/15/2016 07:12 PM, Jaehoon Chung wrote:
>>> It's not for only sdhci controller.
>>> So it can be moved from sdhci.h to mmc.h. And renamed from sdhci_cookie
>>> to mmc_cookie.
> 
> The cookie is currently host private data, so I don't understand the
> motivation behind this.

dwmmc controller can also use the data->host_cookie. because it's working with post/pre_req().

So i think it can be used about both sdhci and dwmmc.
Is there no reason that add the private dwmmc data?

With these cookie value, update the dwmmc controller for post/pre_req().

https://patchwork.kernel.org/patch/9429287/

Best Regards,
Jaehoon Chung

> 
>>>
>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>>> ---
>>>  drivers/mmc/host/sdhci.h | 6 ------
>>>  include/linux/mmc/core.h | 6 ++++++
>>>  2 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index 766df17..325663b 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -321,12 +321,6 @@ struct sdhci_adma2_64_desc {
>>>  /* Allow for a a command request and a data request at the same time */
>>>  #define SDHCI_MAX_MRQS		2
>>>  
>>> -enum sdhci_cookie {
>>> -	COOKIE_UNMAPPED,
>>> -	COOKIE_PRE_MAPPED,	/* mapped by sdhci_pre_req() */
>>> -	COOKIE_MAPPED,		/* mapped by sdhci_prepare_data() */
>>> -};
>>> -
>>>  struct sdhci_host {
>>>  	/* Data set by hardware interface driver */
>>>  	const char *hw_name;	/* Hardware bus name */
>>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
>>> index 0ce928b..82d707f 100644
>>> --- a/include/linux/mmc/core.h
>>> +++ b/include/linux/mmc/core.h
>>> @@ -118,6 +118,12 @@ struct mmc_command {
>>>  	struct mmc_request	*mrq;		/* associated request */
>>>  };
>>>  
>>> +enum mmc_cookie {
>>> +	COOKIE_UNMAPPED,
>>> +	COOKIE_PRE_MAPPED,	/* mapped by pre_req() of controller */
>>> +	COOKIE_MAPPED,		/* mapped by prepare_data() of controller */
>>> +};
>>> +
>>>  struct mmc_data {
>>>  	unsigned int		timeout_ns;	/* data timeout (in ns, max 80ms) */
>>>  	unsigned int		timeout_clks;	/* data timeout (in clocks) */
>>>
>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

