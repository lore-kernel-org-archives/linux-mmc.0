Return-Path: <SRS0=5xTW=4I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2EDC11D04
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Feb 2020 11:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7067424672
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Feb 2020 11:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nc7wid8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgBTLWY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 Feb 2020 06:22:24 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34382 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgBTLWY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Feb 2020 06:22:24 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01KBMKba084599;
        Thu, 20 Feb 2020 05:22:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582197740;
        bh=7sz7UwaYZhfjapq4XXvQj1Y6KtkYa1bY7xLS+tvWAGI=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=nc7wid8d9t08+Dan465M+ZZoUxq7lTo1+N4hTYNScWBMbsAwPhyi1dUwCzqbkYyTo
         D1VqyqwHU7Q/DpAl8N87v2AF8RzW+3WJ8ypo57Wv4DKnPMWe0zvpoEzxmXKdTs0w9h
         eRdFLNAeArVE7qO1SeWeaMSCUHEJ2FVO9N9YiZF8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01KBMKmm092249;
        Thu, 20 Feb 2020 05:22:20 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 20
 Feb 2020 05:22:20 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 20 Feb 2020 05:22:20 -0600
Received: from [172.24.190.4] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01KBMHn7048242;
        Thu, 20 Feb 2020 05:22:18 -0600
Subject: Re: [PATCH 1/3] dt-bindings: mmc: sdhci-am654: Update Output tap
 delay binding
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <adrian.hunter@intel.com>
References: <20200108150920.14547-1-faiz_abbas@ti.com>
 <20200108150920.14547-2-faiz_abbas@ti.com> <20200115015037.GA26114@bogus>
 <a437675a-6a18-14bd-f316-77bdd2bc1efb@ti.com>
 <bff6f9d2-6713-e8c1-177e-f5d9ed5adbf1@ti.com>
 <24e6ac71-00c7-f140-86d8-fa5ec0dcaff0@ti.com>
Message-ID: <76a0c96a-b83d-ac21-1e24-6d68e2b70c9c@ti.com>
Date:   Thu, 20 Feb 2020 16:54:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <24e6ac71-00c7-f140-86d8-fa5ec0dcaff0@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Rob,

On 14/02/20 4:28 pm, Faiz Abbas wrote:
> Rob,
> 
> On 07/02/20 3:07 pm, Faiz Abbas wrote:
>> Rob,
>>
>> On 20/01/20 11:00 am, Faiz Abbas wrote:
>>> Hi Rob,
>>>
>>> On 15/01/20 7:20 am, Rob Herring wrote:
>>>> On Wed, Jan 08, 2020 at 08:39:18PM +0530, Faiz Abbas wrote:
>>>>> According to latest AM65x Data Manual[1], a different output tap delay
>>>>> value is recommended for all speed modes. Therefore, replace the
>>>>> ti,otap-del-sel binding with one ti,otap-del-sel- for each MMC/SD speed
>>>>> mode.
>>>>>
>>>>> [1] http://www.ti.com/lit/gpn/am6526
>>>>>
>>>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>>>> ---
>>>>>  .../devicetree/bindings/mmc/sdhci-am654.txt   | 21 +++++++++++++++++--
>>>>>  1 file changed, 19 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.txt b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
>>>>> index 50e87df47971..c6ccecb9ae5a 100644
>>>>> --- a/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
>>>>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
>>>>> @@ -18,7 +18,20 @@ Required Properties:
>>>>>  	- clocks: Handles to the clock inputs.
>>>>>  	- clock-names: Tuple including "clk_xin" and "clk_ahb"
>>>>>  	- interrupts: Interrupt specifiers
>>>>> -	- ti,otap-del-sel: Output Tap Delay select
>>>>> +	Output tap delay for each speed mode:
>>>>> +	- ti,otap-del-sel-legacy
>>>>> +	- ti,otap-del-sel-mmc-hs
>>>>> +	- ti,otap-del-sel-sd-hs
>>>>> +	- ti,otap-del-sel-sdr12
>>>>> +	- ti,otap-del-sel-sdr25
>>>>> +	- ti,otap-del-sel-sdr50
>>>>> +	- ti,otap-del-sel-sdr104
>>>>> +	- ti,otap-del-sel-ddr50
>>>>> +	- ti,otap-del-sel-ddr52
>>>>> +	- ti,otap-del-sel-hs200
>>>>> +	- ti,otap-del-sel-hs400
>>>>> +	  These bindings must be provided otherwise the driver will disable the
>>>>> +	  corresponding speed mode (i.e. all nodes must provide at least -legacy)
>>>>
>>>> Why not just extend the existing property to be an array. We already 
>>>> have properties to enable/disable speed modes.
>>>>
>>>
>>> Its hard to keep track of which modes have values and which don't when
>>> you add an array. This scheme is just easier on anyone adding new values
>>> or updating old values.
>>>
>>> We already disable speed modes based on platform specific properties in
>>> other drivers. In sdhci-omap.c, the driver disables the corresponding
>>> speed mode if the corresponding pinmux and iodelay values are not populated.
>>>
>>
>> Do you agree on above?
>>
> 
> Gentle ping.
> 

Ping.

Thanks,
Faiz
