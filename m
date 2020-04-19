Return-Path: <SRS0=MzXf=6D=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBC1C38A30
	for <linux-mmc@archiver.kernel.org>; Sun, 19 Apr 2020 16:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5283E21974
	for <linux-mmc@archiver.kernel.org>; Sun, 19 Apr 2020 16:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="H1CZqwge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgDSQXn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 19 Apr 2020 12:23:43 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7140 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgDSQXn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Apr 2020 12:23:43 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9c7b020000>; Sun, 19 Apr 2020 09:23:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 19 Apr 2020 09:23:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 19 Apr 2020 09:23:43 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 19 Apr
 2020 16:23:42 +0000
Received: from [10.2.171.241] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 19 Apr
 2020 16:23:41 +0000
Subject: Re: [PATCH 4.19.113 0/3] Fix for long operation cmds busy detection
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <baolin.wang@linaro.org>, <kstewart@linuxfoundation.org>,
        <tglx@linutronix.de>, <bradleybolen@gmail.com>,
        <faiz_abbas@ti.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <bbiswas@nvidia.com>, <anrao@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
References: <1587150844-12003-1-git-send-email-skomatineni@nvidia.com>
 <20200419072030.GB3544449@kroah.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <6911ee08-1376-a515-9393-1ebc6cc6a255@nvidia.com>
Date:   Sun, 19 Apr 2020 09:23:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200419072030.GB3544449@kroah.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587313410; bh=THXoFzL4jbGyEFhE13WdiyX6TS4MJeZeIi9LdpewNtg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=H1CZqwgerootbdKx9l02gfJ/1LjDdG+zc+A0sxaenfQNcoEmHXA6xkbs/rMGiQro1
         hBgdwSoqbG9KdHfLgNFvaDVU0CM1T1ALN4ey4+fxYSn8ZnZm2Yg9t04jrqiBBGuxMc
         +5kIWEARJAzrZrkl+Jawi++Y++kCXrWrwAzK6orthe3K6Q8BacAteK8tCFM3/hE95g
         85SSaaBKf5vmf3+TluBWT+9EUYqdl+5lnwE5Rkv8ScxKuU2S9I5GVExpKKrPqp2lAx
         1ogIUb9zvX2Mo4KhygFQmUL8LnWblToPkMqYaeu0o7sLBYfSk2SSgj3RBhj0HSl179
         8j8wn/E1Qi/nQ==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 4/19/20 12:20 AM, Greg KH wrote:
> External email: Use caution opening links or attachments
>
>
> On Fri, Apr 17, 2020 at 12:14:01PM -0700, Sowjanya Komatineni wrote:
>> This series includes manually backported changes that implements Tegra
>> specific timeout callback to switch between finite and infinite HW busy
>> detection wait modes.
>>
>> sdhci-tegra driver patch implements set_timeout callback based on one of
>> the sdhci host driver patch that refactors sdhci_set_timeout and allows
>> drivers to call __sdhci_set_timeout with their timeout callback
>> implementation.
>>
>> Both of these patches are manually backported in this series.
> Is this a bugfix or a new feature?  I can't tell, but it feels like it's
> a new feature.  What's wrong with just using the 5.4.y kernel tree?
>
> thanks,
>
> greg k-h
Ulf recent patches for increased timeout adds capability 
MMC_CAP_NEED_RSP_BUSY for sdhci-tegra as well.

So, it will always use R1B for R1B type commands so there are no known 
bugs or failures with mmc devices we use on our platforms.

So, we can treat this patch as an improvement for long operation 
commands where HW will wait as long as device is busy.

Yes, should be fine to have this from 5.4.y

For 5.4.y and 5.5.y, we can back-port same patch that was applied to 5.6.y

Will send back-port request of that..

Thanks

Sowjanya

