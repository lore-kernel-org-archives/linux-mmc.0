From: Daniel Drake <drake@endlessm.com>
Subject: sdhci_s3c_consider_clock scheduling while atomic - clk_round_rate
Date: Tue, 24 Jun 2014 10:48:59 +0100
Message-ID: <CAD8Lp45QV4ZcfXA86hoseKfJLLV_BJ-g0UABnOGPkJW1pMXhFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:45120 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbaFXJtB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jun 2014 05:49:01 -0400
Received: by mail-we0-f173.google.com with SMTP id t60so53337wes.4
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jun 2014 02:48:59 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Cc: linux-mmc@vger.kernel.org, ben-linux@fluff.org, Tomasz Figa <tomasz.figa@gmail.com>

sdhci_s3c_set_clock is called from sdhci_do_set_ios with interrupts
disabled, and this calls into sdhci_s3c_consider_clock().

The patch "mmc: sdhci-s3c: Cache bus clock rates" addressed some
scheduling while atomic in this function, but there are more issues
here, seen while testing 3.16-rc2 on exynos4412:

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:103
in_atomic(): 1, irqs_disabled(): 128, pid: 75, name: mmcqd/0
Preemption disabled at:[<  (null)>]   (null)

CPU: 0 PID: 75 Comm: mmcqd/0 Not tainted 3.16.0-rc2-00028-ge9fe7eb-dirty #77
[<c0016140>] (unwind_backtrace) from [<c0011e14>] (show_stack+0x10/0x14)
[<c0011e14>] (show_stack) from [<c05ce8a8>] (dump_stack+0x84/0xc4)
[<c05ce8a8>] (dump_stack) from [<c05d2de0>] (mutex_lock+0x1c/0x3c)
[<c05d2de0>] (mutex_lock) from [<c046214c>] (clk_prepare_lock+0x6c/0xf4)
[<c046214c>] (clk_prepare_lock) from [<c04625ac>] (clk_round_rate+0x10/0x2c)
[<c04625ac>] (clk_round_rate) from [<c0447628>] (sdhci_s3c_set_clock+0x4c/0x1e8)
[<c0447628>] (sdhci_s3c_set_clock) from [<c0447818>]
(sdhci_cmu_set_clock+0x54/0x140)
[<c0447818>] (sdhci_cmu_set_clock) from [<c0443a38>]
(sdhci_do_set_ios+0x138/0x58c)
[<c0443a38>] (sdhci_do_set_ios) from [<c0443864>] (sdhci_set_ios+0x28/0x34)

clk_round_rate cannot be called here because it takes a mutex.

sdhci_s3c_set_clock() also calls into clk_prepare_enable() which looks
like it could trigger this problem too.

Daniel
