From: David MOUSSAUD <d.moussaud@gmail.com>
Subject: the at91 mmc controller does not recognized my sdio wifi chip after a
	reset.
Date: Sun, 21 Mar 2010 10:56:54 +0100
Message-ID: <cdd918981003210256p6843c5a6i34dd48c4d198c8ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:63491 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991Ab0CUJ5Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 21 Mar 2010 05:57:16 -0400
Received: by fxm27 with SMTP id 27so3833905fxm.28
        for <linux-mmc@vger.kernel.org>; Sun, 21 Mar 2010 02:57:14 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, libertas-dev@lists.infradead.org

Hello,

I'm writting to the both mmc & libertas mailing list  because i might
think the problem is related.

I'm using a prototype board running a  AT91sam9g20 processor. I have a
libertas sdio wifi chip connected to my MCI controller.
I've applied the 2.6.32 bsp patch.

When I power up the board (power on reset), the sdio chip is well
probed by the mci controller.
But when i reset the board, the mmc_rescan function failed because the call to

/*
* First we search for SDIO...
*/
err = mmc_send_io_op_cond(host, 0, &ocr);

return 110;

so my sdio chip is not recognized by my kernel.

I've tried to apply that patch "sdio : recognize io card without
powercycle" (http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=516a82422209e078345d0ca54b16793d7bfd4782
) without success.

