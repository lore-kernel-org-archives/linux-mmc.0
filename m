Return-Path: <SRS0=+sp8=A4=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D789C433E2
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jul 2020 13:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DAB520734
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jul 2020 13:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eOLjwKsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgGQNgw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:36:52 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49488 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgGQNgw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jul 2020 09:36:52 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06HDafpT114516;
        Fri, 17 Jul 2020 08:36:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594993002;
        bh=nX35DTen3KepnW22tRHvoRm3iZKHpTmApYwnPsGvDLg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=eOLjwKsuO0vACSIstqm/OpUPdyBH7R3o26NlvnoNGxeYE+Q2p3CfvjJoojhsJijCa
         kS8hjrNBGT+9e12rnK7RLLXLqRiIX+chbMdgxq3+W/j+PXnRiFATUnvO0XR/bWhI0c
         TAEzHCyZvqcZ9athU78TV4ZSgxp/pCq+82G0FYsE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06HDafMS083455
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 08:36:41 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 08:36:41 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 08:36:41 -0500
Received: from [10.250.232.88] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06HDaTLH019020;
        Fri, 17 Jul 2020 08:36:37 -0500
Subject: Re: [PATCH 7/7] arm64: defconfig: Enable AM654x SDHCI controller
To:     Arnd Bergmann <arnd@arndb.de>, Tero Kristo <t-kristo@ti.com>
List-Id: <soc.lore.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
 <933d7132-5d9f-89df-8dec-5d9f6d3e0eee@ti.com>
 <CAK8P3a3Uc1X9PY6OnxbgEyBVY1=sx1drW7JrGzcPv1KrXaK7aQ@mail.gmail.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <f603084a-64bd-bc1b-a516-5c8bdbc99d8b@ti.com>
Date:   Fri, 17 Jul 2020 19:06:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3Uc1X9PY6OnxbgEyBVY1=sx1drW7JrGzcPv1KrXaK7aQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Tero,

On 17/07/20 6:39 pm, Arnd Bergmann wrote:
> On Fri, Jul 17, 2020 at 1:20 PM Tero Kristo <t-kristo@ti.com> wrote:
>> On 17/07/2020 11:38, Faiz Abbas wrote:
>>> On 16/07/20 11:58 pm, Arnd Bergmann wrote:
>>>> On Thu, Jul 16, 2020 at 3:25 PM Sekhar Nori <nsekhar@ti.com> wrote:
>>>> I tend to ignore individual patches to the defconfig file unless
>>>> they are sent to:soc@kernel.org. The best way to get them
>>>> included is to have the platform maintainers pick up the
>>>> changes and send them that way as a separate pull request
>>>> at the same time as sending any DT updates.
>>>>
>>>> The MAINTAINERS file lists Tero and Nishanth as maintainers
>>>> for the platform. If they want, I can apply this one directly, but in
>>>> the future, send it to them.
>>>>
>>>
>>> Thanks for clarifying Arnd. Tero, can you pick this up?
>>
>> Ok, this topic has been bit unclear for me also, but if you say I can
>> pick the patches myself and send a pull request out, I can do that.
> 

Patches 1-6 are being merged from mmc tree. You only need to pick up this patch.

Thanks,
Faiz
