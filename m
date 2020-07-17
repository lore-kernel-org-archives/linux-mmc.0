Return-Path: <SRS0=+sp8=A4=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384D3C433E1
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jul 2020 13:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E13320734
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jul 2020 13:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Quiv8jsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGQNn3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:43:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41082 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgGQNn3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jul 2020 09:43:29 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06HDhJiO055507;
        Fri, 17 Jul 2020 08:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594993399;
        bh=VrHcPPEnVid74YgUMyuw7FWknMWJNzUYj4tH8EhJzwI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Quiv8jsqlFwpCb6ZJobazuHKI294FxMoQNbePoHMh+XDzmLkZA6HHc68MwonPNhuU
         tLyE++axo4dqRrRAiZVRiOlUgc4xy2pxf8rZ+6INGRexQDtLM2IOdbdqx9lRZZH5Gn
         PkH2oiSZ21a2BnXDZ94FG4J8J5QUoMgLz793ic28=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06HDhJOi093492;
        Fri, 17 Jul 2020 08:43:19 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 08:43:19 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 08:43:19 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06HDhEjZ036929;
        Fri, 17 Jul 2020 08:43:16 -0500
Subject: Re: [PATCH 7/7] arm64: defconfig: Enable AM654x SDHCI controller
To:     Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
CC:     Faiz Abbas <faiz_abbas@ti.com>, Sekhar Nori <nsekhar@ti.com>,
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
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <847fb409-e135-c7b7-bc22-fc2f8952fae3@ti.com>
Date:   Fri, 17 Jul 2020 16:43:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3Uc1X9PY6OnxbgEyBVY1=sx1drW7JrGzcPv1KrXaK7aQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 17/07/2020 16:09, Arnd Bergmann wrote:
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
> Right. To clarify, the soc tree usually has separate branches for dts
> files, soc specific drivers, defconfig files and 32-bit platform code.
> 
> When you pick up patches into your tree, please put them into
> branches that fit into those categories. You can group the patches
> into branches with more fine-grained categories if it makes sense
> (e.g. adding a particularly large driver, adding a new dts files for a
> new soc, or cosmetic cleanups across dts files).
> 
> If any of the categories only have a couple of patches in them, you
> can decide to forward those as patches to soc@kernel.org, but a
> pull request is always ok as well, even for a one-line patch.

Ok thanks for clarification, Arnd.

Based on that, queuing this up for 5.9 myself, thanks.

Will post pull-request next week for it, there appears to be another K3 
SoC related config change pending which I'll pick up also. Just want to 
capture -next results for these to see how well they integrate.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
