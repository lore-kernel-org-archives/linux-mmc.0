From: David MOUSSAUD <d.moussaud@gmail.com>
Subject: the at91 mci controller does not recognized my libertas 8686 sdio
	wifi chip after a reset
Date: Mon, 22 Mar 2010 20:15:48 +0100
Message-ID: <cdd918981003221215p51d41b51mf8433caca099495@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f223.google.com ([209.85.220.223]:63589 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755416Ab0CVTQK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Mar 2010 15:16:10 -0400
Received: by fxm23 with SMTP id 23so1086004fxm.21
        for <linux-mmc@vger.kernel.org>; Mon, 22 Mar 2010 12:16:08 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,

I'm using a prototype board running a =A0AT91sam9g20 processor. I have =
a
libertas sdio wifi chip connected to my MCI controller.
I've applied the 2.6.32 bsp patch.

When I power up the board (power on reset), the sdio chip is well
probed by the mci controller.
But when i reset the board, the mmc_rescan function failed because the =
call to

/*
* First we search for SDIO...
*/
err =3D mmc_send_io_op_cond(host, 0, &ocr);

return 110;

so my sdio chip is not recognized by my kernel.

I've tried to apply that patch "sdio : recognize io card without
powercycle" ( 516a82422209e078345d0ca54b16793d7bfd4782 ) without succes=
s.

Here is a dump of the mmc dialogue when the board is only reseted :
[ =A0 =A01.160000] mmc0: starting CMD52 arg 00000c00 flags 00000195
=A0[ =A0 =A01.160000] Sending command 52 as 00001874, arg =3D 00000C00,
blocks =3D 0, length =3D 0 (MR =3D 00009B7C)
=A0[ =A0 =A01.160000] MCI irq: status =3D 0000C0E5, C07F0001, 00000001
=A0[ =A0 =A01.160000] Command ready
=A0[ =A0 =A01.160000] Completed command
=A0[ =A0 =A01.160000] Status =3D 00000001/0000c0e5 [00001000 00000000
00000000 00000000]
=A0[ =A0 =A01.160000] mmc0: req done (CMD52): 0: 00001000 00000000 0000=
0000 00000000
=A0[ =A0 =A01.160000] mmc0: starting CMD52 arg 80000c08 flags 00000195
=A0[ =A0 =A01.160000] Sending command 52 as 00001874, arg =3D 80000C08,
blocks =3D 0, length =3D 0 (MR =3D 00009B7C)
=A0[ =A0 =A01.160000] MCI irq: status =3D 0000C0E5, C07F0001, 00000001
=A0[ =A0 =A01.160000] Command ready
=A0[ =A0 =A01.160000] Completed command
=A0[ =A0 =A01.160000] Status =3D 00000001/0000c0e5 [00001008 00000000
00000000 00000000]
=A0[ =A0 =A01.160000] mmc0: req done (CMD52): 0: 00001008 00000000 0000=
0000 00000000
=A0[ =A0 =A01.160000] mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 V=
dd
21 width 0 timing 0
=A0[ =A0 =A01.160000] clkdiv =3D 124. mcck =3D 397312
=A0[ =A0 =A01.160000] MMC: Setting controller bus width to 1
=A0[ =A0 =A01.160000] mmc0: starting CMD0 arg 00000000 flags 000000c0
=A0[ =A0 =A01.160000] Sending command 0 as 00000800, arg =3D 00000000,
blocks =3D 0, length =3D 0 (MR =3D 00009B7C)
=A0[ =A0 =A01.160000] MCI irq: status =3D 0000C0E5, C07F0001, 00000001
=A0[ =A0 =A01.160000] Command ready
=A0[ =A0 =A01.160000] Completed command
=A0[ =A0 =A01.160000] Status =3D 00000001/0000c0e5 [00001008 00000000
00000000 00000000]
=A0[ =A0 =A01.160000] mmc0: req done (CMD0): 0: 00001008 00000000 00000=
000 00000000
=A0[ =A0 =A01.160000] mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 V=
dd
21 width 0 timing 0
=A0[ =A0 =A01.160000] clkdiv =3D 124. mcck =3D 397312
=A0[ =A0 =A01.160000] MMC: Setting controller bus width to 1
=A0[ =A0 =A01.160000] mmc0: starting CMD8 arg 000001aa flags 000002f5
=A0[ =A0 =A01.160000] Sending command 8 as 00001848, arg =3D 000001AA,
blocks =3D 0, length =3D 0 (MR =3D 00009B7C)
=A0[ =A0 =A01.160000] MCI irq: status =3D 0010C0E4, C07F0001, 00100000
=A0[ =A0 =A01.160000] MMC: Response timeout
=A0[ =A0 =A01.160000] Completed command
=A0[ =A0 =A01.160000] Status =3D 00100000/0010c0e5 [00001008 00000000
00000000 00000000]
=A0[ =A0 =A01.160000] Error detected and set to -110/0 (cmd =3D 8, retr=
ies =3D 0)
=A0[ =A0 =A01.160000] mmc0: req done (CMD8): -110: 00001008 00000000
00000000 00000000
=A0[ =A0 =A01.160000] mmc0: starting CMD5 arg 00000000 flags 000002e1
=A0[ =A0 =A01.160000] Sending command 5 as 00001845, arg =3D 00000000,
blocks =3D 0, length =3D 0 (MR =3D 00009B7C)
=A0[ =A0 =A01.160000] MCI irq: status =3D 0010C0E4, C07F0001, 00100000
=A0[ =A0 =A01.160000] MMC: Response timeout
=A0[ =A0 =A01.160000] Completed command
=A0[ =A0 =A01.160000] Status =3D 00100000/0010c0e5 [00001008 00000000
00000000 00000000]
=A0[ =A0 =A01.160000] Error detected and set to -110/0 (cmd =3D 5, retr=
ies =3D 3)
=A0[ =A0 =A01.160000] mmc0: req failed (CMD5): -110, retrying...
=A0[ =A0 =A01.160000] Sending command 5 as 00001845, arg =3D 00000000,
blocks =3D 0, length =3D 0 (MR =3D 00009B7C)
=A0[ =A0 =A01.170000] MCI irq: status =3D 0010C0E4, C07F0001, 00100000
=A0[ =A0 =A01.170000] MMC: Response timeout
=A0[ =A0 =A01.170000] Completed command
=A0[ =A0 =A01.170000] Status =3D 00100000/0010c0e5 [00001008 00000000
00000000 00000000]
=A0[ =A0 =A01.170000] Error detected and set to -110/0 (cmd =3D 5, retr=
ies =3D 2)
=A0[ =A0 =A01.170000] mmc0: req failed (CMD5): -110, retrying...
=A0[ =A0 =A01.170000] Sending command 5 as 00001845, arg =3D 00000000,
blocks =3D 0, length =3D 0 (MR =3D 00009B7C)
=A0[ =A0 =A01.170000] MCI irq: status =3D 0010C0E4, C07F0001, 00100000
=A0[ =A0 =A01.170000] MMC: Response timeout
=A0[ =A0 =A01.170000] Completed command
=A0[ =A0 =A01.170000] Status =3D 00100000/0010c0e5 [00001008 00000000
00000000 00000000]
=A0[ =A0 =A01.170000] Error detected and set to -110/0 (cmd =3D 5, retr=
ies =3D 1)
=A0[ =A0 =A01.170000] mmc0: req failed (CMD5): -110, retrying...
=A0[ =A0 =A01.170000] Sending command 5 as 00001845, arg =3D 00000000,
blocks =3D 0, length =3D 0 (MR =3D 00009B7C)
=A0[ =A0 =A01.170000] MCI irq: status =3D 0010C0E4, C07F0001, 00100000
=A0[ =A0 =A01.170000] MMC: Response timeout
=A0[ =A0 =A01.170000] Completed command
=A0[ =A0 =A01.170000] Status =3D 00100000/0010c0e5 [00001008 00000000
00000000 00000000]
=A0[ =A0 =A01.170000] Error detected and set to -110/0 (cmd =3D 5, retr=
ies =3D 0)
=A0[ =A0 =A01.170000] mmc0: req done (CMD5): -110: 00001008 00000000
00000000 00000000
=A0[ =A0 =A01.170000] mmc0: starting CMD55 arg 00000000 flags 000000f5
=A0[ =A0 =A01.170000] Sending command 55 as 00001877, arg =3D 00000000,
blocks =3D 0, length =3D 0 (MR =3D 00009B7C)
=A0[ =A0 =A01.180000] MCI irq: status =3D 0010C0E4, C07F0001, 00100000
=A0[ =A0 =A01.180000] MMC: Response timeout
=A0[ =A0 =A01.180000] Completed command
=A0[ =A0 =A01.180000] Status =3D 00100000/0010c0e5 [00001008 00000000
00000000 00000000]
=A0[ =A0 =A01.180000] Error detected and set to -110/0 (cmd =3D 55, ret=
ries =3D 0)
=A0[ =A0 =A01.180000] mmc0: req done (CMD55): -110: 00001008 00000000
00000000 00000000
=A0[ =A0 =A01.180000] mmc0: starting CMD55 arg 00000000 flags 000000f5
=A0[ =A0 =A01.180000] Sending command 55 as 00001877, arg =3D 00000000,
blocks =3D 0, length =3D 0 (MR =3D 00009B7C)
=A0[ =A0 =A01.180000] MCI irq: status =3D 0010C0E4, C07F0001, 00100000
=A0[ =A0 =A01.180000] MMC: Response timeout
=A0[ =A0 =A01.180000] Completed command
=A0[ =A0 =A01.180000] Status =3D 00100000/0010c0e5 [00001008 00000000
00000000 00000000]
=A0[ =A0 =A01.180000] Error detected and set to -110/0 (cmd =3D 55, ret=
ries =3D 0)
=A0[ =A0 =A01.180000] mmc0: req done (CMD55): -110: 00001008 00000000
00000000 00000000
=A0[ =A0 =A01.180000] mmc0: starting CMD55 arg 00000000 flags 000000f5
=A0[ =A0 =A01.180000] Sending command 55 as 00001877, arg =3D 00000000,
blocks =3D 0, length =3D 0 (MR =3D 00009B7C)
=A0[ =A0 =A01.180000] MCI irq: status =3D 0010C0E4, C07F0001, 00100000
=A0[ =A0 =A01.180000] MMC: Response timeout
=A0[ =A0 =A01.180000] Completed command
=A0[ =A0 =A01.180000] Status =3D 00100000/0010c0e5 [00001008 00000000
00000000 00000000]
=A0[ =A0 =A01.180000] Error detected and set to -110/0 (cmd =3D 55, ret=
ries =3D 0)
=A0[ =A0 =A01.180000] mmc0: req done (CMD55): -110: 00001008 00000000
00000000 00000000
=A0[ =A0 =A01.180000] mmc0: starting CMD55 arg 00000000 flags 000000f5
=A0[ =A0 =A01.180000] Sending command 55 as 00001877, arg =3D 00000000,
blocks =3D 0, length =3D 0 (MR =3D 00009B7C)
=A0[ =A0 =A01.180000] MCI irq: status =3D 0010C0E4, C07F0001, 00100000
=A0[ =A0 =A01.180000] MMC: Response timeout
=A0[ =A0 =A01.180000] Completed command
=A0[ =A0 =A01.180000] Status =3D 00100000/0010c0e5 [00001008 00000000
00000000 00000000]
=A0[ =A0 =A01.180000] Error detected and set to -110/0 (cmd =3D 55, ret=
ries =3D 0)
=A0[ =A0 =A01.180000] mmc0: req done (CMD55): -110: 00001008 00000000
00000000 00000000
=A0[ =A0 =A01.180000] mmc0: starting CMD1 arg 00000000 flags 000000e1
=A0[ =A0 =A01.180000] Clearing timeout
=A0[ =A0 =A01.180000] Clearing: SR =3D 0000C0E4
=A0[ =A0 =A01.180000] Clearing: SR =3D 0000C0E4
=A0[ =A0 =A01.180000] Clearing: SR =3D 0000C0E4
=A0[ =A0 =A01.180000] Clearing: SR =3D 0000C0E4
=A0[ =A0 =A01.180000] Sending command 1 as 00001841, arg =3D 00000000,
blocks =3D 0, length =3D 0 (MR =3D 00009B7C)
=A0[ =A0 =A01.180000] MCI irq: status =3D 0010C0E4, C07F0001, 00100000
=A0[ =A0 =A01.180000] MMC: Response timeout
=A0[ =A0 =A01.180000] Completed command
=A0[ =A0 =A01.180000] Status =3D 00100000/0010c0e5 [00001008 00000000
00000000 00000000]
=A0[ =A0 =A01.180000] Error detected and set to -110/0 (cmd =3D 1, retr=
ies =3D 0)
=A0[ =A0 =A01.180000] mmc0: req done (CMD1): -110: 00001008 00000000
00000000 00000000
=A0[ =A0 =A01.180000] mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0
width 0 timing 0
=A0[ =A0 =A01.180000] MMC: Setting controller bus width to 1

Thanks in advance for any suggestion,
Regards,

D.MOUSSAUD.
