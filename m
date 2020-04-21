Return-Path: <SRS0=Yb6F=6F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF9AC55183
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Apr 2020 17:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ADCA20736
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Apr 2020 17:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="X4b8B6RI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgDUREp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:04:45 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12335 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgDUREn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Apr 2020 13:04:43 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9f279d0000>; Tue, 21 Apr 2020 10:04:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 21 Apr 2020 10:04:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 21 Apr 2020 10:04:42 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 Apr
 2020 17:04:42 +0000
Received: from [10.2.165.49] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 Apr
 2020 17:04:40 +0000
Subject: Re: [PATCH 4.19.113 0/3] Fix for long operation cmds busy detection
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        "(Exiting) Baolin Wang" <baolin.wang@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bradley Bolen <bradleybolen@gmail.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <1587150844-12003-1-git-send-email-skomatineni@nvidia.com>
 <20200419072030.GB3544449@kroah.com>
 <6911ee08-1376-a515-9393-1ebc6cc6a255@nvidia.com>
 <20200419165204.GA3697430@kroah.com>
 <CAPDyKFrdCip_r0fq2=FswsR8iRtC-Gqv2gbvT6PqFXYcaZyBkw@mail.gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <13eb79ee-726f-3863-2dec-9318d109602c@nvidia.com>
Date:   Tue, 21 Apr 2020 10:04:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrdCip_r0fq2=FswsR8iRtC-Gqv2gbvT6PqFXYcaZyBkw@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587488669; bh=ptrpSmZOQMvw0nRhpdqpN96FKh6de9mBIaM+4ppgBy8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=X4b8B6RISNkMpes5aFvS0NbS4ZoSdsoygr/nfq82VDVK4rOQVT7l0HxOeEEKgOkS8
         dViFgcYxJiNB+IWFL8aZ85B8BdzEafppqmxfKOJk5qTFXBo2suOB9JhWUz/GPSPTBZ
         z9ztgPu0XiyA+Dh2JVhQOQmx3yLWS7NQ0P11kgn28YONJ4+SfnKGokwYXmcvh+i8+/
         NAyf3VmKR1tNjRIgnodBxg6gWBoQblu7rtbl2j0hkHanC11PgXobGkdb3b8Alweg4r
         1aNUpctGLA6cm+4CSFPCl1VWV+MgqKFkChxVzkM0Yqr6l0PcD/Rhh1aWFfJoOHF3kJ
         pHdQ0o4NwkIuA==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 4/20/20 12:01 AM, Ulf Hansson wrote:
> External email: Use caution opening links or attachments
>
>
> On Sun, 19 Apr 2020 at 18:52, Greg KH <gregkh@linuxfoundation.org> wrote:
>> On Sun, Apr 19, 2020 at 09:23:39AM -0700, Sowjanya Komatineni wrote:
>>> On 4/19/20 12:20 AM, Greg KH wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On Fri, Apr 17, 2020 at 12:14:01PM -0700, Sowjanya Komatineni wrote:
>>>>> This series includes manually backported changes that implements Tegra
>>>>> specific timeout callback to switch between finite and infinite HW busy
>>>>> detection wait modes.
>>>>>
>>>>> sdhci-tegra driver patch implements set_timeout callback based on one of
>>>>> the sdhci host driver patch that refactors sdhci_set_timeout and allows
>>>>> drivers to call __sdhci_set_timeout with their timeout callback
>>>>> implementation.
>>>>>
>>>>> Both of these patches are manually backported in this series.
>>>> Is this a bugfix or a new feature?  I can't tell, but it feels like it's
>>>> a new feature.  What's wrong with just using the 5.4.y kernel tree?
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>> Ulf recent patches for increased timeout adds capability
>>> MMC_CAP_NEED_RSP_BUSY for sdhci-tegra as well.
>>>
>>> So, it will always use R1B for R1B type commands so there are no known bugs
>>> or failures with mmc devices we use on our platforms.
>> I have no idea what this means, sorry.
>>
>>> So, we can treat this patch as an improvement for long operation commands
>>> where HW will wait as long as device is busy.
>> Ok, so this isn't a regression and can't match the stable kernel rules,
>> sorry.
> Let me help to clarify. This isn't a regression, correct. However, the
> patch fixes a long outstanding bug for sdhci-tegra.
>
> For some SD/MMC commands, the mmc core may provide a long busy timeout
> trusting the mmc host to cope with it. It has turned out that
> sdhci-tegra didn't, thus it may report a cmd-timeout error, while in
> fact it shouldn't.
>
> I believe that is what the small series of patches should be addressing.
>
> Kind regards
> Uffe

Hi Greg,

Yes, we we don't have failure as of today with mmc devices we are using 
on our platforms.

But this is something thats missing from the beginning to handle 
commands that takes longer than max host timeout and it may fail if any 
operation takes more than max host timeout limit.

So, can we please have this applied to 4.19.113? I will also send 
patches to backport for 5.4 and 5.5?

Thanks

Sowjanya

