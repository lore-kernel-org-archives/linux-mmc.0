Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E82C3E8C5
	for <linux-mmc@archiver.kernel.org>; Sun, 29 Nov 2020 19:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDC0820829
	for <linux-mmc@archiver.kernel.org>; Sun, 29 Nov 2020 19:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eaxlabs.cz header.i=@eaxlabs.cz header.b="qyrpgIks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgK2TAp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 29 Nov 2020 14:00:45 -0500
Received: from ms9.eaxlabs.cz ([147.135.177.209]:60858 "EHLO ms9.eaxlabs.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgK2TAp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 29 Nov 2020 14:00:45 -0500
X-Greylist: delayed 2360 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Nov 2020 14:00:44 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=eaxlabs.cz; s=mail;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Cc:Subject:From:To; bh=b2yaHNyulm+ZTYVHYLzpxlsz8xv51a4VnD0QeCcw9dc=;
        b=qyrpgIksus6YgxXVSrak2wnFIzhi/Lh7hsoFr3Z4F6ckGzbJ+4aqo5VHlHrZ6kbLkf5WibxoYxDPoUh3DFJ/XS0z88ExmlzChJf1CaTy09KdTaFfEXmC8bIdj7yZqKEfaDSmpz2WB8RBR2MtiZLL89ahEABq0/KLGbHzxbOg1gY=;
Received: from [82.99.129.6] (helo=[10.76.6.116])
        by ms9.eaxlabs.cz with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <devik@eaxlabs.cz>)
        id 1kjRJR-0005QS-Bi; Sun, 29 Nov 2020 19:20:43 +0100
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org
From:   Martin DEVERA <devik@eaxlabs.cz>
Subject: armmmci rmmod causes hung tasks
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Message-ID: <c5252887-e4f9-953d-88df-d8cc62ecd136@eaxlabs.cz>
Date:   Sun, 29 Nov 2020 19:20:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello,

on STM32MP1 with almost vanilla 5.7.7 in single CPU mode. Pair of
modprobe armmmci ; rmmod armmmci

causes rmmod and kworker to hang. I should note that no MMC is detected
on the board (SDIO device on MMC bus is not responding).
On another board (where SDIO is responding) rmmod works.

It seems as another manifestation of https://lkml.org/lkml/2019/8/27/945

Thanks.

INFO: task kworker/0:1:12 blocked for more than 368 seconds.
       Not tainted 5.7.7kdb-00003-g10397828596c-dirty #224
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/0:1     D    0    12      2 0x00000000
Workqueue: events_freezable mmc_rescan
(__schedule) from (schedule+0x5b/0x90)
(schedule) from (schedule_timeout+0x1b/0xa0)
(schedule_timeout) from (__wait_for_common+0x7d/0xdc)
(__wait_for_common) from (mmc_wait_for_req_done+0x1b/0x8c)
(mmc_wait_for_req_done) from (mmc_wait_for_cmd+0x4d/0x68)
(mmc_wait_for_cmd) from (mmc_io_rw_direct_host+0x87/0xc8)
(mmc_io_rw_direct_host) from (sdio_reset+0x3b/0x58)
(sdio_reset) from (mmc_rescan+0x15d/0x1d4)
(mmc_rescan) from (process_one_work+0xdd/0x168)
(process_one_work) from (worker_thread+0x17d/0x1ec)
(worker_thread) from (kthread+0x9b/0xa4)
(kthread) from (ret_from_fork+0x11/0x28)

INFO: task rmmod:308 blocked for more than 368 seconds.
       Not tainted 5.7.7kdb-00003-g10397828596c-dirty #224
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
rmmod           D    0   308    222 0x00000000
(__schedule) from (schedule+0x5b/0x90)
(schedule) from (schedule_timeout+0x1b/0xa0)
(schedule_timeout) from (__wait_for_common+0x7d/0xdc)
(__wait_for_common) from (__flush_work+0xb3/0x110)
(__flush_work) from (__cancel_work_timer+0x97/0xf0)
(__cancel_work_timer) from (mmc_stop_host+0x29/0x88)
(mmc_stop_host) from (mmc_remove_host+0x9/0x22)
(mmc_remove_host) from (mmci_remove+0x19/0x92 [armmmci])
(mmci_remove [armmmci]) from (amba_remove+0x13/0x42)
(amba_remove) from (device_release_driver_internal+0x89/0xe4)
(device_release_driver_internal) from (driver_detach+0x57/0x60)
(driver_detach) from (bus_remove_driver+0x53/0x84)
(bus_remove_driver) from (mmci_driver_exit+0x9/0x11dc [armmmci])
(mmci_driver_exit [armmmci]) from (sys_delete_module+0x115/0x154)
(sys_delete_module) from (ret_fast_syscall+0x1/0x5a)

