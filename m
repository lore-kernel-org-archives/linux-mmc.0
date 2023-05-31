Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203D1C7EE23
	for <linux-mmc@archiver.kernel.org>; Wed, 31 May 2023 21:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjEaVgx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 May 2023 17:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjEaVgf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 May 2023 17:36:35 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BFFE4E
        for <linux-mmc@vger.kernel.org>; Wed, 31 May 2023 14:34:52 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 6269586167;
        Wed, 31 May 2023 23:33:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1685568835;
        bh=LXHXYnBNjGLc5OhcRmIitshrM8QublTqCAW72WBAtw0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QPLNAz5ZZBXzIRYjdZ3rXX2cbx5GdqkQoGhqf30f5X9V+eJvOMWaTrfh1vaKuvTr4
         Be/eUBHpxs0HFUdTVoJWtjaUX2+5j2Kl0yqAdST5zNw+abm6MA/pJaf7aAbqUyZCuo
         V+PA+IFhj5EAGtxIPkgdww28LCSxS/8Y3j4zrkZWLZG4YKtkumhq1iwiKzEk92SMnV
         d7iESsMgPCLtQe/YWsmwKiX/kZxbFQ5GoDDJC5qHSppV/FhoZswhI6wjRdgzjBZjd9
         oVe+dHkKEnEu5lpJZVMyutuWChOAoFHBMpVUmWkMehugfE6vxgx6QOODZqC9HvEKl6
         roFrC7gkFF0Ww==
Message-ID: <3ade78ec-c908-48d0-7d60-a9a4e20c6f76@denx.de>
Date:   Wed, 31 May 2023 23:33:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] [RFC] Revert "mmc: core: Fixup support for
 writeback-cache for eMMC and SD"
Content-Language: en-US
To:     Christian Loehle <CLoehle@hyperstone.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc:     Avri Altman <avri.altman@wdc.com>, Jens Axboe <axboe@kernel.dk>,
        Michael Wu <michael@allwinnertech.com>,
        Ming Lei <ming.lei@redhat.com>,
        Seunghui Lee <sh043.lee@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20230531002740.1235620-1-marex@denx.de>
 <ecad717c-77b5-c78a-795b-2c3019b7452a@intel.com>
 <a69823e8-4e87-9eaa-1cb8-7d1457df1492@denx.de>
 <e1816811f70f490fba860e5838b15495@hyperstone.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <e1816811f70f490fba860e5838b15495@hyperstone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 5/31/23 15:08, Christian Loehle wrote:
> One thing that comes to my mind that would explain the behavior, since all commands itself complete fine is:
> Issuing sd cache flush:
> [   61.992588] mmc1: starting CMD49 arg 10020a00 flags 00000035
> [   61.998152] mmc1:     blksz 512 blocks 1 flags 00000100 tsac 3000 ms
> nsac 0
> [   62.005158] mmci-pl18x 58005000.mmc: blksz 0200 blks 0001 flags 00000100
> [   62.011778] mmci-pl18x 58005000.mmc: op 31 arg 10020a00 flags 00000035
> [   62.018317] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
> [   62.024011] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000100
> [   62.029801] mmc1: req done (CMD49): 0: 00000900 00000000 00000000
> 00000000
> [   62.036708] mmc1:     512 bytes transferred: 0
> [   62.041083] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
> [   62.046988] mmc1: starting CMD48 arg 10020a00 flags 000000b5
> [   62.052487] mmc1:     blksz 512 blocks 1 flags 00000200 tsac 100 ms
> nsac 0
> [   62.059443] mmci-pl18x 58005000.mmc: blksz 0200 blks 0001 flags 00000200
> [   62.066154] mmci-pl18x 58005000.mmc: op 30 arg 10020a00 flags 000000b5
> [   62.072688] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000040
> [   62.078382] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000100
> 
> The kernel reads back the page to ensure it has completed.
> 
> [   62.084173] mmc1: req done (CMD48): 0: 00000900 00000000 00000000
> 00000000
> [   62.091081] mmc1:     512 bytes transferred: 0
> [   62.095455] mmci-pl18x 58005000.mmc: irq0 (data+cmd) 00000000
> 
> 
> [   62.101381] I/O error, dev mmcblk1, sector 8192 op 0x1:(WRITE) flags
> 0x800 phys_seg 1 prio class 2
> 
> Fail here implies that it did indeed fail right after CMD48.
> 
> I would expect a card that does not hold down busy the entire cache flush time would produce the observed behavior.
> The CMD48 is issued ~100ms after the CMD49, so not nearly close to the timeout of 1s.
> 
> That is just one possibility of course, it would need a full trace to confirm.

What kind of trace ?

> For you easier probably something like:
> 
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 72b664ed90cf..c9d3cae0678d 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1354,8 +1354,11 @@ static int sd_flush_cache(struct mmc_host *host)
>                  goto out;
>          }
> 
> -       if (reg_buf[0] & BIT(0))
> +       if (reg_buf[0] & BIT(0)) {
> +               pr_warn("%s: Cache Flush bit still active after busy phase\n",
> +                       mmc_hostname(host));
>                  err = -ETIMEDOUT;
> +       }

Adrian provided a bit more complete patch, I tested that, see my reply 
there.
