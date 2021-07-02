Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA39C11F68
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 08:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8813C61420
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 08:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhGBISV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Jul 2021 04:18:21 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:59104 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhGBISU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Jul 2021 04:18:20 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 522C7D5B08;
        Fri,  2 Jul 2021 16:15:41 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from [172.16.12.64] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P5174T139827997558528S1625213740712327_;
        Fri, 02 Jul 2021 16:15:41 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <10bccc0beac9a78a0800e5cc03c23b92>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: arnd@kernel.org
X-RCPT-COUNT: 7
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Message-ID: <69f14b04-2ffe-95e3-c6a2-ee6f2628144a@rock-chips.com>
Date:   Fri, 2 Jul 2021 16:15:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:90.0) Gecko/20100101
 Thunderbird/90.0
Cc:     shawn.lin@rock-chips.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_mmc=3a_warn_for_invalid_SDIO_data_buffe?=
 =?UTF-8?B?cnPjgJDor7fms6jmhI/vvIzpgq7ku7bnlLFsaW51eC1tbWMtb3duZXJAdmdlci5r?=
 =?UTF-8?B?ZXJuZWwub3Jn5Luj5Y+R44CR?=
To:     Arnd Bergmann <arnd@kernel.org>
References: <20210630122057.2795882-1-arnd@kernel.org>
 <6a5d06db-92af-7df0-2c71-e25bad08ee0c@rock-chips.com>
 <CAK8P3a3UjLfKpsg2M-RP3AO3CVCnZrbD71uaLf0+iiJ9RJsHCQ@mail.gmail.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAK8P3a3UjLfKpsg2M-RP3AO3CVCnZrbD71uaLf0+iiJ9RJsHCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2021/7/2 15:03, Arnd Bergmann wrote:
> On Fri, Jul 2, 2021 at 3:02 AM Shawn Lin <shawn.lin@rock-chips.com> wrote:
>> On 2021/6/30 20:20, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> Jernej Skrabec reported a problem with the cw1200 driver failing on
>>> arm64 systems with CONFIG_VMAP_STACK=y.
>>>
>>> The driver in this case passes a pointer to a stack variable (in vmalloc
>>> space) into the sdio layer, which gets translated into an invalid DMA
>>> address.
>>>
>>> Even without CONFIG_VMAP_STACK, the driver is still unreliable, as
>>> cache invalidations on the DMA buffer may cause random data corruption
>>> in adjacent stack slots.
>>>
>>> This could be worked around in the SDIO core, but in the discussion we
>>> decided that passing a stack variable into SDIO should always be considered
>>> a bug, as it is for USB drivers.
>>>
>>> Change the sdio core to produce a one-time warning for any on-stack
>>> (both with and without CONFIG_VMAP_STACK) as well as any vmalloc
>>> or module-local address that would have the same translation problem.
>>
>> This was the previous comment about the same topic.
>> Should we check for mmc_io_rw_direct?
>>
>> https://www.spinics.net/lists/linux-mmc/msg41794.html
> 
> Hi Shawn,
> 
> thank you for remembering that previous discussion, that is a
> good question. Looking at the code though, I don't actually
> see any part of mmc_io_rw_direct() doing DMA on a caller-provided
> buffer. The only thing I see in the code is a 'u8 *out' argument, but
> that is just a pointer to a single byte that is set by this function.
> 

I didn't quite get the point we need check out for
mmc_io_rw_direct() either. As I thought what Ulf was suggesting was some
controllers might use data fifo to get cmd response and get DMA
involved? But I don't see a explicit one.

> Do you see any other issue with that function, or does that mean
> we don't have to change it?
> 
>         Arnd
> 
> 
> 


