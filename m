From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: Fix PIO mode with support of highmem
Date: Thu, 9 Feb 2012 10:27:36 +0000
Message-ID: <CAFbHwiQq-vseHWuEB1nHRWg2GLjU05PJBH=GWo=6dwwsc24_mw@mail.gmail.com>
References: <000901cce6ec$3f2f0c20$bd8d2460$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59480 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757672Ab2BIK1h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Feb 2012 05:27:37 -0500
Received: by daed14 with SMTP id d14so1327325dae.19
        for <linux-mmc@vger.kernel.org>; Thu, 09 Feb 2012 02:27:36 -0800 (PST)
In-Reply-To: <000901cce6ec$3f2f0c20$bd8d2460$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, James Hogan <james.hogan@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>

On Thu, Feb 9, 2012 at 5:32 AM, Seungwon Jeon <tgih.jun@samsung.com> wr=
ote:
> Current PIO mode makes a kernel crash with CONFIG_HIGHMEM.
> Highmem pages have a NULL from sg_virt(sg).
> This patch fixes the following problem.
>
> Unable to handle kernel NULL pointer dereference at virtual address 0=
0000000
> pgd =3D c0004000
> [00000000] *pgd=3D00000000
> Internal error: Oops: 817 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 =A0 =A0Not tainted =A0(3.0.15-01423-gdbf465f #589)
> PC is at dw_mci_pull_data32+0x4c/0x9c
> LR is at dw_mci_read_data_pio+0x54/0x1f0
> pc : [<c0358824>] =A0 =A0lr : [<c035988c>] =A0 =A0psr: 20000193
> sp : c0619d48 =A0ip : c0619d70 =A0fp : c0619d6c
> r10: 00000000 =A0r9 : 00000002 =A0r8 : 00001000
> r7 : 00000200 =A0r6 : 00000000 =A0r5 : e1dd3100 =A0r4 : 00000000
> r3 : 65622023 =A0r2 : 0000007f =A0r1 : eeb96000 =A0r0 : e1dd3100
> Flags: nzCv =A0IRQs off =A0FIQs on =A0Mode SVC_32 =A0ISA ARM =A0Segme=
nt
> kernel
> Control: 10c5387d =A0Table: 61e2004a =A0DAC: 00000015
> Process swapper (pid: 0, stack limit =3D 0xc06182f0)
> Stack: (0xc0619d48 to 0xc061a000)
> 9d40: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 e1dd3100 e1a4f000 00000000 =
e1dd3100 e1a4f000 00000200
> 9d60: c0619da4 c0619d70 c035988c c03587e4 c0619d9c e18158f4 e1dd3100 =
e1dd3100
> 9d80: 00000020 00000000 00000000 00000020 c06e8a84 00000000 c0619e04 =
c0619da8
> 9da0: c0359b24 c0359844 e18158f4 e1dd3164 e1dd3168 e1dd3150 3d02fc79 =
e1dd3154
> 9dc0: e1dd3178 00000000 00000020 00000000 e1dd3150 00000000 c10dd7e8 =
e1a84900
> 9de0: c061e7cc 00000000 00000000 0000008d c06e8a84 c061e780 c0619e4c =
c0619e08
> 9e00: c00c4738 c0359a34 3d02fc79 00000000 c0619e4c c05a1698 c05a1670 =
c05a165c
> 9e20: c04de8b0 c061e780 c061e7cc e1a84900 ffffed68 0000008d c0618000 =
00000000
> 9e40: c0619e6c c0619e50 c00c48b4 c00c46c8 c061e780 c00423ac c061e7cc =
ffffed68
> 9e60: c0619e8c c0619e70 c00c7358 c00c487c 0000008d ffffee38 c0618000 =
ffffed68
> 9e80: c0619ea4 c0619e90 c00c4258 c00c72b0 c00423ac ffffee38 c0619ecc =
c0619ea8
> 9ea0: c004241c c00c4234 ffffffff f8810000 0000006d 00000002 00000001 =
7fffffff
> 9ec0: c0619f44 c0619ed0 c0048bc0 c00423c4 220ae7a9 00000000 386f0d30 =
0005d3a4
> 9ee0: c00423ac c10dd0b8 c06f2cd8 c0618000 c0594778 c003a674 7fffffff =
c0619f44
> 9f00: 386f0d30 c0619f18 c00a6f94 c005be3c 80000013 ffffffff 386f0d30 =
0005d3a4
> 9f20: 386f0d30 0005d2d1 c10dd0a8 c10dd0b8 c06f2cd8 c0618000 c0619f74 =
c0619f48
> 9f40: c0345858 c005be00 c00a2440 c0618000 c0618000 c00410d8 c06c1944 =
c00410fc
> 9f60: c0594778 c003a674 c0619f9c c0619f78 c004a7e8 c03457b4 c0618000 =
c06c18f8
> 9f80: 00000000 c0039c70 c06c18d4 c003a674 c0619fb4 c0619fa0 c04ceafc =
c004a714
> 9fa0: c06287b4 c06c18f8 c0619ff4 c0619fb8 c0008b68 c04cea68 c0008578 =
00000000
> 9fc0: 00000000 c003a674 00000000 10c5387d c0628658 c003aa78 c062f1c4 =
4000406a
> 9fe0: 413fc090 00000000 00000000 c0619ff8 40008044 c0008858 00000000 =
00000000
> Backtrace:
> [<c03587d8>] (dw_mci_pull_data32+0x0/0x9c) from [<c035988c>] (dw_mci_=
read_data_pio+0x54/0x1f0)
> =A0r6:00000200 r5:e1a4f000 r4:e1dd3100
> =A0[<c0359838>] (dw_mci_read_data_pio+0x0/0x1f0) from [<c0359b24>] (d=
w_mci_interrupt+0xfc/0x4a4)
> [<c0359a28>] (dw_mci_interrupt+0x0/0x4a4) from [<c00c4738>] (handle_i=
rq_event_percpu+0x7c/0x1b4)
> [<c00c46bc>] (handle_irq_event_percpu+0x0/0x1b4) from [<c00c48b4>] (h=
andle_irq_event+0x44/0x64)
> [<c00c4870>] (handle_irq_event+0x0/0x64) from [<c00c7358>] (handle_fa=
steoi_irq+0xb4/0x124)
> =A0r7:ffffed68 r6:c061e7cc r5:c00423ac r4:c061e780
> =A0[<c00c72a4>] (handle_fasteoi_irq+0x0/0x124) from [<c00c4258>] (gen=
eric_handle_irq+0x30/0x38)
> =A0r7:ffffed68 r6:c0618000 r5:ffffee38 r4:0000008d
> =A0[<c00c4228>] (generic_handle_irq+0x0/0x38) from [<c004241c>] (asm_=
do_IRQ+0x64/0xe0)
> =A0r5:ffffee38 r4:c00423ac
> =A0[<c00423b8>] (asm_do_IRQ+0x0/0xe0) from [<c0048bc0>] (__irq_svc+0x=
80/0x14c)
> Exception stack(0xc0619ed0 to 0xc0619f18)
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

This patch looks ok to me.

Acked-by: Will Newton <will.newton@imgtec.com>
