From: Bringfried Stecklum <stecklum@tls-tautenburg.de>
Subject: 2.36.1 sdhci R5C822 regression
Date: Fri, 17 Dec 2010 11:14:36 +0100
Message-ID: <4D0B380C.4000407@tls-tautenburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kso.tls-tautenburg.de ([194.94.209.8]:17379 "EHLO
	kso.tls-tautenburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528Ab0LQKZa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Dec 2010 05:25:30 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org

I recently upgraded from 3.6.31-22 to 3.6.36-1 (Ubuntu kernel nomenclat=
ure) and
am quite happy with it apart from the card reader

stecklum@extragalactix:~$ lspci |grep Ricoh
03:01.0 FireWire (IEEE 1394): Ricoh Co Ltd R5C832 IEEE 1394 Controller =
(rev 05)
03:01.1 SD Host controller: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Ho=
st
Adapter (rev 22)
03:01.2 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host Ad=
apter
(rev 12)
03:01.3 System peripheral: Ricoh Co Ltd xD-Picture Card Controller (rev=
 12)

which used to work flawlessly in the past, e.g. with previous kernel 2.=
6.31-22.

On resume from hibernation (suspend is fine) a kernel trace happens alo=
ng with
the well-know "IRQ nobody cared" statement (see below). The interrupt g=
ets
disabled, and since mmc0 is compiled into the kernel, I cannot do anyth=
ing about
it (I tried CONFIG_MMC_RICOH_MMC=3Dm but this will be overriden during =
the build).

I checked with both WLAN and WWAN disabled in BIOS, same behaviour. So =
spurious=20
interrupts can be ruled out. Also booting with irqpoll does not help.


extragalactix kernel: [  156.991348] Restarting tasks ... done.
Nov 24 09:58:43 extragalactix kernel: [  157.420395] tg3 0000:09:00.0: =
eth0:
Link is up at 100 Mbps, full duplex
Nov 24 09:58:43 extragalactix kernel: [  157.420404] tg3 0000:09:00.0: =
eth0:
=46low control is on for TX and on for RX
Nov 24 09:58:43 extragalactix anacron[6896]: Anacron 2.3 started on 201=
0-11-24
Nov 24 09:58:43 extragalactix anacron[6896]: Normal exit (0 jobs run)
Nov 24 09:58:43 extragalactix laptop-mode: Laptop mode
Nov 24 09:58:43 extragalactix laptop-mode: enabled,
Nov 24 09:58:43 extragalactix laptop-mode: not active [unchanged]
Nov 24 09:58:43 extragalactix kernel: [  158.018563] irq 18: nobody car=
ed(try
booting with the "irqpoll" option)
Nov 24 09:58:43 extragalactix kernel: [  158.018724] Pid: 0, comm: swap=
per
Tainted: P            2.6.36-1-generic #7
Nov 24 09:58:43 extragalactix kernel: [  158.018726] Call Trace:
Nov 24 09:58:43 extragalactix kernel: [  158.018728]  <IRQ>
[<ffffffffa00c5ead>] ? r852_irq+0xfd/0x290 [r852]
Nov 24 09:58:43 extragalactix kernel: [  158.018746]  [<ffffffff810ca5e=
6>]
__report_bad_irq+0x26/0xa0
Nov 24 09:58:43 extragalactix kernel: [  158.018749]  [<ffffffff810ca7e=
8>]
note_interrupt+0x188/0x1d0
Nov 24 09:58:43 extragalactix kernel: [  158.018751]  [<ffffffff810caff=
d>]
handle_fasteoi_irq+0xdd/0x110
Nov 24 09:58:43 extragalactix kernel: [  158.018755]  [<ffffffff8100dba=
f>]
handle_irq+0x1f/0x30
Nov 24 09:58:43 extragalactix kernel: [  158.018757]  [<ffffffff8100d06=
a>]
do_IRQ+0x6a/0xf0
Nov 24 09:58:43 extragalactix kernel: [  158.018761]  [<ffffffff816019d=
3>]
ret_from_intr+0x0/0x11
Nov 24 09:58:43 extragalactix kernel: [  158.018762]  <EOI>
[<ffffffff81375e6f>] ? acpi_idle_enter_c1+0x9f/0xbe
Nov 24 09:58:43 extragalactix kernel: [  158.018768]  [<ffffffff81375e4=
d>] ?
acpi_idle_enter_c1+0x7d/0xbe
Nov 24 09:58:43 extragalactix kernel: [  158.018772]  [<ffffffff814c437=
c>]
cpuidle_idle_call+0xcc/0x150
Nov 24 09:58:43 extragalactix kernel: [  158.018775]  [<ffffffff8100a1a=
7>]
cpu_idle+0xc7/0x170
Nov 24 09:58:43 extragalactix kernel: [  158.018778]  [<ffffffff815e583=
d>]
rest_init+0x6d/0x80
Nov 24 09:58:43 extragalactix kernel: [  158.018782]  [<ffffffff81cdeea=
d>]
start_kernel+0x340/0x409
Nov 24 09:58:43 extragalactix kernel: [  158.018784]  [<ffffffff81cde2c=
0>]
x86_64_start_reservations+0xa0/0xc1
Nov 24 09:58:43 extragalactix kernel: [  158.018787]  [<ffffffff81cde3e=
a>]
x86_64_start_kernel+0x109/0x124
Nov 24 09:58:43 extragalactix kernel: [  158.018789]  [<ffffffff81cde14=
0>] ?
early_idt_handler+0x0/0x71
Nov 24 09:58:43 extragalactix kernel: [  158.018791] handlers:
Nov 24 09:58:43 extragalactix kernel: [  158.018843] [<ffffffffa00c5db0=
>]
(r852_irq+0x0/0x290 [r852])
Nov 24 09:58:43 extragalactix kernel: [  158.018983] [<ffffffffa0130ab0=
>]
(sdhci_irq+0x0/0x650 [sdhci])
Nov 24 09:58:43 extragalactix kernel: [  158.019128] Disabling IRQ #18
=2E..
extragalactix kernel: [  167.040050] mmc0: Timeout waiting for hardware=
 interrupt.
Nov 24 09:58:53 extragalactix kernel: [  167.040055] sdhci: =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
REGISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Nov 24 09:58:53 extragalactix kernel: [  167.040061] sdhci: Sys addr: 0=
x00000000
| Version:  0x00000400
Nov 24 09:58:53 extragalactix kernel: [  167.040066] sdhci: Blk size: 0=
x00000000
| Blk cnt:  0x00000000
Nov 24 09:58:53 extragalactix kernel: [  167.040070] sdhci: Argument: 0=
x00000000
| Trn mode: 0x00000000
Nov 24 09:58:53 extragalactix kernel: [  167.040074] sdhci: Present:  0=
x01f70000
| Host ctl: 0x00000001
Nov 24 09:58:53 extragalactix kernel: [  167.040078] sdhci: Power:    0=
x0000000f
| Blk gap:  0x00000000
Nov 24 09:58:53 extragalactix kernel: [  167.040082] sdhci: Wake-up:  0=
x00000000
| Clock:    0x00004007
Nov 24 09:58:53 extragalactix kernel: [  167.040086] sdhci: Timeout:  0=
x00000000
| Int stat: 0x00000000
Nov 24 09:58:53 extragalactix kernel: [  167.040089] sdhci: Int enab: 0=
x00ff00c3
| Sig enab: 0x00ff00c3
Nov 24 09:58:53 extragalactix kernel: [  167.040093] sdhci: AC12 err: 0=
x00000000
| Slot int: 0x00000001
Nov 24 09:58:53 extragalactix kernel: [  167.040097] sdhci: Caps:     0=
x00c02120
| Max curr: 0x00000040
Nov 24 09:58:53 extragalactix kernel: [  167.040098] sdhci:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--=20
Dr. Bringfried Stecklum
Th=FCringer Landessternwarte
Sternwarte 5
07778 Tautenburg, Germany
Phone: +49-36427-863-54
=46AX:   +49-36427-863-29



