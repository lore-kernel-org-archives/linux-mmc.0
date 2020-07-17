Return-Path: <SRS0=+sp8=A4=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0176C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jul 2020 11:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6BB520829
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jul 2020 11:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EjR/7guw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgGQLUo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:20:44 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58776 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgGQLUn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jul 2020 07:20:43 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06HBKWn3074510;
        Fri, 17 Jul 2020 06:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594984832;
        bh=jQ4FkbUTphg2qbQHxfvAGsCKM+J0mShGKMimgMEZ+AY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EjR/7guwsFW5JD94vt1u1nkrlgZDru7UadP6GAzAMM9HiR+B0FIT4NChButETuMi4
         Nz58IZA/HBBlEsH/R9nn2dClNxKKKihQp1KktS6/eWbVdMN6OZLuQAgX3xeIveCyMf
         E/OldSg4y2VVAFoR1pYhMkOKXs2eye51RBBxnGy8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06HBKWAu119754
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 06:20:32 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 06:20:31 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 06:20:31 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06HBKNWo043822;
        Fri, 17 Jul 2020 06:20:26 -0500
Subject: Re: [PATCH 7/7] arm64: defconfig: Enable AM654x SDHCI controller
To:     Faiz Abbas <faiz_abbas@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Sekhar Nori <nsekhar@ti.com>
List-Id: <soc.lore.kernel.org>
CC:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        ARM-SoC Maintainers <soc@kernel.org>,
        Nishanth Menon <nm@ti.com>
References: <20200619125801.9530-1-faiz_abbas@ti.com>
 <20200619125801.9530-8-faiz_abbas@ti.com>
 <3ed03440-7fbd-6abc-8a15-67e7217e2c3d@ti.com>
 <2e50333c-5387-236f-3fb2-6d8014b224e0@ti.com>
 <CAK8P3a1JpCCCV-CVQj3+eMfWF+=4AuHPpv390Tyj2pKn63_ZVg@mail.gmail.com>
 <75cd485b-e3eb-19ee-ad1f-84cb04b0c807@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <933d7132-5d9f-89df-8dec-5d9f6d3e0eee@ti.com>
Date:   Fri, 17 Jul 2020 14:20:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <75cd485b-e3eb-19ee-ad1f-84cb04b0c807@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 17/07/2020 11:38, Faiz Abbas wrote:
> Hi,
> 
> On 16/07/20 11:58 pm, Arnd Bergmann wrote:
>> On Thu, Jul 16, 2020 at 3:25 PM Sekhar Nori <nsekhar@ti.com> wrote:
>>>
>>> On 7/16/20 5:49 PM, Faiz Abbas wrote:
>>>> Hi,
>>>>
>>>> On 19/06/20 6:28 pm, Faiz Abbas wrote:
>>>>> Enable CONFIG_SDHCI_AM654 to Support AM65x sdhci controller.
>>>>>
>>>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>>>> ---
>>>>>   arch/arm64/configs/defconfig | 1 +
>>>>>   1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>>>> index 883e8bace3ed..40dd13e0adc5 100644
>>>>> --- a/arch/arm64/configs/defconfig
>>>>> +++ b/arch/arm64/configs/defconfig
>>>>> @@ -731,6 +731,7 @@ CONFIG_MMC_DW_ROCKCHIP=y
>>>>>   CONFIG_MMC_SUNXI=y
>>>>>   CONFIG_MMC_BCM2835=y
>>>>>   CONFIG_MMC_SDHCI_XENON=y
>>>>> +CONFIG_MMC_SDHCI_AM654=y
>>>>>   CONFIG_MMC_OWL=y
>>>>>   CONFIG_NEW_LEDS=y
>>>>>   CONFIG_LEDS_CLASS=y
>>>>>
>>>>
>>>> Gentle ping. Will, Catalin, can this patch be picked up?
>>>
>>>  From logs, Arnd has been picking up patches for this file. Looping in
>>> Arnd and ARM-SoC team.
>>
>> I tend to ignore individual patches to the defconfig file unless
>> they are sent to:soc@kernel.org. The best way to get them
>> included is to have the platform maintainers pick up the
>> changes and send them that way as a separate pull request
>> at the same time as sending any DT updates.
>>
>> The MAINTAINERS file lists Tero and Nishanth as maintainers
>> for the platform. If they want, I can apply this one directly, but in
>> the future, send it to them.
>>
> 
> Thanks for clarifying Arnd. Tero, can you pick this up?

Ok, this topic has been bit unclear for me also, but if you say I can 
pick the patches myself and send a pull request out, I can do that.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
