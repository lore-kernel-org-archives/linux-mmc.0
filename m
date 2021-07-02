Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE23FC11F67
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 01:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8487B61411
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 01:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbhGBBEk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Jul 2021 21:04:40 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:36958 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhGBBEk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Jul 2021 21:04:40 -0400
Received: from localhost (unknown [192.168.167.32])
        by lucky1.263xmail.com (Postfix) with ESMTP id 91A2DB0A09;
        Fri,  2 Jul 2021 09:02:03 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from [172.16.12.64] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P29909T139671178565376S1625187716058830_;
        Fri, 02 Jul 2021 09:01:56 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <2b5a0cf30c818905d8e17c12045a82c1>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: arnd@kernel.org
X-RCPT-COUNT: 8
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Message-ID: <6a5d06db-92af-7df0-2c71-e25bad08ee0c@rock-chips.com>
Date:   Fri, 2 Jul 2021 09:02:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:90.0) Gecko/20100101
 Thunderbird/90.0
Cc:     shawn.lin@rock-chips.com, Arnd Bergmann <arnd@arndb.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_mmc=3a_warn_for_invalid_SDIO_data_buffe?=
 =?UTF-8?B?cnPjgJDor7fms6jmhI/vvIzpgq7ku7bnlLFsaW51eC1tbWMtb3duZXJAdmdlci5r?=
 =?UTF-8?B?ZXJuZWwub3Jn5Luj5Y+R44CR?=
To:     Arnd Bergmann <arnd@kernel.org>
References: <20210630122057.2795882-1-arnd@kernel.org>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20210630122057.2795882-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Arnd

On 2021/6/30 20:20, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Jernej Skrabec reported a problem with the cw1200 driver failing on
> arm64 systems with CONFIG_VMAP_STACK=y.
> 
> The driver in this case passes a pointer to a stack variable (in vmalloc
> space) into the sdio layer, which gets translated into an invalid DMA
> address.
> 
> Even without CONFIG_VMAP_STACK, the driver is still unreliable, as
> cache invalidations on the DMA buffer may cause random data corruption
> in adjacent stack slots.
> 
> This could be worked around in the SDIO core, but in the discussion we
> decided that passing a stack variable into SDIO should always be considered
> a bug, as it is for USB drivers.
> 
> Change the sdio core to produce a one-time warning for any on-stack
> (both with and without CONFIG_VMAP_STACK) as well as any vmalloc
> or module-local address that would have the same translation problem.

This was the previous comment about the same topic.
Should we check for mmc_io_rw_direct?

https://www.spinics.net/lists/linux-mmc/msg41794.html

> 
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Link: https://lore.kernel.org/lkml/20210622202345.795578-1-jernej.skrabec@gmail.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/mmc/core/sdio_ops.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
> index 4c229dd2b6e5..14e983faf223 100644
> --- a/drivers/mmc/core/sdio_ops.c
> +++ b/drivers/mmc/core/sdio_ops.c
> @@ -6,6 +6,7 @@
>    */
>   
>   #include <linux/scatterlist.h>
> +#include <linux/sched/task_stack.h>
>   
>   #include <linux/mmc/host.h>
>   #include <linux/mmc/card.h>
> @@ -124,6 +125,7 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
>   	int err;
>   
>   	WARN_ON(blksz == 0);
> +	WARN_ON_ONCE(is_vmalloc_or_module_addr(buf) || object_is_on_stack(buf));
>   
>   	/* sanity check */
>   	if (addr & ~0x1FFFF)
> 


