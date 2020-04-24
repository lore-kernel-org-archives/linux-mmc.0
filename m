Return-Path: <SRS0=wlIT=6I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BD8C54FD0
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Apr 2020 18:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5E68206B9
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Apr 2020 18:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QEOZTeNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgDXSJt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Apr 2020 14:09:49 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7067 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgDXSJt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Apr 2020 14:09:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ea32b600000>; Fri, 24 Apr 2020 11:09:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 24 Apr 2020 11:09:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 24 Apr 2020 11:09:48 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 Apr
 2020 18:09:48 +0000
Received: from [10.2.165.49] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 Apr
 2020 18:09:47 +0000
Subject: Re: [PATCH 5.4.33 0/2] Fix for long operation cmds busy detection
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "(Exiting) Baolin Wang" <baolin.wang@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bradley Bolen <bradleybolen@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        "Aniruddha Tvs Rao" <anrao@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <1587573149-30269-1-git-send-email-skomatineni@nvidia.com>
 <20200423064755.GA3491005@kroah.com>
 <fe49d36f-65c9-736f-791c-27c602cc3bb8@nvidia.com>
 <CAPDyKFo0vx1=_j5M-X068n8Xp3wU9JVrXkADCDcGX0Q1oRBzRg@mail.gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <d19d40a9-2269-715d-05eb-7765bb11e406@nvidia.com>
Date:   Fri, 24 Apr 2020 11:09:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFo0vx1=_j5M-X068n8Xp3wU9JVrXkADCDcGX0Q1oRBzRg@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587751776; bh=VpFfLRTzQGXO4uDv64krxQ78es1/hZFyrKiqoQCK8WE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=QEOZTeNnb2g0X/rXEYYWtacqEzjVvAOU8dDfYHNKmRQIV8wunu/7+aR1X5g5bTzGj
         74ec025ZMn9KjhWo/bT7GaSaeJH3/idx86d/ajyGn+TuiY5mtHnDYgBNiPIGcnPyma
         GMZ2Ah3pbLqL4CqZJsAdLZHWzZ5yQv1GnAJ4kUwzD0yv/eCOW/UgbN3zClKtuFf708
         HU56UQN9aG0PoMpS3o/43JNW0SfyGx4KOvwoXWse8EO1Ec1ig2K9MPZ3tEJ67lDVpW
         7G8JzLRudr52Y01OPpbyGHGwb+lMGXRFbh5s7qauxDwGfmbYlBpZrPnv3fLzisyU0f
         Khd07KBOJ5vwQ==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 4/24/20 12:23 AM, Ulf Hansson wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, 23 Apr 2020 at 17:38, Sowjanya Komatineni
> <skomatineni@nvidia.com> wrote:
>>
>> On 4/22/20 11:47 PM, Greg KH wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Wed, Apr 22, 2020 at 09:32:27AM -0700, Sowjanya Komatineni wrote:
>>>> This series is to backport the upstream patches that fixes busy detection
>>>> for long operation mmc commands by implementing Tegra specific timeout
>>>> callback to switch between finite and infinite HW busy detection wait
>>>> modes.
>>>>
>>>>
>>>> Sowjanya Komatineni (2):
>>>>     sdhci: tegra: Implement Tegra specific set_timeout callback
>>>>     sdhci: tegra: Enable MMC_CAP_WAIT_WHILE_BUSY host capability
>>>>
>>>>    drivers/mmc/host/sdhci-tegra.c | 33 +++++++++++++++++++++++++++++++++
>>>>    1 file changed, 33 insertions(+)
>>> Any specific reason you did not cc: the stable@vger list when asking for
>>> stable patches to be merged?
>> I added Cc: <stable@vger.kernel.org> in Signed-off area of patches
> I think Greg meant you actually need to send manually backported
> patches to stable@vger.kernel.org. This helps Greg and Sasha to pick
> them up.
>
> Kind regards
> Uffe

Sorry. Thanks Uffe and Greg. Will resend...

Thanks

Sowjanya

