Return-Path: <SRS0=+qgY=A3=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297BEC433DF
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jul 2020 13:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B96207DD
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jul 2020 13:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WmNl6K61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgGPNZq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:25:46 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58764 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgGPNZq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jul 2020 09:25:46 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06GDPWEb111366;
        Thu, 16 Jul 2020 08:25:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594905932;
        bh=1vXYaDq/w6O6DIT9Ldgxr5ODFmuSY2EP6z/esUKGZ1U=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=WmNl6K616yLuWu86NYQbAaa0ZzAJ025rvLEEZ9R2U7F8kQFG7c7p0xmnp+b8d0Hl8
         4pJ2qF52N72VyLRt1oDAR1KTzax45NDKylnCRFeEuGBpSZtWRe7vY3Qcd4zi8nT0ZP
         qVO52Ul00kXh6+rHSoXq1mSGAuGWYUvu/hdZD220=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06GDPWGv039895
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Jul 2020 08:25:32 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 16
 Jul 2020 08:25:31 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 16 Jul 2020 08:25:31 -0500
Received: from [10.24.69.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06GDPROR070461;
        Thu, 16 Jul 2020 08:25:28 -0500
Subject: Re: [PATCH 7/7] arm64: defconfig: Enable AM654x SDHCI controller
List-Id: <soc.lore.kernel.org>
To:     Faiz Abbas <faiz_abbas@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <adrian.hunter@intel.com>,
        <will@kernel.org>, <catalin.marinas@arm.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        ARM-SoC Maintainers <soc@kernel.org>
References: <20200619125801.9530-1-faiz_abbas@ti.com>
 <20200619125801.9530-8-faiz_abbas@ti.com>
 <3ed03440-7fbd-6abc-8a15-67e7217e2c3d@ti.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <2e50333c-5387-236f-3fb2-6d8014b224e0@ti.com>
Date:   Thu, 16 Jul 2020 18:55:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3ed03440-7fbd-6abc-8a15-67e7217e2c3d@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 7/16/20 5:49 PM, Faiz Abbas wrote:
> Hi,
> 
> On 19/06/20 6:28 pm, Faiz Abbas wrote:
>> Enable CONFIG_SDHCI_AM654 to Support AM65x sdhci controller.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>  arch/arm64/configs/defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 883e8bace3ed..40dd13e0adc5 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -731,6 +731,7 @@ CONFIG_MMC_DW_ROCKCHIP=y
>>  CONFIG_MMC_SUNXI=y
>>  CONFIG_MMC_BCM2835=y
>>  CONFIG_MMC_SDHCI_XENON=y
>> +CONFIG_MMC_SDHCI_AM654=y
>>  CONFIG_MMC_OWL=y
>>  CONFIG_NEW_LEDS=y
>>  CONFIG_LEDS_CLASS=y
>>
> 
> Gentle ping. Will, Catalin, can this patch be picked up?

From logs, Arnd has been picking up patches for this file. Looping in
Arnd and ARM-SoC team.

Thanks,
Sekhar
