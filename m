From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] mmc: pwrseq: fix logic in error handling.
Date: Thu, 19 Mar 2015 09:22:13 +0000
Message-ID: <1426756933-19290-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38248 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261AbbCSJW5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Mar 2015 05:22:57 -0400
Received: by wifj2 with SMTP id j2so63168382wif.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2015 02:22:56 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This bug was noticed by accident when I build kernel without a gpio
driver resulting in exercising the error path.
In the error handing path the index could go below zero resulting in
infinite loop. This patch adds a check to fix the issue.

Without this patch I hit the below kernel crash or kernel hang:

Unable to handle kernel NULL pointer dereference at virtual address 00000002
pgd = c0204000
[00000002] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.0.0-rc4-00100-gda80c89-dirty #3
Hardware name: Qualcomm (Flattened Device Tree)
task: ed858000 ti: ed842000 task.ti: ed842000
PC is at gpiod_unexport+0x14/0xc8
LR is at gpiod_unexport+0x14/0xc8
pc : [<c04bc368>]    lr : [<c04bc368>]    psr: 60000113
sp : ed843db0  ip : 00000000  fp : 00000000
r10: ed927c00  r9 : fffffdfb  r8 : ed9a8e80
r7 : ed958610  r6 : 00000002  r5 : fffffffe  r4 : fffffffe
r3 : ed858000  r2 : ed843da8  r1 : 60000113  r0 : c0ea6ac8
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5787d  Table: 8020406a  DAC: 00000015
Process swapper/0 (pid: 1, stack limit = 0xed842220)
Stack: (0xed843db0 to 0xed844000)
3da0:                                     fffffffe fffffffe 00000002 c04ba420
3dc0: fffffffe fffffffe 00000002 ed958610 ed9a8e80 c04bb29c ed9a8e88 c07ec514
3de0: ed927c00 00000000 c0ee58a4 ed958600 ed9a8e10 00000000 c0ee5c28 c07ec1dc
3e00: 00000001 ed927c00 ee7edeb0 00000000 00000000 c07e2e94 00000000 ed843e27
3e20: 00000000 00007200 00000004 00000000 ed927c00 ed957200 ee7edeb0 c07f1868
3e40: ee7edeb0 c082eb70 ed858000 00000000 60000113 ed957200 fffffffe c0ee5a50
3e60: ed957200 c0ee5944 00000000 ed9572c4 c0de5564 00000000 00000000 c050d67c
3e80: ed957200 c0f6d59c 00000000 c0ee5944 00000000 c05eacf4 ed957200 c0ee5944
3ea0: ed957234 00000000 c0daed5c c05eaea0 00000000 c0ee5944 c05eae14 c05e9524
3ec0: ed82b95c ed9438b4 c0ee5944 edd3b700 c0ea9d74 c05ea4f4 c0ca8dd4 c0e29710
3ee0: c0ee5944 c0ee5944 c0e33818 edd3d200 c0f2f180 c05eb4e8 00000000 c0e33818
3f00: c0e33818 c0209a44 0000006a 00000000 c0c93134 c0d1c21c 00000000 ed843f30
3f20: c02622d0 c046c260 20000013 ffffffff ef7fcc75 c09d0408 00000118 c02624d0
3f40: c0d1bb7c 00000006 ef7fcc8d 00000006 c0e6d70c ef7fcbc0 c0e29710 00000006
3f60: c0de5558 c0f2f180 00000118 c0de5564 c0d65598 c0d65d6c 00000006 00000006
3f80: c0d65598 c09a5154 00000000 c09a5154 00000000 00000000 00000000 00000000
3fa0: 00000000 c09a515c 00000000 c020f6c0 00000000 00000000 00000000 00000000
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 e5fdff45 9929cfe7
[<c04bc368>] (gpiod_unexport) from [<c04ba420>] (__gpiod_free+0xc/0xe0)
[<c04ba420>] (__gpiod_free) from [<c04bb29c>] (gpiod_free+0x10/0x28)
[<c04bb29c>] (gpiod_free) from [<c07ec514>] (mmc_pwrseq_simple_alloc+0xe0/0x128)
[<c07ec514>] (mmc_pwrseq_simple_alloc) from [<c07ec1dc>] (mmc_pwrseq_alloc+0x90/0xb8)
[<c07ec1dc>] (mmc_pwrseq_alloc) from [<c07e2e94>] (mmc_of_parse+0x3b0/0x4f0)
[<c07e2e94>] (mmc_of_parse) from [<c07f1868>] (mmci_probe+0x50/0x828)
[<c07f1868>] (mmci_probe) from [<c050d67c>] (amba_probe+0xcc/0x148)
[<c050d67c>] (amba_probe) from [<c05eacf4>] (driver_probe_device+0x10c/0x22c)
[<c05eacf4>] (driver_probe_device) from [<c05eaea0>] (__driver_attach+0x8c/0x90)
[<c05eaea0>] (__driver_attach) from [<c05e9524>] (bus_for_each_dev+0x54/0x88)
[<c05e9524>] (bus_for_each_dev) from [<c05ea4f4>] (bus_add_driver+0xd4/0x1d0)
[<c05ea4f4>] (bus_add_driver) from [<c05eb4e8>] (driver_register+0x78/0xf4)
[<c05eb4e8>] (driver_register) from [<c0209a44>] (do_one_initcall+0x80/0x1d0)
[<c0209a44>] (do_one_initcall) from [<c0d65d6c>] (kernel_init_freeable+0x10c/0x1d8)
[<c0d65d6c>] (kernel_init_freeable) from [<c09a515c>] (kernel_init+0x8/0xec)
[<c09a515c>] (kernel_init) from [<c020f6c0>] (ret_from_fork+0x14/0x34)
Code: e2504000 0a000025 e59f00a0 eb13c440 (e5943004)
---[ end trace 80b84017d7c9e7e5 ]---

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mmc/core/pwrseq_simple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index e9f1d8d..6f0a875 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -124,8 +124,8 @@ int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
 		    PTR_ERR(pwrseq->reset_gpios[i]) != -ENOSYS) {
 			ret = PTR_ERR(pwrseq->reset_gpios[i]);
 
-			while (--i)
-				gpiod_put(pwrseq->reset_gpios[i]);
+			while (i > 0)
+				gpiod_put(pwrseq->reset_gpios[--i]);
 
 			goto clk_put;
 		}
-- 
1.9.1

