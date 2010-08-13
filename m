From: Arnd Hannemann <arnd@arndnet.de>
Subject: Bug in mmc_test or host driver?
Date: Fri, 13 Aug 2010 19:23:45 +0200
Message-ID: <4C657FA1.9090705@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from slowhand.arndnet.de ([88.198.19.76]:56994 "EHLO mail.unitix.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761906Ab0HMRyr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 13 Aug 2010 13:54:47 -0400
Received: from [192.168.1.62] (80-230.eduroam.RWTH-Aachen.DE [134.61.80.230])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.unitix.de (Postfix) with ESMTP id 0347213E8D
	for <linux-mmc@vger.kernel.org>; Fri, 13 Aug 2010 19:23:46 +0200 (CEST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

if I peform the test 23 mmc_test_best_read_performance() with tmio_mmc
on Linus tree, I hit the following BUG:

 [  152.625000] mmc0: Starting tests of card mmc0:2daf...
 [  152.625000] mmc0: Test case 23. Best-case read performance...
 [  152.632812] mmc0: starting CMD16 arg 00000200 flags 00000015
 [  152.632812] MMC IRQ begin
 [  152.632812] status: 208007a1 =
SIGSTATEWRPROTECTCARD_REMOVE_ACARD_INSERT_ASIGSTATE_AILL_FUNCCMDRESPEND
 [  152.632812] status: 00000001 = CMDRESPEND
 [  152.632812] mmc0: req done (CMD16): 0: 00000900 00000900 00000b00
00000900
 [  152.632812] Status at end of loop: 208007a0
 [  152.632812] status: 208007a0 =
SIGSTATEWRPROTECTCARD_REMOVE_ACARD_INSERT_ASIGSTATE_AILL_FUNC
 [  152.632812] MMC IRQ end
 [  152.632812] mmc0: starting CMD25 arg 003b0000 flags 00000035
 [  152.632812] mmc0:     blksz 512 blocks 8192 flags 00000100 tsac 300
ms nsac 0
 [  152.632812] mmc0:     CMD12 arg 00000000 flags 0000001d
 [  152.632812] kernel BUG at drivers/mmc/core/core.c:172!


core.c:  172         BUG_ON(mrq->data->blocks > host->max_blk_count);

The host's max_blk_count is 512, but mmc_test does not check and issues
a request with 8192 blocks.
So I believe the test is wrong here?

 [  152.656250] Backtrace:
 [  152.656250] [<c0028e38>] (__bug+0x0/0x30) from [<c0181f88>]
(mmc_wait_for_req+0x14c/0x228)
 [  152.656250] [<c0181e3c>] (mmc_wait_for_req+0x0/0x228) from
[<bf01840c>] (mmc_test_simple_transfer+0xb0/0x140 [mmc_test])
 [  152.656250]  r7:cf1e3d28 r6:cf1ec000 r5:cf1e3db4 r4:cf318000
 [  152.656250] [<bf01835c>] (mmc_test_simple_transfer+0x0/0x140
[mmc_test]) from [<bf01993c>] (mmc_test_area_io+0x2fc/0x350 [mmc_test])
 [  152.656250] [<bf019640>] (mmc_test_area_io+0x0/0x350 [mmc_test])
from [<bf0199c4>] (mmc_test_area_fill+0x34/0x3c [mmc_test])
 [  152.656250] [<bf019990>] (mmc_test_area_fill+0x0/0x3c [mmc_test])
from [<bf019d10>] (mmc_test_area_init+0x238/0x264 [mmc_test])
 [  152.656250] [<bf019ad8>] (mmc_test_area_init+0x0/0x264 [mmc_test])
from [<bf019d8c>] (mmc_test_area_prepare_fill+0x18/0x1c [mmc_test])
 [  152.656250] [<bf019d74>] (mmc_test_area_prepare_fill+0x0/0x1c
[mmc_test]) from [<bf018a1c>] (mmc_test_store+0xf8/0x290 [mmc_test])
 [  152.656250] [<bf018924>] (mmc_test_store+0x0/0x290 [mmc_test]) from
[<c015541c>] (dev_attr_store+0x24/0x28)
 [  152.656250]  r8:cf0f3010 r7:cf24fd60 r6:00000003 r5:cf1e3f70 r4:cf41bd88
 [  152.656250] r3:00000003
 [  152.656250] [<c01553f8>] (dev_attr_store+0x0/0x28) from [<c00ccad0>]
(sysfs_write_file+0x110/0x144)
 [  152.656250] [<c00cc9c0>] (sysfs_write_file+0x0/0x144) from
[<c008a5c4>] (vfs_write+0xbc/0x138)
 [  152.656250] [<c008a508>] (vfs_write+0x0/0x138) from [<c008a708>]
(sys_write+0x44/0x70)
 [  152.656250]  r8:00000000 r7:00000004 r6:00000003 r5:000d9408 r4:cf0f4420
 [  152.656250] [<c008a6c4>] (sys_write+0x0/0x70) from [<c0025e60>]
(ret_fast_syscall+0x0/0x30)
 [  152.656250]  r9:cf1e2000 r8:c0025fe4 r6:00000003 r5:403305c8 r4:00000003
 [  152.656250] Code: e59f0010 e1a01003 eb077a1d e3a03000 (e5833000)

Best regards,
Arnd
