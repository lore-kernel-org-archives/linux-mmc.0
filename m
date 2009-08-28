From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: irq 18: nobody cared after resume
Date: Fri, 28 Aug 2009 11:16:50 +0200
Message-ID: <4A97A082.6040208@gmail.com>
References: <c4e36d110908280148p4ee31c71l4f0c0c906fe06ebe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:33591 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbZH1JQu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Aug 2009 05:16:50 -0400
In-Reply-To: <c4e36d110908280148p4ee31c71l4f0c0c906fe06ebe@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zdenek Kabelac <zdenek.kabelac@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org

On 08/28/2009 10:48 AM, Zdenek Kabelac wrote:
> /proc/interrrupts:
> 18:        384        395   IO-APIC-fasteoi   uhci_hcd:usb7, mmc0
...
> HDA Intel 0000:00:1b.0: PCI INT B -> GSI 17 (level, low) -> IRQ 17
> irq 18: nobody cared (try booting with the "irqpoll" option)
> Pid: 0, comm: swapper Not tainted 2.6.31-rc7-00059-ge716334 #19
> Call Trace:
>  <IRQ>  [<ffffffff810a500b>] __report_bad_irq+0x2b/0xa0
>  [<ffffffff810a520a>] note_interrupt+0x18a/0x1d0
>  [<ffffffff810a588d>] handle_fasteoi_irq+0xcd/0xf0
>  [<ffffffff8100ee99>] handle_irq+0x49/0xa0
>  [<ffffffff813e1343>] do_IRQ+0x73/0xf0
>  [<ffffffff8100cb93>] ret_from_intr+0x0/0xf
>  <EOI>  [<ffffffff8129057d>] ? acpi_idle_enter_c1+0xa1/0xc0
>  [<ffffffff8107d83d>] ? trace_hardirqs_on+0xd/0x10
>  [<ffffffff81290580>] ? acpi_idle_enter_c1+0xa4/0xc0
>  [<ffffffff8129057d>] ? acpi_idle_enter_c1+0xa1/0xc0
>  [<ffffffff81334a9b>] ? cpuidle_idle_call+0x9b/0xf0
>  [<ffffffff8100aa7b>] ? cpu_idle+0x6b/0xd0
>  [<ffffffff813c72ca>] ? rest_init+0x7a/0x80
>  [<ffffffff81601b02>] ? start_kernel+0x38f/0x39b
>  [<ffffffff81601128>] ? x86_64_start_reservations+0x125/0x129
>  [<ffffffff8160120d>] ? x86_64_start_kernel+0xe1/0xe8
> handlers:
> [<ffffffffa0006720>] (usb_hcd_irq+0x0/0xa0 [usbcore])

The interesting thing is that there is no mmc handler. So it seems like
mmc disabled the irq in kernel, but not in HW?
