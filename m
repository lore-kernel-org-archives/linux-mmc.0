Return-Path: <SRS0=lJwf=46=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A7BC1975A
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Mar 2020 01:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA5C206FA
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Mar 2020 01:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EKPfrLj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgCMBUD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Mar 2020 21:20:03 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19057 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgCMBUD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Mar 2020 21:20:03 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e6adf650000>; Thu, 12 Mar 2020 18:18:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 12 Mar 2020 18:20:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 12 Mar 2020 18:20:01 -0700
Received: from [10.2.175.141] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 13 Mar
 2020 01:20:01 +0000
Subject: Re: [PATCH v2 1/2] sdhci: tegra: Implement Tegra specific set_timeout
 callback
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Bradley Bolen <bradleybolen@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Jon Hunter" <jonathanh@nvidia.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <1583886030-11339-1-git-send-email-skomatineni@nvidia.com>
 <CAPDyKFpAgk0uboGXdmA_m1-2=GK2oRXVv+97ZFFFAtT-ZZo4fw@mail.gmail.com>
 <7bf5bfb5-b07c-96d3-2c33-124085a36a65@nvidia.com>
 <CAPDyKFoJvaCj=wkV_ok=sLJK18ukf1UavCvDN-E_oFVkpwPbmw@mail.gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <005e7700-3fd4-30c1-064b-df554f96162b@nvidia.com>
Date:   Thu, 12 Mar 2020 18:19:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoJvaCj=wkV_ok=sLJK18ukf1UavCvDN-E_oFVkpwPbmw@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1584062309; bh=R2zXYJhwS1dwVzHFx10EGOVHORgkpNAV1+bLO3zIJfU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=EKPfrLj8hO1BC0al07Ct5FhuU0G6J8Tj12dzE0efy0Qq/nNAbWD176hTkACXG0jOD
         w9OqOq/RlrYkwlgPQ6cJJhc3aQSNfW/huAHq9YK6lLpghflO2D4yLcNRgmzM0kK8Fd
         dVqe/sUdGYUobcbH0i8rI0kJgVLJHpPE9O88M8tm1cfm7NmhkBrDrLFngdkjEL/6MZ
         byaJSWHbb3ZGF1/TINcJWNZhyHzDdeKnbiuuRA1xVMQmKFk4t5cTjBU8VY3MC53WFi
         cNYCoCj55JNe27Fv6oJK8gItqK/uSJ2+rwt9sqHjQKVLM6u015v0hUSrMD2MGSzzOx
         B+mHgJsSg0ZDg==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 3/12/20 8:35 AM, Ulf Hansson wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, 12 Mar 2020 at 16:28, Sowjanya Komatineni
> <skomatineni@nvidia.com> wrote:
>>
>> On 3/12/20 6:08 AM, Ulf Hansson wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> -trimmed cc list
>>>
>>> On Thu, 12 Mar 2020 at 00:51, Sowjanya Komatineni
>>> <skomatineni@nvidia.com> wrote:
>>>> Tegra host supports HW busy detection and timeouts based on the
>>>> count programmed in SDHCI_TIMEOUT_CONTROL register and max busy
>>>> timeout it supports is 11s in finite busy wait mode.
>>>>
>>>> Some operations like SLEEP_AWAKE, ERASE and flush cache through
>>>> SWITCH commands take longer than 11s and Tegra host supports
>>>> infinite HW busy wait mode where HW waits forever till the card
>>>> is busy without HW timeout.
>>>>
>>>> This patch implements Tegra specific set_timeout sdhci_ops to allow
>>>> switching between finite and infinite HW busy detection wait modes
>>>> based on the device command expected operation time.
>>>>
>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>> Applied for next, thanks!
>>>
>>> We should probably tag this for stable as well, don't you think?
>>>
>>> Kind regards
>>> Uffe
>> Yes, we need this for stable as well. As this is applied for next, looks
>> like can't re-send patch with tag.
>>
>> Can you please help to add tag if you don't mind?
> Yes, I will amend the change to add the stable tag, no worries!
>
> Thanks for confirming!
>
> [...]
>
> Kind regards
> Uffe

Thanks Uffe. Somehow patches I sent without mail server configured on 
git 2 days back went out now.

So, please kindly ignore v1 patches and also v2 patches that got resent 
which are actually the patches sent before configuring git mail server 
by mistake 2 days ago.

Sorry about that.

Thanks

Sowjanya

