Return-Path: <SRS0=VpFb=4X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06255C10DCE
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 10:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9972084E
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 10:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GqAuuiKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgCFKcn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:32:43 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5432 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgCFKcn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Mar 2020 05:32:43 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e6226a00002>; Fri, 06 Mar 2020 02:32:00 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 06 Mar 2020 02:32:42 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 06 Mar 2020 02:32:42 -0800
Received: from [10.26.11.221] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Mar
 2020 10:32:41 +0000
Subject: Re: [BUG] 5.6-rc1 breaks sdhci on tegra-30 ouya
To:     Peter Geis <pgwipeout@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, Dmitry Osipenko <digetx@gmail.com>,
        <linux-tegra@vger.kernel.org>
References: <CAMdYzYoxsBAyBhp+S6LKE060qLLq=XioVVPUmOka0auOo8aXcg@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <1ebbe390-68a6-84a2-8ff9-8dc0d263a69b@nvidia.com>
Date:   Fri, 6 Mar 2020 10:32:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMdYzYoxsBAyBhp+S6LKE060qLLq=XioVVPUmOka0auOo8aXcg@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583490720; bh=obtiUNt5NilhVBtsuredinw/EBtUAZg2XBPtzbtuZwQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=GqAuuiKvD4okaApDoTU+swIgcAQdcx2enpyZxCq23MWHwMJ1+9lN5n0Mg9CdP2T6K
         Xf63JymzKoyOE1gxmD0vOe3W0KKTY/x5qcCWjQpkDG9pyCQPjKpaPp3qfyQXWPUeeW
         +MDn3efRFdzsq2CzEfjYxVwsFIAMKhCxySlgQwjCVhNpQY1dC9ismiBkNsAN4bMO4q
         frB/33bTGoK9PZ6qQYwtCen/dBCvDLspyWPM+k3IeAKV+axHJnOA0lOY7DJFSpcCrj
         lWCaX+rCbKyT7t+VUV84ZqusZ/Yp8FwRlE/BevbE9ulwy3fHb1LqznjEEr1TaQKc1p
         9s/hlI7CVcmtA==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Peter,

On 05/03/2020 20:56, Peter Geis wrote:
> Good Afternoon,
> 
> I have been fighting a bug with sdhci on the tegra-30 based ouya since 5.6-rc1.
> I've traced it to the following commit:
> 
> mmc: core: Specify timeouts for BKOPS and CACHE_FLUSH for eMMC
> 24ed3bd01d6a844fd5e8a75f48d0a3d10ed71bf9
> 
> [   51.401369] mmc0: Card stuck being busy! mmc_poll_for_busy
> [   51.407288] mmc0: cache flush error -110
> [   51.412347] blk_update_request: I/O error, dev mmcblk0, sector 0 op
> 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
> 
> It also caused issues with hitching with the bcm4330 sdio wifi chip.
> 
> Reverting this commit fixes the issue.
> 
> After reverting this commit, with the following commit still intact:
> 
> mmc: core: Default to generic_cmd6_time as timeout in __mmc_switch()
> 
> I am seeing a lot of the following messages:
> [   22.626377] mmc0: unspecified timeout for CMD6 - use generic
> [   22.687349] mmc0: unspecified timeout for CMD6 - use generic
> [   23.362736] mmc0: unspecified timeout for CMD6 - use generic
> [   23.487824] mmc0: unspecified timeout for CMD6 - use generic
> [   23.547674] mmc0: unspecified timeout for CMD6 - use generic
> [   23.745527] mmc0: unspecified timeout for CMD6 - use generic
> [   23.817678] mmc0: unspecified timeout for CMD6 - use generic
> [   24.045600] mmc0: unspecified timeout for CMD6 - use generic
> [   24.155577] mmc0: unspecified timeout for CMD6 - use generic
> [   24.223448] mmc0: unspecified timeout for CMD6 - use generic
> [   24.286257] mmc0: unspecified timeout for CMD6 - use generic

Yes we are seeing this on other Tegra platforms. This is being triaged
in the following thread ...

https://lkml.org/lkml/2020/2/13/781

Cheers
Jon

-- 
nvpublic
