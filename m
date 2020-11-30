Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950E2C71155
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Nov 2020 17:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 507612076E
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Nov 2020 17:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eaxlabs.cz header.i=@eaxlabs.cz header.b="Z07XJIeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgK3RVL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Nov 2020 12:21:11 -0500
Received: from ms9.eaxlabs.cz ([147.135.177.209]:35710 "EHLO ms9.eaxlabs.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728178AbgK3RVL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 30 Nov 2020 12:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=eaxlabs.cz; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=6FKTlB6TqmdpxuLkKOUo1N+s1AlhVtz2/lsEveWVg5Y=;
        b=Z07XJIeQkODCNo2kBxdpJSP+hvfc7VgnY6CaE6pfCNKa6QhOQDcb9hOiPn3lWNsY0j0ZGLDhkwXGrNmEWht0EvB4zAkacggkLaWgTsR5zP6m0SfwUzvwPXzSt8HLq1nLtkzHdzZLZ/rrixitDZrFHxVbOZU/qHxMuv41eVovEmc=;
Received: from [82.99.129.6] (helo=[10.76.6.116])
        by ms9.eaxlabs.cz with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <devik@eaxlabs.cz>)
        id 1kjmqh-00017I-Cc; Mon, 30 Nov 2020 18:20:29 +0100
Subject: Re: armmmci rmmod causes hung tasks
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <c5252887-e4f9-953d-88df-d8cc62ecd136@eaxlabs.cz>
 <CAPDyKFr8t-u_4YkuCzQ3Xd3VgxkTq_Anu+NzBo4Pfj8SLBnsvg@mail.gmail.com>
From:   Martin DEVERA <devik@eaxlabs.cz>
Message-ID: <3ce48390-a4fd-f833-1cb5-9f9e140065b8@eaxlabs.cz>
Date:   Mon, 30 Nov 2020 18:20:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFr8t-u_4YkuCzQ3Xd3VgxkTq_Anu+NzBo4Pfj8SLBnsvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 11/30/20 4:08 PM, Ulf Hansson wrote:
> On Sun, 29 Nov 2020 at 19:20, Martin DEVERA <devik@eaxlabs.cz> wrote:
>> Hello,
>>
>> on STM32MP1 with almost vanilla 5.7.7 in single CPU mode. Pair of
>> modprobe armmmci ; rmmod armmmci
>>
>> causes rmmod and kworker to hang. I should note that no MMC is detected
>> on the board (SDIO device on MMC bus is not responding).
>> On another board (where SDIO is responding) rmmod works.
>>
>> It seems as another manifestation of https://lkml.org/lkml/2019/8/27/945
>>
>> Thanks.
>>
>> INFO: task kworker/0:1:12 blocked for more than 368 seconds.
>>         Not tainted 5.7.7kdb-00003-g10397828596c-dirty #224
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> kworker/0:1     D    0    12      2 0x00000000
>> Workqueue: events_freezable mmc_rescan
>> (__schedule) from (schedule+0x5b/0x90)
>> (schedule) from (schedule_timeout+0x1b/0xa0)
>> (schedule_timeout) from (__wait_for_common+0x7d/0xdc)
>> (__wait_for_common) from (mmc_wait_for_req_done+0x1b/0x8c)
>> (mmc_wait_for_req_done) from (mmc_wait_for_cmd+0x4d/0x68)
>> (mmc_wait_for_cmd) from (mmc_io_rw_direct_host+0x87/0xc8)
>> (mmc_io_rw_direct_host) from (sdio_reset+0x3b/0x58)
>> (sdio_reset) from (mmc_rescan+0x15d/0x1d4)
>> (mmc_rescan) from (process_one_work+0xdd/0x168)
>> (process_one_work) from (worker_thread+0x17d/0x1ec)
>> (worker_thread) from (kthread+0x9b/0xa4)
>> (kthread) from (ret_from_fork+0x11/0x28)
> It looks like the worker thread, which runs mmc_rescan() to try to
> detect the SDIO card is hanging. Exactly why, I don't know.
>
> Could be a misconfigured clock, pinctrl or a power domain being
> suddenly gated...

I turned some logging on (see below), IIUC pl18x is starting CMD52 with arg
SDIO_CCCR_ABORT read and it got IRQ later along with response. Then sending
again SDIO_CCCR_ABORT write but no IRQ comes back.

[  135.810802] mmc0: mmc_rescan_try_freq: trying to init card at 400000 Hz
[  135.810832] mmc0: starting CMD52 arg 00000c00 flags 00000195
[  135.810862] mmci-pl18x 48004000.sdmmc: op 34 arg 00000c00 flags 00000195
[  135.811155] mmci-pl18x 48004000.sdmmc: irq0 (data+cmd) 00000040
[  135.811178] mmc0: req done (CMD52): 0: 00000000 00000000 00000000 
00000000
[  135.811202] mmci-pl18x 48004000.sdmmc: irq0 (data+cmd) 00000000
[  135.816487] mmc0: starting CMD52 arg 80000c08 flags 00000195
[  135.816506] mmci-pl18x 48004000.sdmmc: op 34 arg 80000c08 flags 00000195
[  172.150614] random: crng init done
[  172.150642] random: 6 urandom warning(s) missed due to ratelimiting
[  173.290565] INFO: task kworker/0:0:5 blocked for more than 20 seconds.

Here is the same system, only with different (working) SDIO device on 
the same bus:

[  495.654596] mmc0: mmc_rescan_try_freq: trying to init card at 400000 Hz
[  495.654628] mmc0: starting CMD52 arg 00000c00 flags 00000195
[  495.654658] mmci-pl18x 48004000.sdmmc: op 34 arg 00000c00 flags 00000195
[  495.654996] mmci-pl18x 48004000.sdmmc: irq0 (data+cmd) 00000004
[  495.655017] mmc0: req done (CMD52): -110: 00000000 00000000 00000000 
00000000
[  495.655042] mmci-pl18x 48004000.sdmmc: irq0 (data+cmd) 00000000
[  495.660201] mmc0: starting CMD52 arg 80000c08 flags 00000195
[  495.660222] mmci-pl18x 48004000.sdmmc: op 34 arg 80000c08 flags 00000195
[  495.660549] mmci-pl18x 48004000.sdmmc: irq0 (data+cmd) 00000004
[  495.660567] mmc0: req done (CMD52): -110: 00000000 00000000 00000000 
00000000
[  495.660591] mmci-pl18x 48004000.sdmmc: irq0 (data+cmd) 00000000

Should it be expected, that invalid (probably non-responding) device on 
the SDIO bus
causes it to be locked up forever ?
Or is it bug in pl18x driver not handling the error correctly ?

best regards,
Martin