Here is a dump of the mmc dialogue when the board is only reseted :

Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
mmc0: starting CMD52 arg 00000c00 flags 00000195
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
Sending command 52 as 00001874, arg = 00000C00, blocks = 0, length = 0
(MR = 00009B7C)
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
MCI irq: status = 0000C0E5, C07F0001, 00000001
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
Command ready
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
Completed command
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
Status = 00000001/0000c0e5 [00001000 00000000 00000000 00000000]
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
mmc0: req done (CMD52): 0: 00001000 00000000 00000000 00000000
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
mmc0: starting CMD52 arg 80000c08 flags 00000195
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
Sending command 52 as 00001874, arg = 80000C08, blocks = 0, length = 0
(MR = 00009B7C)
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
MCI irq: status = 0000C0E5, C07F0001, 00000001
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
Command ready
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
Completed command
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
Status = 00000001/0000c0e5 [00001008 00000000 00000000 00000000]
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
mmc0: req done (CMD52): 0: 00001008 00000000 00000000 00000000
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 21 width 0 timing
0
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
clkdiv = 124. mcck = 397312
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
MMC: Setting controller bus width to 1
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
mmc0: starting CMD0 arg 00000000 flags 000000c0
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
Sending command 0 as 00000800, arg = 00000000, blocks = 0, length = 0
(MR = 00009B7C)
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
MCI irq: status = 0000C0E5, C07F0001, 00000001
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
Command ready
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
Completed command
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
Status = 00000001/0000c0e5 [00001008 00000000 00000000 00000000]
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
mmc0: req done (CMD0): 0: 00001008 00000000 00000000 00000000
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing
0
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
clkdiv = 124. mcck = 397312
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
MMC: Setting controller bus width to 1
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
mmc0: starting CMD8 arg 000001aa flags 000002f5
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
Sending command 8 as 00001848, arg = 000001AA, blocks = 0, length = 0
(MR = 00009B7C)
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
MCI irq: status = 0010C0E4, C07F0001, 00100000
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
MMC: Response timeout
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
Completed command
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
Status = 00100000/0010c0e5 [00001008 00000000 00000000 00000000]
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
Error detected and set to -110/0 (cmd = 8, retries = 0)
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
mmc0: req done (CMD8): -110: 00001008 00000000 00000000 00000000
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
mmc0: starting CMD5 arg 00000000 flags 000002e1
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
Sending command 5 as 00001845, arg = 00000000, blocks = 0, length = 0
(MR = 00009B7C)
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
MCI irq: status = 0010C0E4, C07F0001, 00100000
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
MMC: Response timeout
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
Completed command
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
Status = 00100000/0010c0e5 [00001008 00000000 00000000 00000000]
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
Error detected and set to -110/0 (cmd = 5, retries = 3)
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
mmc0: req failed (CMD5): -110, retrying...
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.160000]
Sending command 5 as 00001845, arg = 00000000, blocks = 0, length = 0
(MR = 00009B7C)
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.170000]
MCI irq: status = 0010C0E4, C07F0001, 00100000
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.170000]
MMC: Response timeout
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.170000]
Completed command
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.170000]
Status = 00100000/0010c0e5 [00001008 00000000 00000000 00000000]
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.170000]
Error detected and set to -110/0 (cmd = 5, retries = 2)
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.170000]
mmc0: req failed (CMD5): -110, retrying...
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.170000]
Sending command 5 as 00001845, arg = 00000000, blocks = 0, length = 0
(MR = 00009B7C)
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.170000]
MCI irq: status = 0010C0E4, C07F0001, 00100000
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.170000]
MMC: Response timeout
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.170000]
Completed command
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.170000]
Status = 00100000/0010c0e5 [00001008 00000000 00000000 00000000]
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.170000]
Error detected and set to -110/0 (cmd = 5, retries = 1)
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.170000]
mmc0: req failed (CMD5): -110, retrying...
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.170000]
Sending command 5 as 00001845, arg = 00000000, blocks = 0, length = 0
(MR = 00009B7C)
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.170000]
MCI irq: status = 0010C0E4, C07F0001, 00100000
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.170000]
MMC: Response timeout
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.170000]
Completed command
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.170000]
Status = 00100000/0010c0e5 [00001008 00000000 00000000 00000000]
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.170000]
Error detected and set to -110/0 (cmd = 5, retries = 0)
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.170000]
mmc0: req done (CMD5): -110: 00001008 00000000 00000000 00000000
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.170000]
mmc0: starting CMD55 arg 00000000 flags 000000f5
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.170000]
Sending command 55 as 00001877, arg = 00000000, blocks = 0, length = 0
(MR = 00009B7C)
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.180000]
MCI irq: status = 0010C0E4, C07F0001, 00100000
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.180000]
MMC: Response timeout
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.180000]
Completed command
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.180000]
Status = 00100000/0010c0e5 [00001008 00000000 00000000 00000000]
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.180000]
Error detected and set to -110/0 (cmd = 55, retries = 0)
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.180000]
mmc0: req done (CMD55): -110: 00001008 00000000 00000000 00000000
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.180000]
mmc0: starting CMD55 arg 00000000 flags 000000f5
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.180000]
Sending command 55 as 00001877, arg = 00000000, blocks = 0, length = 0
(MR = 00009B7C)
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.180000]
MCI irq: status = 0010C0E4, C07F0001, 00100000
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.180000]
MMC: Response timeout
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.180000]
Completed command
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.180000]
Status = 00100000/0010c0e5 [00001008 00000000 00000000 00000000]
Jan  1 01:00:21 at91sam9260custom user.debug kernel: [    1.180000]
Error detected and set to -110/0 (cmd = 55, retries = 0)
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
mmc0: req done (CMD55): -110: 00001008 00000000 00000000 00000000
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
mmc0: starting CMD55 arg 00000000 flags 000000f5
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
Sending command 55 as 00001877, arg = 00000000, blocks = 0, length = 0
(MR = 00009B7C)
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
MCI irq: status = 0010C0E4, C07F0001, 00100000
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
MMC: Response timeout
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
Completed command
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
Status = 00100000/0010c0e5 [00001008 00000000 00000000 00000000]
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
Error detected and set to -110/0 (cmd = 55, retries = 0)
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
mmc0: req done (CMD55): -110: 00001008 00000000 00000000 00000000
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
mmc0: starting CMD55 arg 00000000 flags 000000f5
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
Sending command 55 as 00001877, arg = 00000000, blocks = 0, length = 0
(MR = 00009B7C)
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
MCI irq: status = 0010C0E4, C07F0001, 00100000
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
MMC: Response timeout
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
Completed command
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
Status = 00100000/0010c0e5 [00001008 00000000 00000000 00000000]
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
Error detected and set to -110/0 (cmd = 55, retries = 0)
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
mmc0: req done (CMD55): -110: 00001008 00000000 00000000 00000000
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
mmc0: starting CMD1 arg 00000000 flags 000000e1
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
Clearing timeout
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
Clearing: SR = 0000C0E4
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
Clearing: SR = 0000C0E4
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
Clearing: SR = 0000C0E4
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
Clearing: SR = 0000C0E4
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
Sending command 1 as 00001841, arg = 00000000, blocks = 0, length = 0
(MR = 00009B7C)
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
MCI irq: status = 0010C0E4, C07F0001, 00100000
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
MMC: Response timeout
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
Completed command
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
Status = 00100000/0010c0e5 [00001008 00000000 00000000 00000000]
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
Error detected and set to -110/0 (cmd = 1, retries = 0)
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
mmc0: req done (CMD1): -110: 00001008 00000000 00000000 00000000
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
Jan  1 01:00:22 at91sam9260custom user.debug kernel: [    1.180000]
MMC: Setting controller bus width to 1


Thanks in advance for any tips,
Regards,

D.MOUSSAUD.
