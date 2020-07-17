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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA13C433E1
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jul 2020 08:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED21207F5
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jul 2020 08:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZQ57yMa5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgGQIie (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:38:34 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51540 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgGQIie (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jul 2020 04:38:34 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06H8cMQc035187;
        Fri, 17 Jul 2020 03:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594975102;
        bh=nAQCGUqo2TKuVDp/7DUdhh3dhnBqiYgA4vqkgj5+R5s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZQ57yMa5SWa6rSOSG3EGDx1zmXVwOjgdpKBiymfKbamxzRL7uP1f1ySVuzj4fgxPx
         gJueY0PwRv0BDBbYCKY+588a1oi3Y37T8SeLEaMCZvSECZhYE2eLAKx2D1jJZfgIHX
         fcxatk2cp6yCy87uEPSQfWqQtwx+4X7NGd/W09ZU=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06H8cMef036562;
        Fri, 17 Jul 2020 03:38:22 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 03:38:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 03:38:22 -0500
Received: from [10.250.232.88] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06H8cHcm087224;
        Fri, 17 Jul 2020 03:38:17 -0500
Subject: Re: [PATCH 7/7] arm64: defconfig: Enable AM654x SDHCI controller
To:     Arnd Bergmann <arnd@arndb.de>, Sekhar Nori <nsekhar@ti.com>
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
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
References: <20200619125801.9530-1-faiz_abbas@ti.com>
 <20200619125801.9530-8-faiz_abbas@ti.com>
 <3ed03440-7fbd-6abc-8a15-67e7217e2c3d@ti.com>
 <2e50333c-5387-236f-3fb2-6d8014b224e0@ti.com>
 <CAK8P3a1JpCCCV-CVQj3+eMfWF+=4AuHPpv390Tyj2pKn63_ZVg@mail.gmail.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <75cd485b-e3eb-19ee-ad1f-84cb04b0c807@ti.com>
Date:   Fri, 17 Jul 2020 14:08:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1JpCCCV-CVQj3+eMfWF+=4AuHPpv390Tyj2pKn63_ZVg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 16/07/20 11:58 pm, Arnd Bergmann wrote:
> On Thu, Jul 16, 2020 at 3:25 PM Sekhar Nori <nsekhar@ti.com> wrote:
>>
>> On 7/16/20 5:49 PM, Faiz Abbas wrote:
>>> Hi,
>>>
>>> On 19/06/20 6:28 pm, Faiz Abbas wrote:
>>>> Enable CONFIG_SDHCI_AM654 to Support AM65x sdhci controller.
>>>>
>>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>>> ---
>>>>  arch/arm64/configs/defconfig | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>>> index 883e8bace3ed..40dd13e0adc5 100644
>>>> --- a/arch/arm64/configs/defconfig
>>>> +++ b/arch/arm64/configs/defconfig
>>>> @@ -731,6 +731,7 @@ CONFIG_MMC_DW_ROCKCHIP=y
>>>>  CONFIG_MMC_SUNXI=y
>>>>  CONFIG_MMC_BCM2835=y
>>>>  CONFIG_MMC_SDHCI_XENON=y
>>>> +CONFIG_MMC_SDHCI_AM654=y
>>>>  CONFIG_MMC_OWL=y
>>>>  CONFIG_NEW_LEDS=y
>>>>  CONFIG_LEDS_CLASS=y
>>>>
>>>
>>> Gentle ping. Will, Catalin, can this patch be picked up?
>>
>> From logs, Arnd has been picking up patches for this file. Looping in
>> Arnd and ARM-SoC team.
> 
> I tend to ignore individual patches to the defconfig file unless
> they are sent to:soc@kernel.org. The best way to get them
> included is to have the platform maintainers pick up the
> changes and send them that way as a separate pull request
> at the same time as sending any DT updates.
> 
> The MAINTAINERS file lists Tero and Nishanth as maintainers
> for the platform. If they want, I can apply this one directly, but in
> the future, send it to them.
> 

Thanks for clarifying Arnd. Tero, can you pick this up?

Thanks,
Faiz
