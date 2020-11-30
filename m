Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2FDC5519F
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Nov 2020 07:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8FD120731
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Nov 2020 07:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgK3Hpq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Nov 2020 02:45:46 -0500
Received: from mga12.intel.com ([192.55.52.136]:13438 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgK3Hpq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 30 Nov 2020 02:45:46 -0500
IronPort-SDR: 0fPUOa1EkWo+xVwXLQm2kUzWS3dasgwe7g58gQJffV4hE5D2ZP8mOINi9+51bS2nDKLYfk5aVL
 GStoozAGvpRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9820"; a="151847525"
X-IronPort-AV: E=Sophos;i="5.78,381,1599548400"; 
   d="scan'208";a="151847525"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2020 23:45:00 -0800
IronPort-SDR: liIA8ZbwuNPRDI6KRgu+xm5FfHO1g6QnyEslL3jY2j5QosOCRi+0tMdlnATcgpT3QPVbg1HOfo
 fOti1ZambgVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,381,1599548400"; 
   d="scan'208";a="329485094"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by orsmga003.jf.intel.com with ESMTP; 29 Nov 2020 23:44:54 -0800
Subject: Re: [RFC PATCH v3.1 13/27] mmc: sdhci-uhs2: add set_power() to
 support vdd2
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201106022726.19831-14-takahiro.akashi@linaro.org>
 <3b47a2d4-a281-3fac-29c4-82dd769459a1@intel.com>
 <20201130071550.GD48535@laputa>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <e15f5acb-77f9-ce30-e6d0-67f53bc07421@intel.com>
Date:   Mon, 30 Nov 2020 09:44:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201130071550.GD48535@laputa>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 30/11/20 9:15 am, AKASHI Takahiro wrote:
> On Thu, Nov 26, 2020 at 10:16:27AM +0200, Adrian Hunter wrote:
>> On 6/11/20 4:27 am, AKASHI Takahiro wrote:
>>> This is a UHS-II version of sdhci's set_power operation.
>>> VDD2, as well as VDD, is handled here.
>>>
>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>> ---
>>>  drivers/mmc/host/sdhci-uhs2.c | 80 +++++++++++++++++++++++++++++++++++
>>>  drivers/mmc/host/sdhci-uhs2.h |  2 +
>>>  drivers/mmc/host/sdhci.c      | 58 +++++++++++++++----------
>>>  drivers/mmc/host/sdhci.h      |  2 +
>>>  4 files changed, 119 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
>>> index e2b9743fe17d..2bf78cc4e9ed 100644
>>> --- a/drivers/mmc/host/sdhci-uhs2.c
>>> +++ b/drivers/mmc/host/sdhci-uhs2.c
>>> @@ -98,6 +98,86 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
>>>  }
>>>  EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
>>>  
>>> +void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
>>> +			  unsigned short vdd)
>>
>> This function isn't used, so let's rename it sdhci_uhs2_set_power_noreg and
>> drop regulator support.
> 
> I have no strong opinion, but here Ben might want to further rework
> the new sdhci_uhs2_set_power_noreg() now that it is almost the same as
> GLI's gl9755_set_power()(, adding a new quirk?).
> 
>>> +{
>>> +	struct mmc_host *mmc = host->mmc;
>>> +	u8 pwr;
>>> +
>>> +	/* FIXME: check if flags & MMC_UHS2_SUPPORT? */
>>> +	if (!(host->mmc->caps & MMC_CAP_UHS2)) {
>>
>> As commented in another patch, please use a helper fn
> 
> As said, I would defer this.
> 
>>> +		sdhci_set_power(host, mode, vdd);
>>> +		return;
>>> +	}
>>> +
>>> +	if (mode != MMC_POWER_OFF) {
>>> +		pwr = sdhci_get_vdd_value(vdd);
>>
>> Simpler to open code this esp. as there are only 2 valid values:
>>
>> 		switch (1 << vdd) {
> 
> Can you ignore MMC_VDD_165_195 and MMC_VDD_20_21 here?

They are outside UHS-II spec, but you decide.
