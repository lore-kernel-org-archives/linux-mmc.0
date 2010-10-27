From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: SDIO runtime crash on resume
Date: Wed, 27 Oct 2010 22:37:26 +0200
Message-ID: <AANLkTi=0oL38cmbGJ3sfE876ZxJUfrKK+wTs5+JBTR_r@mail.gmail.com>
References: <AANLkTikVuQx+hUX8onLVdHW1mhfbH7MZJqsHt0s-baiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46532 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904Ab0J0Uhr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Oct 2010 16:37:47 -0400
Received: by gxk23 with SMTP id 23so768480gxk.19
        for <linux-mmc@vger.kernel.org>; Wed, 27 Oct 2010 13:37:46 -0700 (PDT)
In-Reply-To: <AANLkTikVuQx+hUX8onLVdHW1mhfbH7MZJqsHt0s-baiA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Hi Daniel,

On Wed, Oct 27, 2010 at 8:46 PM, Daniel Drake <dsd@laptop.org> wrote:
> Hi,
>
> Testing linux-next, I get a crash during resume. Reproduced on an
> XO-1.5. mmc1 is the wifi card, for which the driver is not loaded.

=46or some reason I can't get linux-next to boot on my setup (strangely
VFS refuses to mount my NFS rootfs).

Until I get this sorted, can you please tell me if you can reproduce
this with mmc-next ?

Can you please also send full logs (from boot to crash preferably) + .c=
onfig ?

Thanks,
Ohad.

>
> Reverting 9b966aae64^..ed2a978594 (9 runtime sdio patches) causes the
> issue to go away.
>
>
> mmc1: error -110 during resume (card was removed?)
> PM: resume of devices complete after 338.994 msecs
> Restarting tasks ...
> hub 1-0:1.0: over-current change on port 1
> done.
> usb 1-2: USB disconnect, address 2
> mmc1: card 0001 removed
> BUG: unable to handle kernel NULL pointer dereference at 00000104
> IP: [<b05e9d95>] __pm_runtime_idle+0x15/0x53
> *pde =3D 39a62067 *pte =3D 00000000
> Oops: 0002 [#1] PREEMPT
> last sysfs file: /sys/devices/pci0000:00/0000:00:10.4/usb1/idVendor
> Modules linked in:
>
> Pid: 2011, comm: kworker/u:12 Not tainted 2.6.36-next-20101027+ #10 X=
O/XO
> EIP: 0060:[<b05e9d95>] EFLAGS: 00010202 CPU: 0
> EIP is at __pm_runtime_idle+0x15/0x53
> EAX: 00000004 EBX: 00000004 ECX: 00000001 EDX: 00000005
> ESI: e9b58c10 EDI: e9f5bf40 EBP: e9f5bf18 ESP: e9f5bf04
> =A0DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
> Process kworker/u:12 (pid: 2011, ti=3De9f5a000 task=3De9dd45d0 task.t=
i=3De9f5a000)
> Stack:
> =A0e9b58a48 e9b58c10 e9b58a48 e9b58c10 e9f5bf40 e9f5bf28 b06474d0 e9b=
58a48
> =A0e9b58c10 e9f5bf50 b0642fab 00061a80 000493e0 00030d40 000186a0 b07=
40857
> =A0e9b58cb0 e9e4ed38 b09372c0 e9f5bf7c b0433f50 e9f5bf64 b041a8de b06=
42f29
> Call Trace:
> =A0[<b06474d0>] ? mmc_sdio_detect+0x85/0x89
> =A0[<b0642fab>] ? mmc_rescan+0x82/0x279
> =A0[<b0740857>] ? sub_preempt_count+0x81/0x8e
> =A0[<b0433f50>] ? process_one_work+0x1d0/0x31d
> =A0[<b041a8de>] ? get_parent_ip+0xb/0x31
> =A0[<b0642f29>] ? mmc_rescan+0x0/0x279
> =A0[<b043420c>] ? worker_thread+0x16f/0x2a2
> =A0[<b043409d>] ? worker_thread+0x0/0x2a2
> =A0[<b0436ba7>] ? kthread+0x66/0x6b
> =A0[<b0436b41>] ? kthread+0x0/0x6b
> =A0[<b0402db6>] ? kernel_thread_helper+0x6/0x10
> Code: 08 00 00 00 89 d8 e8 6f fe ff ff 89 f0 e8 9d 44 15 00 5b 5e 5d
> c3 55 89 e5 57 56 53 83 ec 08 0f 1f 44 00 00 f6 c2 04 89 c3 74 0f <ff=
>
> 88 00 01
> EIP: [<b05e9d95>] __pm_runtime_idle+0x15/0x53 SS:ESP 0068:e9f5bf04
> CR2: 0000000000000104
> ---[ end trace b018ceefced52bd9 ]---
>
> Daniel
>
