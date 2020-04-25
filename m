Return-Path: <SRS0=TOBz=6J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4D3C54FD0
	for <linux-mmc@archiver.kernel.org>; Sat, 25 Apr 2020 02:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECCF42076C
	for <linux-mmc@archiver.kernel.org>; Sat, 25 Apr 2020 02:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eio4xTTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgDYCmX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Apr 2020 22:42:23 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10639 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgDYCmW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Apr 2020 22:42:22 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ea3a3810000>; Fri, 24 Apr 2020 19:42:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 24 Apr 2020 19:42:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 24 Apr 2020 19:42:22 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 25 Apr
 2020 02:42:22 +0000
Received: from [10.2.165.152] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 25 Apr
 2020 02:42:20 +0000
Subject: Re: [PATCH 5.4.33 0/2] Fix for long operation cmds busy detection
To:     Sasha Levin <sashal@kernel.org>
CC:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <baolin.wang@linaro.org>, <kstewart@linuxfoundation.org>,
        <tglx@linutronix.de>, <bradleybolen@gmail.com>,
        <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <anrao@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <stable@vger.kernel.org>
References: <1587758766-3274-1-git-send-email-skomatineni@nvidia.com>
 <20200425014556.GD13035@sasha-vm>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <81be9ca0-5c61-6e94-8398-85354764b429@nvidia.com>
Date:   Fri, 24 Apr 2020 19:42:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200425014556.GD13035@sasha-vm>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587782529; bh=Opl4dqdYSL+nC/1o3/UXZdoUz0oDiE3KFJp+3CLVHVo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=eio4xTTdtgvh4OyHcpWOEFAz8JC/oYWo+aAExgoDDogW+pCq4ssPZcSsZXnyz2rGK
         mFq+nK7TLP5AIxUT8uRm2WjOBgkit/l24T67L2U663Wfu4p4Wve5C+kRamIBuQ1RbO
         wGqxaYOdILSF+74vV24K5Y6SJ0YlhXib+kBBrVtor9CxLE+DmHT82buAwtjagDR/IK
         af6OQX2vjON94w1/bgmpoBWgBXWqfR61brQuGkx/915O0rWfh8Y7l2ceIuoq0HbzVh
         yodwntEYw2TixWGpgsU7r+NdCZVFtUo5EtLwfK01A/IZa00BMglgJbxwbCayocG6ZY
         bt1MPBCxqPHxg==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 4/24/20 6:45 PM, Sasha Levin wrote:
> External email: Use caution opening links or attachments
>
>
> On Fri, Apr 24, 2020 at 01:06:04PM -0700, Sowjanya Komatineni wrote:
>> This series is to backport the upstream patches that fixes busy=20
>> detection
>> for long operation mmc commands by implementing Tegra specific timeout
>> callback to switch between finite and infinite HW busy detection wait
>> modes.
>>
>>
>> Sowjanya Komatineni (2):
>> =C2=A0sdhci: tegra: Implement Tegra specific set_timeout callback
>> =C2=A0sdhci: tegra: Enable MMC_CAP_WAIT_WHILE_BUSY host capability
>
> What regression do these patches fix?
>
This isn't a regression as we don't have any known failures as of today=20
with the specific mmc devices we are using on our platforms.

But this patch fixes a long outstanding bug for sdhci-tegra to handle=20
long busy wait for mmc command operations that may take longer than host=20
max busy timeout. So, this is something that's missing from the=20
beginning and good to have.


> --=20
> Thanks,
> Sasha
