Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34796C54EBE
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Jan 2023 19:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjAPTGi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Jan 2023 14:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbjAPTGd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2023 14:06:33 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081B4274A9
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 11:06:30 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id e10so20280432pgc.9
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 11:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91ZFpHOn6J6HW3gQc5uVQqgbo3s2QBuJSgWB7j6dJ1Y=;
        b=aiROAaDjGzwmCpffx/+AVf2woR7VKs5ibtQZi6BdTTy8NNRCHKkNg2EeNpP0SCf89s
         en6ZOysQBhi98+IO9LVlavg88ax6T3JCVqqj6OOkIfD4ihg92rMdzJqnVi/J3xddeaYs
         pPdBClKt7hj6UWzsaET0qLhm9O3MSNXVUSBq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91ZFpHOn6J6HW3gQc5uVQqgbo3s2QBuJSgWB7j6dJ1Y=;
        b=z00zZclOKDQIboHy1aI9YlD5SMLwQd+SkOsQOvsyG9FSbb5iNxUjzQtJujBgYYuDkS
         PaKPLc1lvRN4fhW+7EuSoCQtjY/4vmk29QSg2Fnf4I3qgqlG/RbnvHqCWiZ2pwklEt3B
         bHnMfGNMCu98n/lAm3J4WodOx/l4kdUPMrs37QwnyQLo5TnfiUpSrjqn4DWCSXbfsKFr
         K3qJxX5VBZMv9BndH1LTXZ9zjJHiTfXTzvJ2t8EsoZiZjTTzKH+jjBScSHFgiLoK8Guw
         lz9SibRpcTV38F/kdEm8TucypgIOqZhU4MF3d7kKzab4dJJc0WRaH/5qQDCwEeDS25NX
         Jk6A==
X-Gm-Message-State: AFqh2kpqozD/yNqO/tKJ+Yoq6kQKpTxKg/n1hB2aW54XCGyuWrlKXSro
        5h8ERwIC5xC2pp1m8txz0k6PZg==
X-Google-Smtp-Source: AMrXdXvbJiJuE4bJq6QqVWFBHFFDbaokkSYmrDVcf+f78DNJy/k+l1NouTgxMpt3urzF+MoHA+VMEA==
X-Received: by 2002:aa7:8611:0:b0:582:df2e:595d with SMTP id p17-20020aa78611000000b00582df2e595dmr660199pfn.4.1673895989160;
        Mon, 16 Jan 2023 11:06:29 -0800 (PST)
Received: from [192.168.1.33] ([192.183.212.197])
        by smtp.googlemail.com with ESMTPSA id c4-20020a624e04000000b00586fbbdf6e4sm16356186pfb.34.2023.01.16.11.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 11:06:28 -0800 (PST)
Message-ID: <a75bee25-f55d-eaff-efe1-204c0859dc26@schmorgal.com>
Date:   Mon, 16 Jan 2023 11:06:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Dan Carpenter <error27@gmail.com>
Cc:     oe-kbuild@lists.linux.dev, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
References: <202301140445.zXxR25qN-lkp@intel.com>
 <b5867cb5-aeed-b081-543f-fd611c3c84c9@schmorgal.com> <Y8USwHNZfuaP1ro8@kadam>
From:   Doug Brown <doug@schmorgal.com>
Subject: Re: [PATCH v4 5/8] mmc: sdhci-pxav2: add optional core clock
In-Reply-To: <Y8USwHNZfuaP1ro8@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 1/16/2023 1:02 AM, Dan Carpenter wrote:
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
> 
> Anyway, there isn't a policy one way or the other.  Some people add
> them and some don't.  Some people add them below the --- cut off line,
> but I don't know if that's deliberate or what the story is there.  That
> seems like it might be a good compromise.

Thanks for all the added context. I knew you had forwarded it from the
kbuild team but I wasn't sure who to ask for clarification. Your idea
for a future Fixes-from: tag for this type of thing makes perfect sense.
For now, it seems that if the git log might be used for obtaining
metrics, I should just go ahead and put the Reported-by: tags in. I
really appreciate that you took the time to explain this to me.
