Return-Path: <SRS0=QNIT=25=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533DEC4741C
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 11:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B792077B
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 11:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="saA6hY8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgAHLsC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:48:02 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33800 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbgAHLsC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jan 2020 06:48:02 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 008Blr3L114272;
        Wed, 8 Jan 2020 05:47:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578484074;
        bh=9D1eEGCkq7fQxSaBELJBZQG3nVJjzIdnT0Oo/5zXMuQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=saA6hY8ETvgQq1v1QTr570isOCV7cIqSJS+pyEwA98tDt0fvWp1KdKRITSYssFxd8
         dQ/UVZFW6CbP/309pK46+0xDITkyX+XlamRfmHNUGn1rLfkC56QMQqw/nmVAkGhmsW
         hXHsROo3pyAKk/stItvTkWFNAUiYRmT53P7g3w6U=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 008Blrg1023817
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Jan 2020 05:47:53 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 05:47:53 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 05:47:53 -0600
Received: from [172.24.190.4] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008BloAY081874;
        Wed, 8 Jan 2020 05:47:51 -0600
Subject: Re: [PATCH 0/3] Fix issues with command queuing in arasan controllers
To:     Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <shawn.lin@rock-chips.com>
References: <20191230092343.30692-1-faiz_abbas@ti.com>
 <837996b2-c69f-1446-fda4-5577e28ba8e1@ti.com>
 <a1b75d07-17ab-5dec-aa40-b9cff247eabf@intel.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <b2600fd2-bcc9-19f6-8bf8-f3bb51da089f@ti.com>
Date:   Wed, 8 Jan 2020 17:19:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a1b75d07-17ab-5dec-aa40-b9cff247eabf@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Adrian,

On 08/01/20 5:12 pm, Adrian Hunter wrote:
> On 8/01/20 1:30 pm, Faiz Abbas wrote:
>> Hi,
>>
>> On 30/12/19 2:53 pm, Faiz Abbas wrote:
>>> In some Arasan SDHCI controllers, after tuning, the tuning pattern data
>>> is leftover in the sdhci buffer. This leads to issues with future data
>>> commands, especially when command queuing is enabled. The following
>>> patches help fix this issue by resetting data lines after tuning is
>>> finished. The first two patches have been tested with TI's am65x and
>>> j721e SoCs using the sdhci_am654 driver.
>>>
>>> I have a strong suspicion that this is the same issue with
>>> the sdhci-of-arasan driver where they are forced to dump data from the
>>> buffer before enabling command queuing. I need help from someone with a
>>> compatible platform to test this.
>>>
>>
>> I had some discussions with our hardware team and they say we should be
>> asserting both SRC and SRD reset after tuning to start from a clean
>> state. Will update the patches to do that in v2.
> 
> Can you use the ->execute_tuning() for that instead of a quirk?
> 

->platform_execute_tuning() is called before __sdhci_execute_tuning(). I
need this to be done after that. Should I add a post_tuning() callback?

Thanks,
Faiz
