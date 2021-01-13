Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7E3C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 12:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0006123133
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 12:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbhAMMER (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 07:04:17 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40774 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbhAMMEQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 07:04:16 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10DC2dTr047329;
        Wed, 13 Jan 2021 06:02:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610539359;
        bh=UG/0FCP3bvZ9LVXtXp/X6IX8QqQLReO5AkQgPMAX7A8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=I3OPsduoLukd2nMEdMOmQkwu6iSkauTl4H49ipAdztDXUBzYY0e9TP1AEI1PgRWy2
         GKgdhu5fwEiNeFs7rKILlnGpa1oAQcR+/6cVjsCMTDw9RoEIa8Knv1qXBTidAvMu9X
         CB1HkGl7aulabZBheawGRfKSajBnX7E09NQ5/ofg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10DC2dPK034932
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Jan 2021 06:02:39 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 Jan 2021 06:02:39 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 Jan 2021 06:02:38 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10DC2ZOQ009966;
        Wed, 13 Jan 2021 06:02:36 -0600
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-am654: Add compatible string for
 AM64 SoC
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210107055457.14948-1-a-govindraju@ti.com>
 <CAPDyKFp89zPwr-SS9wgR6C5RM+KhSLWbkXivxAttRqTxtiVGDQ@mail.gmail.com>
 <9ad5f3a3-2175-8f43-2481-7bef17828ce2@ti.com>
 <CAPDyKFpTSME=NTZdDUq3+tLpKNdzoBKFZ-B_WDyWzLqNOsx0EQ@mail.gmail.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <b79954dd-b1d0-d2ab-0223-8f48d64f0cd7@ti.com>
Date:   Wed, 13 Jan 2021 17:32:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpTSME=NTZdDUq3+tLpKNdzoBKFZ-B_WDyWzLqNOsx0EQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Uffe,

On 13/01/21 4:57 pm, Ulf Hansson wrote:
> On Wed, 13 Jan 2021 at 12:20, Aswath Govindraju <a-govindraju@ti.com> wrote:
>>
>> Hi Uffe,
>>
>> On 13/01/21 4:26 pm, Ulf Hansson wrote:
>>> On Thu, 7 Jan 2021 at 06:55, Aswath Govindraju <a-govindraju@ti.com> wrote:
>>>>
>>>> Add compatible string for AM64 SoC in device tree binding of AM654 SDHCI
>>>> module as the same IP is used.
>>>>
>>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>>
>>> Do you have a corresponding patch for the driver as well? I would like
>>> to apply them together.
>>>
>>
>> Yes, I do. Here is the link to the patch,
>> https://lore.kernel.org/patchwork/patch/1364589/
> 
> Great. Can you please re-submit them together to the linux-mmc list,
> then I can pick them up.
>

Sent the patches. Here is a link to the series,
https://lore.kernel.org/patchwork/project/lkml/list/?series=479980

> [...]

Thanks,
Aswath


