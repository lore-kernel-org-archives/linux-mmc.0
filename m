From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 32242] New: irq 18, nobody cared, nor did
 irqpoll
Date: Wed, 30 Mar 2011 16:51:40 -0700
Message-ID: <20110330165140.c5ca5705.akpm@linux-foundation.org>
References: <bug-32242-10286@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <bug-32242-10286@https.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
To: harri@afaics.de
Cc: bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-acpi@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Wed, 30 Mar 2011 13:06:17 GMT
bugzilla-daemon@bugzilla.kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=32242
> 
>            Summary: irq 18, nobody cared, nor did irqpoll
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 2.6.38.2


Is this a regression?  Was 2.6.37 OK?

>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Other
>         AssignedTo: drivers_other@kernel-bugs.osdl.org
>         ReportedBy: harri@afaics.de
>         Regression: No
> 
> 
> Created an attachment (id=52622)
>  --> (https://bugzilla.kernel.org/attachment.cgi?id=52622)
> kernel config file
> 
> I got this at boot time of my laptop:
> 
> [   11.837498] irq 18: nobody cared (try booting with the "irqpoll" option)
> [   11.837503] Pid: 1618, comm: echo Not tainted 2.6.38.2 #1
> [   11.837504] Call Trace:
> [   11.837506]  <IRQ>  [<ffffffff810723af>] ?
> __report_bad_irq.clone.2+0x30/0x7c
> [   11.837515]  [<ffffffff81072502>] ? note_interrupt+0x107/0x179
> [   11.837518]  [<ffffffff81072f8e>] ? handle_fasteoi_irq+0xa6/0xd4
> [   11.837522]  [<ffffffff810036cc>] ? call_softirq+0x1c/0x28
> [   11.837525]  [<ffffffff8100514f>] ? handle_irq+0x17/0x1d
> [   11.837527]  [<ffffffff81004e80>] ? do_IRQ+0x45/0xad
> [   11.837532]  [<ffffffff812a2d13>] ? ret_from_intr+0x0/0xe
> [   11.837533]  <EOI>  [<ffffffff81175b76>] ? cfb_imageblit+0x19e/0x434
> [   11.837539]  [<ffffffff812a2d0e>] ? common_interrupt+0xe/0x13
> [   11.837543]  [<ffffffff81170fa7>] ? bit_putcs+0x3c0/0x455
> [   11.837546]  [<ffffffff81170bcb>] ? bit_cursor+0x439/0x455
> [   11.837549]  [<ffffffff8116b93b>] ? fbcon_putcs+0xef/0xfe
> [   11.837551]  [<ffffffff81170be7>] ? bit_putcs+0x0/0x455
> [   11.837554]  [<ffffffff8116ef5b>] ? fbcon_redraw.clone.15+0xcb/0x160
> [   11.837557]  [<ffffffff8116f60e>] ? fbcon_scroll+0x61e/0xb9d
> [   11.837561]  [<ffffffff811b2436>] ? scrup+0x67/0xd4
> [   11.837563]  [<ffffffff811b25c7>] ? lf+0x25/0x58
> [   11.837566]  [<ffffffff811b58fb>] ? do_con_write+0x8aa/0x1e40
> [   11.837569]  [<ffffffff81170792>] ? bit_cursor+0x0/0x455
> [   11.837572]  [<ffffffff811b6ed5>] ? con_write+0xd/0x23
> [   11.837575]  [<ffffffff811a5593>] ? do_output_char+0x87/0x199
> [   11.837578]  [<ffffffff811a56d4>] ? process_output+0x2f/0x43
> [   11.837580]  [<ffffffff811a6063>] ? n_tty_write+0x26b/0x34d
> [   11.837584]  [<ffffffff8103018a>] ? default_wake_function+0x0/0x11
> [   11.837587]  [<ffffffff811a3374>] ? tty_write+0x1ad/0x231
> [   11.837589]  [<ffffffff811a5df8>] ? n_tty_write+0x0/0x34d
> [   11.837593]  [<ffffffff810b7b60>] ? vfs_write+0xaf/0x129
> [   11.837596]  [<ffffffff810b7db3>] ? sys_write+0x45/0x6e
> [   11.837598]  [<ffffffff8100287b>] ? system_call_fastpath+0x16/0x1b
> [   11.837600] handlers:
> [   11.837601] [<ffffffffa01f80a7>] (sdhci_irq+0x0/0x4d5 [sdhci])
> [   11.837621] [<ffffffffa05bb871>] (r852_irq+0x0/0x201 [r852])

So both sdhci_irq and r852_irq were looking at the IRQ, but neither of
them were interested in it.

Could be that the bug lies in neither driver, at that something went
wrong with the system setup.  ACPI?

> [   11.837625] Disabling IRQ #18
> 
> Booting with irqpoll as suggested did not help. With this option set I got 
> 
> [   31.135445] irq 18: nobody cared (try booting with the "irqpoll" option)
> [   31.136345] Pid: 0, comm: kworker/0:0 Not tainted 2.6.38.2 #1
> [   31.136345] Call Trace:
> [   31.136345]  <IRQ>  [<ffffffff810723af>] ?
> __report_bad_irq.clone.2+0x30/0x7c
> [   31.136345]  [<ffffffff81072502>] ? note_interrupt+0x107/0x179
> [   31.136345]  [<ffffffff81072f8e>] ? handle_fasteoi_irq+0xa6/0xd4
> [   31.136345]  [<ffffffff8100514f>] ? handle_irq+0x17/0x1d
> [   31.136345]  [<ffffffff81004e80>] ? do_IRQ+0x45/0xad
> [   31.136345]  [<ffffffff812a2d13>] ? ret_from_intr+0x0/0xe
> [   31.136345]  <EOI>  [<ffffffffa0416f7c>] ? acpi_idle_enter_simple+0xd2/0x104
> [processor]
> [   31.136345]  [<ffffffffa0416f77>] ? acpi_idle_enter_simple+0xcd/0x104
> [processor]
> [   31.136345]  [<ffffffff81208efc>] ? cpuidle_idle_call+0x91/0xce
> [   31.136345]  [<ffffffff81001182>] ? cpu_idle+0x4a/0x64
> [   31.136345] handlers:
> [   31.136345] [<ffffffffa01d80a7>] (sdhci_irq+0x0/0x4d5 [sdhci])
> [   31.136345] [<ffffffffa06c1871>] (r852_irq+0x0/0x201 [r852])
> [   31.136345] Disabling IRQ #18

