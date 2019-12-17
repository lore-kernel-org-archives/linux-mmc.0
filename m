Return-Path: <SRS0=9I0v=2H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E433C43603
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 12:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F88A21739
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 12:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rDdNNzxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfLQMPl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:15:41 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56022 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfLQMPl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2019 07:15:41 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBHCFX20050766;
        Tue, 17 Dec 2019 06:15:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576584933;
        bh=tiBTZBVZZUyfG1wtAQA0cbMS1Uad3ftsgVbxfku27BA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rDdNNzxMLMOiRS1WpGu33OEooLiBoWmayuhWEVcEl8xD4kephNvZ6WMOpBiVbvgF4
         NIpyvCFdqzef4VJxFzxJelT5lMPiLS3S2GxlK/eJzgeIXBLMwXt9zWUYjZIWnagyYI
         WNlIfoXDcDtukgFfwn7ijPLyYqTj6egtX2mvlVvU=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBHCFXK5008159
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Dec 2019 06:15:33 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 06:15:33 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 06:15:33 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHCFUbD038749;
        Tue, 17 Dec 2019 06:15:31 -0600
Subject: Re: [PATCH] mmc: bcm2835: Use dma_request_chan() instead
 dma_request_slave_channel()
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        <ulf.hansson@linaro.org>, <f.fainelli@gmail.com>,
        <rjui@broadcom.com>, <sbranden@broadcom.com>
CC:     <vkoul@kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20191217112625.30715-1-peter.ujfalusi@ti.com>
 <cd316378273d18b93b5dcad8b357821a708c7805.camel@suse.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <1eecb651-cce7-b099-e2d2-65dcde357a71@ti.com>
Date:   Tue, 17 Dec 2019 14:15:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cd316378273d18b93b5dcad8b357821a708c7805.camel@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 17/12/2019 13.37, Nicolas Saenz Julienne wrote:
> Hi Peter,
> 
> On Tue, 2019-12-17 at 13:26 +0200, Peter Ujfalusi wrote:
>> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
>> eating up the error code.
>>
>> By using dma_request_chan() directly the driver can support deferred
>> probing against DMA.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/mmc/host/bcm2835.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
>> index 99f61fd2a658..3821f159d36d 100644
>> --- a/drivers/mmc/host/bcm2835.c
>> +++ b/drivers/mmc/host/bcm2835.c
>> @@ -1393,7 +1393,15 @@ static int bcm2835_probe(struct platform_device *pdev)
>>  	host->dma_chan = NULL;
>>  	host->dma_desc = NULL;
>>  
>> -	host->dma_chan_rxtx = dma_request_slave_channel(dev, "rx-tx");
>> +	host->dma_chan_rxtx = dma_request_chan(dev, "rx-tx");
>> +	if (IS_ERR(host->dma_chan_rxtx)) {
>> +		if (PTR_ERR(host->dma_chan_rxtx) == -EPROBE_DEFER)
>> +			return -EPROBE_DEFER;
> 
> I think you should 'goto err' here, as you have to free the mmc host structure
> allocated earlier in the probe function.

You are right.

> Other than that the patch looks good to me.
> 
> Regards,
> Nicolas
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
