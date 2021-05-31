Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC81C47082
	for <linux-mmc@archiver.kernel.org>; Mon, 31 May 2021 08:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E22C61186
	for <linux-mmc@archiver.kernel.org>; Mon, 31 May 2021 08:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhEaI5P (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 May 2021 04:57:15 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:56868 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhEaI5P (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 May 2021 04:57:15 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 06530C8682
        for <linux-mmc@vger.kernel.org>; Mon, 31 May 2021 16:55:21 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from [172.16.12.64] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P32527T140356366624512S1622451321475484_;
        Mon, 31 May 2021 16:55:22 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <3fe68206e72ba72f38c7159b6ce50a38>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: jisheng.zhang@synaptics.com
X-RCPT-COUNT: 5
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Message-ID: <9d0d5cd5-756d-247e-1a45-0849cfb2d65c@rock-chips.com>
Date:   Mon, 31 May 2021 16:55:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101
 Thunderbird/89.0
Cc:     shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: RFC: RPMB write failed with SDHCI Auto CMD23 support
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
References: <a0381554-a17f-1b85-b931-f27f755a4ab3@rock-chips.com>
 <20210531161823.3f91725e@xhacker.debian>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20210531161823.3f91725e@xhacker.debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Jisheng

在 2021/5/31 16:18, Jisheng Zhang 写道:
> On Mon, 31 May 2021 15:51:38 +0800 Shawn Lin <shawn.lin@rock-chips.com> wrote:
> 
> 
>>
>> Hi,
>>
>>       I got some reports about offical mmc-utils rpmb write failure[1] and
>> offical OP-TEE rpmb write failure[2]. Debug it shows the problem is due
>> to the AUTO CMD23 support for sdhci. RPMB issues CMD23 perior to multi
>> block operations with MMC_CMD23_ARG_REL_WR tagged. This tag is ignored
>> by SDHCI AUTO CMD23 routine, so General Failure is always set in RPMB
>> operation result.
> 
> Which host do you see this issue? I'm not sure whether all sdhci host
> has the problem or not. But sdhci-of-dwcmshc does suffer from the problem
> I fixed it with commit ca1219c0a7432 ("mmc: sdhci-of-dwcmshc: fix rpmb access")
> 

Oh, they are using exactly sdhci-of-dwmshc but I didn't notice your 
patch isn't applied on their tree.

>>
>>       Just ask for some suggestions about how to address it.  Does it
>> sound fine to let sdhci_auto_cmd23() or sdhci_manual_cmd23() checks all
>> the 29-31 bits of  mrq->sbc->arg and bailout auto cmd23 sound fine?
> 
> Is this problem common for all sdhci hosts?

I guess maybe some of them were broken for this but we don't get proper
test reports, but at least for sdhci-of-arasan I can check, too.

> 
> Thanks
>>
>>
>> [1]:
>> rk3566_firefly_aiojd4:/ # /data/mmc-utils rpmb read-block
>> /dev/mmcblk2rpmb 0 1 -  /data/rpmbkey | busybox hexdump -C
>> 00000000  79 03 c1 05 a0 6d 45 57  1d d4 7b a4 7c 1f c0 14
>> |y....mEW..{.|...|
>> 00000010  54 34 44 44 62 e5 1a c1  5c 8b 6b 0c 5d 8e 90 4d
>> |T4DDb...\.k.]..M|
>> 00000020  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
>> |................|
>> *
>> 00000100
>> rk3566_firefly_aiojd4:/ # awk 'BEGIN {while (c++<128) printf "ab"}' |
>> /data/mmc-utils rpmb write-block /dev/mmcblk2rpmb 0 -  /data/rpmbkey
>> RPMB operation failed, retcode 0x0001
>>
>> [2]:
>> E/TC:? 0 TA panicked with code 0xffff0000
>> E/LD:  Status of TA 8dddf200-2450-11e4-abe2-0002a5d5c53d
>> E/LD:   arch: arm
>> E/LD:  region  0: va 0xc0004000 pa 0x00400000 size 0x002000 flags rw-s
>> (ldelf)
>> E/LD:  region  1: va 0xc0006000 pa 0x00402000 size 0x006000 flags r-xs
>> (ldelf)
>> E/LD:  region  2: va 0xc000c000 pa 0x00408000 size 0x001000 flags rw-s
>> (ldelf)
>> E/LD:  region  3: va 0xc000d000 pa 0x00409000 size 0x002000 flags rw-s
>> (ldelf)
>> E/LD:  region  4: va 0xc000f000 pa 0x00416000 size 0x001000 flags r--s
>> E/LD:  region  5: va 0xc0010000 pa 0x00001000 size 0x009000 flags r-xs [0]
>> E/LD:  region  6: va 0xc0019000 pa 0x0000a000 size 0x00c000 flags rw-s [0]
>> E/LD:  region  7: va 0xc0025000 pa 0x0040b000 size 0x001000 flags rw-s
>> (stack)
>> E/LD:   [0] 8dddf200-2450-11e4-abe2-0002a5d5c53d @ 0xc0010000
>> E/LD:  Call stack:
>> E/LD:   0xc00118fc
>> E/LD:   0xc001155f
>> E/LD:   0xc00100fd
>> E/LD:   0xc0012029
>> E/LD:   0xc001646f
>> TEEC_InvokeCommand failed with code 0xffff3024 origin 0x3
>>
>>
> 
> 
> 
> 


