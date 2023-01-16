Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835F3C46467
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Jan 2023 09:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjAPJJo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Jan 2023 04:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjAPJJX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2023 04:09:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1F41C32F;
        Mon, 16 Jan 2023 01:07:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3310B60EF9;
        Mon, 16 Jan 2023 09:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B66C433EF;
        Mon, 16 Jan 2023 09:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673860031;
        bh=KfOwJKcWTGtct6PgcEN5PTwfSFfDmoGSOMzeq+aA6aI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lnGh1KYs+1ddaRg0hSgKMzK3LYBwz/UA2nJ/4z5SSa1PO3zeQvvFpGVLepmi78Ors
         xg12itfkbpLnpbE8UoRXW2hOBXhxng2kUU2pLo7z2XMHz35cPsZRae0IrHI37Rvn27
         vqkE75PRHKzs0TEKCpV4Q/9vLHM5ysjpunvfnjcGwTLtpbbTxLM5aeo1IagMqcXSBw
         UQWt0jwyhQCMRW/fs7yx5QZX5de/EIWo1c39VqLQF3SViU5nkaXB/EUNsaj3cNEg3n
         lr8KX8KK1ryTZ52EInmDlbatjCcFm7+dHreCE/ep4sXF9p4bI1p7c4tYk0UXAs0k8t
         blrDmIU5UAorQ==
Message-ID: <ce6ad04f-808a-9cd9-f70e-5f228e405807@kernel.org>
Date:   Mon, 16 Jan 2023 10:07:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 5/8] mmc: sdhci-pxav2: add optional core clock
Content-Language: en-US
To:     Dan Carpenter <error27@gmail.com>, Doug Brown <doug@schmorgal.com>
Cc:     oe-kbuild@lists.linux.dev, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
References: <202301140445.zXxR25qN-lkp@intel.com>
 <b5867cb5-aeed-b081-543f-fd611c3c84c9@schmorgal.com> <Y8USwHNZfuaP1ro8@kadam>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <Y8USwHNZfuaP1ro8@kadam>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/01/2023 10:02, Dan Carpenter wrote:
> On Sat, Jan 14, 2023 at 02:49:07PM -0800, Doug Brown wrote:
>> Hi Dan,
>>
>> On 1/14/2023 12:01 AM, Dan Carpenter wrote:
>>> Hi Doug,
>>>
>>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>>
>>> url:    https://github.com/intel-lab-lkp/linux/commits/Doug-Brown/mmc-sdhci-pxav2-add-initial-support-for-PXA168-V1-controller/20230112-102921
>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
>>> patch link:    https://lore.kernel.org/r/20230112022416.8474-6-doug%40schmorgal.com
>>> patch subject: [PATCH v4 5/8] mmc: sdhci-pxav2: add optional core clock
>>> config: riscv-randconfig-m041-20230113
>>> compiler: riscv64-linux-gcc (GCC) 12.1.0
>>>
>>> If you fix the issue, kindly add following tag where applicable
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Reported-by: Dan Carpenter <error27@gmail.com>
>>>
>>> smatch warnings:
>>> drivers/mmc/host/sdhci-pxav2.c:220 sdhci_pxav2_probe() warn: missing error code 'ret'
>>
>> Thanks for passing this on. I definitely forgot an assignment to ret.
>> Since this is correcting an error in my patch that hasn't been accepted
>> yet, is it safe to assume I should omit those Reported-by tags from the
>> next version of my patch, since they don't apply to the patch itself?
>>
> 
> These emails are from the kbuild team and not from me.  I just look them
> over and hit the forward button.  I'm sure it helps the kbuild team in
> their marketing when people use the tags...  Right now I'm applying to
> jobs outside the Linux community so the tags give me a measurable thing
> to say I've helped fix thousands of bugs or whatever...
> 
> I've always argued that there should be a different Fixes-from: tag for
> people who find bugs during review (as opposed to just complaining about
> white space which is its own reward and I do that for free).  So far I
> haven't convinced anyone on this though.

Oh, I am in. This is considerable effort to find bugs on the mailing
lists or in linux-next. Even if it is pure bisect and test, it's a lot
of time. If it is not credited, we loose some valuable feedback and
incentives.

Best regards,
Krzysztof

