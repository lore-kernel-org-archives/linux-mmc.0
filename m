Return-Path: <SRS0=GOb8=3F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DFAC33CB1
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 14:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D48207FF
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 14:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="HqWi6xby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgAPOw6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:52:58 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:62840 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726371AbgAPOw6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2020 09:52:58 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GEl8OB012021;
        Thu, 16 Jan 2020 15:52:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=pEK7DnnrQJDovo/v2r8fLwawQJqg3M031Vo+8Kfz/2A=;
 b=HqWi6xby7McyKcCdYGKdFEOfHsVZddLFxL0MOMkoX1ifbGgVmJT64lH2pywAl5yYO03p
 B2kxAoilysY+kMw2KPnovPhvMSqm9e7PW/X+ykSjywlOxgRsF298lQGGq4Z9TNfh2tDr
 T2xG4W+PRHwZdpeRrSUR7h0E4ZEGbp87uegGv+miuiEJRPgjhcPKLk1u94AC2+kdANhw
 kqFQvlpr81v6NQSPlOr8jRBOMN4MW8pjxw9R+q6PlZibZ/K7R/ffH9FeHwcpUVeH/DR3
 E9cCxfOC+EzxVwmAXnNjEv7EnD8pocM9TMTugO67h7XqNsvhrwW5JFy0SZH9Fn7nJ/8V dg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xf77b9rgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jan 2020 15:52:41 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 22514100038;
        Thu, 16 Jan 2020 15:52:41 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0EEBC2FF5C9;
        Thu, 16 Jan 2020 15:52:41 +0100 (CET)
Received: from lmecxl0923.lme.st.com (10.75.127.44) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Jan
 2020 15:52:39 +0100
Subject: Re: [PATCH 5/9] dt-bindings: mmc: mmci: add delay block base register
 for sdmmc
To:     Rob Herring <robh@kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20200110134823.14882-1-ludovic.barre@st.com>
 <20200110134823.14882-6-ludovic.barre@st.com> <20200115145645.GA599@bogus>
 <2ce63f11-8b0c-8261-63fa-cd19e874c537@st.com>
 <CAL_JsqJMGY-n07e81iAsj+P7wPHFojBerNnjx8vtvqLTDA7yEw@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <27917fa9-e20f-02f3-d108-761632363347@st.com>
Date:   Thu, 16 Jan 2020 15:52:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJMGY-n07e81iAsj+P7wPHFojBerNnjx8vtvqLTDA7yEw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_04:2020-01-16,2020-01-15 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



Le 1/16/20 à 3:33 PM, Rob Herring a écrit :
> On Thu, Jan 16, 2020 at 3:21 AM Ludovic BARRE <ludovic.barre@st.com> wrote:
>>
>> Hi Rob
>>
>> Le 1/15/20 à 3:56 PM, Rob Herring a écrit :
>>> On Fri, Jan 10, 2020 at 02:48:19PM +0100, Ludovic Barre wrote:
>>>> To support the sdr104 mode, the sdmmc variant has a
>>>> hardware delay block to manage the clock phase when sampling
>>>> data received by the card.
>>>>
>>>> This patch adds a second base register (optional) for
>>>> sdmmc delay block.
>>>>
>>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/mmc/mmci.txt | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
>>>> index 6d3c626e017d..4ec921e4bf34 100644
>>>> --- a/Documentation/devicetree/bindings/mmc/mmci.txt
>>>> +++ b/Documentation/devicetree/bindings/mmc/mmci.txt
>>>> @@ -28,6 +28,8 @@ specific for ux500 variant:
>>>>    - st,sig-pin-fbclk       : feedback clock signal pin used.
>>>>
>>>>    specific for sdmmc variant:
>>>> +- reg                        : a second base register may be defined if a delay
>>>> +                           block is present and used for tuning.
>>>
>>> Which compatibles have a 2nd reg entry?
>>
>> In fact, mmci driver is ARM Amba driver (arm,primecell) and has only one
>> compatible "arm,pl18x".
>> The variants are identified by primecell-periphid property
>> (discovered at runtime with HW block register or defined by
>> device tree property "arm,primecell-periphid").
>>
>> The defaults "arm,pl18x" variants have only one base register,
>> but the SDMMC need a second base register for these
>> delay block registers.
>>
>> example of sdmmc node:
>>          sdmmc1: sdmmc@58005000 {
>>                  compatible = "arm,pl18x", "arm,primecell";
>>                  arm,primecell-periphid = <0x00253180>;
>>                  reg = <0x58005000 0x1000>, <0x58006000 0x1000>;
>>          };
>>
>> what do you advise?
> 
> I missed that this is a primecell block. Just give some indication
> which variants have this 2nd range.

Thanks Rob.
I will add primecell id(s) concerned by this 2nd range.

> 0
> Rob
> 
