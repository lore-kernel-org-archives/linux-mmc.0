Return-Path: <SRS0=eJC8=BP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F6EC433E0
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 22:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE7CD2076E
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 22:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T+RhXndV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgHEWlc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Aug 2020 18:41:32 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50488 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgHEWla (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Aug 2020 18:41:30 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 075DGWpe104587;
        Wed, 5 Aug 2020 08:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596633392;
        bh=jv05QMyNRK6yayjZc1mP1MO1HJsGqxdVtsib46m4psw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=T+RhXndV1BPGC6RiOs7bIZtzzRI4KezTc5sDYRlBrjptGzd2t5N7YZbKtslASCm69
         b/5xu9BxUpwVFMXXDLrGZthhOepTcxE1+BIVleZU4bl43OY6PtQJNTighBMU0OqK2P
         ZpdLH+gUqiy+MGAwAKqtJYQPm2GE/UllwhRVIMSk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 075DGWwE068176
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Aug 2020 08:16:32 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 5 Aug
 2020 08:16:32 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 5 Aug 2020 08:16:32 -0500
Received: from [10.250.232.88] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 075DGTr0043569;
        Wed, 5 Aug 2020 08:16:30 -0500
Subject: Re: [PATCH] mmc: sdhci_am654: Add workaround for card detect debounce
 timer
To:     Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>
References: <20200729234130.25056-1-faiz_abbas@ti.com>
 <2d692a90-0e58-ae69-9b5b-c9eb3ffe21ec@intel.com>
 <75b188ef-2755-b833-4756-79f0f171f8bd@ti.com>
 <c5b166c9-f9ba-e01e-b759-57ac93d99832@intel.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <3f7e85c7-b0ba-e6a8-8d9f-091413614773@ti.com>
Date:   Wed, 5 Aug 2020 18:46:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c5b166c9-f9ba-e01e-b759-57ac93d99832@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org
Message-ID: <20200805131628.ZKAgl4w06TMy5inqZV8clcsPVix20_07ZGYzHEZESFY@z>

Hi Adrian,

On 05/08/20 3:16 pm, Adrian Hunter wrote:
> On 5/08/20 11:22 am, Faiz Abbas wrote:
>> Hi Adrian,
>>
>> On 05/08/20 1:44 pm, Adrian Hunter wrote:
>>> On 30/07/20 2:41 am, Faiz Abbas wrote:
>>>> There is a one time delay because of a card detect debounce timer in the
>>>> controller IP. This timer runs as soon as power is applied to the module
>>>> regardless of whether a card is present or not and any writes to
>>>> SDHCI_POWER_ON will return 0 before it expires. This timeout has been
>>>> measured to be about 1 second in am654x and j721e.
>>>>
>>>> Write-and-read-back in a loop on SDHCI_POWER_ON for a maximum of
>>>> 1.5 seconds to make sure that the controller actually powers on.
>>>>
>>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>>> ---
>>>>  drivers/mmc/host/sdhci_am654.c | 21 +++++++++++++++++++++
>>>>  1 file changed, 21 insertions(+)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>>>> index 1718b9e8af63..55cff9de2f3e 100644
>>>> --- a/drivers/mmc/host/sdhci_am654.c
>>>> +++ b/drivers/mmc/host/sdhci_am654.c
>>>> @@ -272,6 +272,7 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
>>>>  	sdhci_set_clock(host, clock);
>>>>  }
>>>>  
>>>> +#define MAX_POWER_ON_TIMEOUT	1500 /* ms */
>>>>  static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
>>>>  {
>>>>  	unsigned char timing = host->mmc->ios.timing;
>>>> @@ -291,6 +292,26 @@ static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
>>>>  	}
>>>>  
>>>>  	writeb(val, host->ioaddr + reg);
>>>> +	if (reg == SDHCI_POWER_CONTROL && (val & SDHCI_POWER_ON)) {
>>>> +		/*
>>>> +		 * Power on will not happen until the card detect debounce
>>>> +		 * timer expires. Wait at least 1.5 seconds for the power on
>>>> +		 * bit to be set
>>>> +		 */
>>>
>>> Can you use readb_poll_timeout() here?
>>>
>>
>> The loop is write -> readback -> check for set bit -> write again and so on until timeout
>> so poll_timeout() calls will not work.
> 
> I mentioned it because pedantically you need to check the condition
> again after a timeout.  Alternatively, the read_poll_timeout macro

Ideally, the timeout will never happen because the internal timer always expires at
1 second. The actual time spent in the loop can be anything less than 1 second
depending on when clocks were enabled

> can be used with a function, something like below (not even compile
> tested!)
> 
> static u8 write_power_on(struct sdhci_host *host, u8 val, int reg)
> {
> 	writeb(val, host->ioaddr + reg);
> 	usleep_range(1000, 10000);
> 	return readb(host->ioaddr + reg);
> }
> 
> #define MAX_POWER_ON_TIMEOUT	1500000 /* us */
> static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
> {
> 	unsigned char timing = host->mmc->ios.timing;
> 	u8 pwr;
> 
> 	if (reg == SDHCI_HOST_CONTROL) {
> 		switch (timing) {
> 		/*
> 		 * According to the data manual, HISPD bit
> 		 * should not be set in these speed modes.
> 		 */
> 		case MMC_TIMING_SD_HS:
> 		case MMC_TIMING_MMC_HS:
> 		case MMC_TIMING_UHS_SDR12:
> 		case MMC_TIMING_UHS_SDR25:
> 			val &= ~SDHCI_CTRL_HISPD;
> 		}
> 	}
> 
> 	writeb(val, host->ioaddr + reg);
> 
> 	/*
> 	 * Power on will not happen until the card detect debounce
> 	 * timer expires. Wait at least 1.5 seconds for the power on
> 	 * bit to be set
> 	 */
> 	if (reg == SDHCI_POWER_CONTROL && (val & SDHCI_POWER_ON) &&
> 	    read_poll_timeout(write_power_on, pwr, (pwr & SDHCI_POWER_ON), 0,
> 			      MAX_POWER_ON_TIMEOUT, false, host, val, reg))
> 			dev_warn(mmc_dev(host->mmc), "Power on failed\n");
> 			return;
> 		}
> 	}
> }
> 

Looks good. Let me add this in v2.

Thanks,
Faiz
