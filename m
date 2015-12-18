From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [bug] kernel panic if writting data to mmc after suspendding
Date: Fri, 18 Dec 2015 10:33:40 +0100
Message-ID: <CAMuHMdWU0WVBiWSsLti=KSidFk198k_3CAiNm=iGLtmw4wQOgw@mail.gmail.com>
References: <566A21D2.4080009@jinso.co.jp>
	<566E2AC0.8060800@jinso.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:33235 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbbLRJdl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Dec 2015 04:33:41 -0500
In-Reply-To: <566E2AC0.8060800@jinso.co.jp>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, "ltsi-dev@lists.linuxfoundation.org" <ltsi-dev@lists.linuxfoundation.org>, =?UTF-8?B?U2ltb24g44GV44KT?= <simon@horms.net>, Geert Uytterhoeven <geert+renesas@glider.be>, =?UTF-8?B?U+mWizEyL+WdguaIuFND?= <ryusuke.sakato.bx@renesas.com>, "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>, =?UTF-8?B?TWFnbnVzIOOBleOCkw==?= <magnus.damm@gmail.com>, Hisao Munakata <hisao.munakata.vt@renesas.com>, Ulf Hansson <ulf.hansson@linaro.org>

Hi Dung-san,

CC Ulf

On Mon, Dec 14, 2015 at 3:34 AM, Nguyen Viet Dung <nv-dung@jinso.co.jp> wrote:
> While is testting LTSI-v4.1.13-rc1, we have found the following the failure
> of mmcif.
> 1. mount mmc block
> 2. write data to mmc block
> 3. suspend/resume
> 4. write data to mmc block one again => happen kernel panic
> (Probability in this test procedure is 100%)
>
> We have used git bisect to find cause of failure in LTS-v4.1.13 to
> LTSI-v4.1.13-rc1
> and have found commit which cause failure.
> (On LTS-v4.1.13 has not this failure)
>  drivers: sh: Disable PM runtime for multi-platform ARM with genpd
>  commit :cbc41d0a761bffb3166a413a3c77100a737c0cd7

That means there's a bug in Runtime PM handling of the sh_mmcif driver, or
in the MMC subsystem.

Usually such bugs cause a kernel hang on register access, not a NULL pointer
dereference, though.

> root@linaro-nano:~# Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pgd = c0004000
> [00000000] *pgd=00000000
> Internal error: Oops: 17 [#1] SMP ARM
> CPU: 0 PID: 860 Comm: irq/100-ee22000 Not tainted 4.1.13-ltsi-00392-g1126bdd-dirty #7
> Hardware name: Generic R8A7790 (Flattened Device Tree)
> task: ee1e5100 ti: ee11a000 task.ti: ee11a000
> PC is at sh_mmcif_irqt+0x8c0/0xbc4
> LR is at sh_mmcif_irqt+0x50/0xbc4

Do you know where exactly in sh_mmcif_irqt() it's crashing?
This is a large function, and without access to the same kernel binary it
is difficult to find this.

I do not have a Lager board.

> pc : [<c03c6b60>]    lr : [<c03c62f0>]    psr: 80000013
> sp : ee11beb8  ip : ee11beb8  fp : ee11bf04
> r10: 00000000  r9 : 00000001  r8 : edc2c1e0
> r7 : edc2c1c0  r6 : edbfae14  r5 : edbfad50  r4 : edc2d340
> r3 : 00000000  r2 : 00000200  r1 : 00000000  r0 : edc2d3b8
> Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 10c5307d  Table: 6df6406a  DAC: 00000015
> Process irq/100-ee22000 (pid: 860, stack limit = 0xee11a210)
> Stack: (0xee11beb8 to 0xee11c000)
> bea0:                                                       ee11bf0c ee11bec8
> bec0: c0505dbc c004222c 00000003 00000001 edc2d374 edc2d3b8 ee11bf14 edc2c1c0
> bee0: ee11a000 eea77a00 edc2c1c0 edc2c1e0 00000001 00000000 ee11bf24 ee11bf08
> bf00: c005e040 c03c62ac eea77a00 ee11a000 c005e01c edc2c1c0 ee11bf5c ee11bf28
> bf20: c005e320 c005e028 00000000 c005e178 00000000 edc2c180 00000000 edc2c1c0
> bf40: c005e22c 00000000 00000000 00000000 ee11bfac ee11bf60 c003e288 c005e238
> bf60: c00369dc 00000000 c000b3a8 edc2c1c0 00000000 00000000 ee11bf78 ee11bf78
> bf80: 00000000 00000000 ee11bf88 ee11bf88 edc2c180 c003e1a8 00000000 00000000
> bfa0: 00000000 ee11bfb0 c000fc88 c003e1b4 00000000 00000000 00000000 00000000
> bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 6f7fd821 6f7fdc21
> Backtrace:
> [<c03c62a0>] (sh_mmcif_irqt) from [<c005e040>] (irq_thread_fn+0x24/0x3c)
>  r10:00000000 r9:00000001 r8:edc2c1e0 r7:edc2c1c0 r6:eea77a00 r5:ee11a000
>  r4:edc2c1c0
> [<c005e01c>] (irq_thread_fn) from [<c005e320>] (irq_thread+0xf4/0x16c)
>  r7:edc2c1c0 r6:c005e01c r5:ee11a000 r4:eea77a00
> [<c005e22c>] (irq_thread) from [<c003e288>] (kthread+0xe0/0xf4)
>  r10:00000000 r9:00000000 r8:00000000 r7:c005e22c r6:edc2c1c0 r5:00000000
>  r4:edc2c180
> [<c003e1a8>] (kthread) from [<c000fc88>] (ret_from_fork+0x14/0x2c)
>  r7:00000000 r6:00000000 r5:c003e1a8 r4:edc2c180
> Code: e7f001f2 e5942068 e1530122 2a000004 (e4910004)
> ---[ end trace 7ef9a16c0c18005a ]---

> (On LTS-v4.1.13 has not this failure,on uptream v4.4-rc2 has this failure)

Note that this has to be fixed in upstream first,  before the fix can
be backported
to LTSI-v4.1.13.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
