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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2A7C433DF
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 08:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 651A422B45
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 08:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HJgUPSMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgHEIWN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:22:13 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47096 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgHEIWK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Aug 2020 04:22:10 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0758M6fX030350;
        Wed, 5 Aug 2020 03:22:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596615726;
        bh=A4FbrTg4RJJYRYFb3AzvShS3+TIdKDskAnYyskSZux4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HJgUPSMv9yxMfoQVi8xWQD+H929qq013puOgBUEfb59Bf2mhIchKXuWE3KMIBafbZ
         CV/aJmbG7118Z+95xoYcJEagaxXkQDM2rISiJPMax2r9BgF6LvPcD3OeNH4nLLn2q+
         EC6AWwuWKPGdMl6Nm/Fx+JN9AHfKs+Vr4ooVqsxs=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0758M60l095967
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Aug 2020 03:22:06 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 5 Aug
 2020 03:22:05 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 5 Aug 2020 03:22:06 -0500
Received: from [10.250.232.88] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0758M3CC124963;
        Wed, 5 Aug 2020 03:22:04 -0500
Subject: Re: [PATCH] mmc: sdhci_am654: Add workaround for card detect debounce
 timer
To:     Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>
References: <20200729234130.25056-1-faiz_abbas@ti.com>
 <2d692a90-0e58-ae69-9b5b-c9eb3ffe21ec@intel.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <75b188ef-2755-b833-4756-79f0f171f8bd@ti.com>
Date:   Wed, 5 Aug 2020 13:52:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2d692a90-0e58-ae69-9b5b-c9eb3ffe21ec@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

On 05/08/20 1:44 pm, Adrian Hunter wrote:
> On 30/07/20 2:41 am, Faiz Abbas wrote:
>> There is a one time delay because of a card detect debounce timer in the
>> controller IP. This timer runs as soon as power is applied to the module
>> regardless of whether a card is present or not and any writes to
>> SDHCI_POWER_ON will return 0 before it expires. This timeout has been
>> measured to be about 1 second in am654x and j721e.
>>
>> Write-and-read-back in a loop on SDHCI_POWER_ON for a maximum of
>> 1.5 seconds to make sure that the controller actually powers on.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>  drivers/mmc/host/sdhci_am654.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>> index 1718b9e8af63..55cff9de2f3e 100644
>> --- a/drivers/mmc/host/sdhci_am654.c
>> +++ b/drivers/mmc/host/sdhci_am654.c
>> @@ -272,6 +272,7 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
>>  	sdhci_set_clock(host, clock);
>>  }
>>  
>> +#define MAX_POWER_ON_TIMEOUT	1500 /* ms */
>>  static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
>>  {
>>  	unsigned char timing = host->mmc->ios.timing;
>> @@ -291,6 +292,26 @@ static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
>>  	}
>>  
>>  	writeb(val, host->ioaddr + reg);
>> +	if (reg == SDHCI_POWER_CONTROL && (val & SDHCI_POWER_ON)) {
>> +		/*
>> +		 * Power on will not happen until the card detect debounce
>> +		 * timer expires. Wait at least 1.5 seconds for the power on
>> +		 * bit to be set
>> +		 */
> 
> Can you use readb_poll_timeout() here?
> 

The loop is write -> readback -> check for set bit -> write again and so on until timeout
so poll_timeout() calls will not work.

Thanks,
Faiz
