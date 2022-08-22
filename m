Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F5BC28D13
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Aug 2022 10:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbiHVKGy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Aug 2022 06:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiHVKGy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Aug 2022 06:06:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D31672AC77;
        Mon, 22 Aug 2022 03:06:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B675513D5;
        Mon, 22 Aug 2022 03:06:53 -0700 (PDT)
Received: from [10.57.15.77] (unknown [10.57.15.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0A723F718;
        Mon, 22 Aug 2022 03:06:48 -0700 (PDT)
Message-ID: <3b88438d-1bb0-e980-b4db-1f8663dc6042@arm.com>
Date:   Mon, 22 Aug 2022 11:06:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] mmc: sdhci-xenon: Fix 2G limitation on AC5 SoC
Content-Language: en-GB
To:     Christoph Hellwig <hch@infradead.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>, iommu@lists.linux.dev,
        Mickey Rachamim <mickeyr@marvell.com>
References: <20220808095237.GA15939@plvision.eu>
 <6c94411c-4847-526c-d929-c9523aa65c11@intel.com>
 <20220808122652.GA6599@plvision.eu>
 <3f96b382-aede-1f52-33cb-5f95715bdf59@intel.com>
 <3d16ebad-ea6c-555e-2481-ca5fb08a6c66@arm.com>
 <20220816205129.GA6438@plvision.eu>
 <94888b3b-8f54-367d-c6b4-5ebfeeafe4c4@arm.com>
 <20220817160730.GA17202@plvision.eu>
 <80d2538c-bac4-cc4f-85ae-352fcf86321d@arm.com>
 <20220818120740.GA21548@plvision.eu> <YwHOCHmKaf7yfgOD@infradead.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YwHOCHmKaf7yfgOD@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2022-08-21 07:17, Christoph Hellwig wrote:
> On Thu, Aug 18, 2022 at 03:07:40PM +0300, Vadym Kochan wrote:
>> It works with the following changes:
>>
>>      #1 dma-ranges = <0x0 0x0 0x2 0x0 0x0 0x80000000>;
>>
>>      #3 swiotlb="force"
>>
>> Is it OK to force the memory allocation from the start for the swiotlb ?
> 
> It should be ok, but isn't really optimal.
> 
> I wonder if we should just allow DT to specify the swiotlb buffer
> location.  Basically have yet another RESERVEDMEM_OF_DECLARE variant
> for it, which shouldn't be all that much work except for figuring
> out the interaction with the various kernel command line options.

We already have all the information we need in the DT (and ACPI), the 
arm64 init code just needs to do a better job of interpreting it 
properly. I'll see what I can come up with once I've finished what I'm 
currently tied up in.

Thanks,
Robin.
