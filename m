Return-Path: <SRS0=Q/yj=6H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A78EC55191
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Apr 2020 15:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F33B20767
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Apr 2020 15:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="T+a/tLa7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgDWPiS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:38:18 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1426 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgDWPiR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Apr 2020 11:38:17 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ea1b62a0000>; Thu, 23 Apr 2020 08:37:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 23 Apr 2020 08:38:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 23 Apr 2020 08:38:17 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 Apr
 2020 15:38:17 +0000
Received: from [10.2.165.49] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 Apr
 2020 15:38:16 +0000
Subject: Re: [PATCH 5.4.33 0/2] Fix for long operation cmds busy detection
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <baolin.wang@linaro.org>, <kstewart@linuxfoundation.org>,
        <tglx@linutronix.de>, <bradleybolen@gmail.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <anrao@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
References: <1587573149-30269-1-git-send-email-skomatineni@nvidia.com>
 <20200423064755.GA3491005@kroah.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <fe49d36f-65c9-736f-791c-27c602cc3bb8@nvidia.com>
Date:   Thu, 23 Apr 2020 08:38:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200423064755.GA3491005@kroah.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587656234; bh=495s3XStWCdDU+8jNjva2u+UJ0EQp4UZnnUzedvPKBs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=T+a/tLa7vytVN2fptW3Zk2nkVxw6Sh3iyOPvclRLH8bj+6zDo5Am+z8yPGAfe0Ae9
         tDBlCWbdv+yaPJ4AMtfXhF0691igOQONS72SDgMl9TjmPI7P4V2UztY6mZruvRtrFA
         KkuNHWiXFuW8uCAxoB21ZBDU0b8bkoKFNBdUMDgmM9yFpGiXCDId2EZ0kKXNHXPfy3
         LsvAM6V5QxH8WUQgZ04F40Sd5oDhJC9O2feWH5b4D8EfswK69FA+VWW5bmSDyPFROX
         ZH/YCmco99WVLC3RRQybKMF1HYcUXCoLr29/GjHOrS+qpy1hmT5SRRg0HZBCltciy8
         ND3I4CaTtKMSA==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 4/22/20 11:47 PM, Greg KH wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Apr 22, 2020 at 09:32:27AM -0700, Sowjanya Komatineni wrote:
>> This series is to backport the upstream patches that fixes busy detection
>> for long operation mmc commands by implementing Tegra specific timeout
>> callback to switch between finite and infinite HW busy detection wait
>> modes.
>>
>>
>> Sowjanya Komatineni (2):
>>    sdhci: tegra: Implement Tegra specific set_timeout callback
>>    sdhci: tegra: Enable MMC_CAP_WAIT_WHILE_BUSY host capability
>>
>>   drivers/mmc/host/sdhci-tegra.c | 33 +++++++++++++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
> Any specific reason you did not cc: the stable@vger list when asking for
> stable patches to be merged?

I added Cc: <stable@vger.kernel.org> in Signed-off area of patches

Thanks

Sowjanya

