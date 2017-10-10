From: Chris Brandt <Chris.Brandt@renesas.com>
Subject: renesas sdhi driver and DMA
Date: Tue, 10 Oct 2017 19:05:03 +0000
Message-ID: <SG2PR06MB1165F16A63D6793DBEC419688A750@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hello Wolfram,

For my RZ/A1 DMA driver (it's a work in progress), the patch

52ad9a8e854c ("mmc: host: tmio: ensure end of DMA and SD access are in sync=
")

now causes a "BUG: scheduling while atomic"

Starting logging: BUG: scheduling while atomic: S01logging/434/0x00000100
CPU: 0 PID: 434 Comm: S01logging Not tainted 4.9.49-g845fe5990-dirty #29
Hardware name: Generic R7S72100 (Flattened Device Tree)
[<bf808d41>] (unwind_backtrace) from [<bf8075f3>] (show_stack+0xb/0xc)
[<bf8075f3>] (show_stack) from [<bf82038d>] (__schedule_bug+0x39/0x58)
[<bf82038d>] (__schedule_bug) from [<bfa2fba9>] (__schedule+0x21/0x238)
[<bfa2fba9>] (__schedule) from [<bfa2fe2d>] (schedule+0x51/0x58)
[<bfa2fe2d>] (schedule) from [<bfa313ad>] (schedule_timeout+0x15/0xcc)
[<bfa313ad>] (schedule_timeout) from [<bfa30427>] (wait_for_common+0x9b/0xb=
c)
[<bfa30427>] (wait_for_common) from [<bf9921e7>] (tmio_mmc_dma_callback+0xb=
/0x74)
[<bf9921e7>] (tmio_mmc_dma_callback) from [<bf908e1b>] (rzadma_tasklet+0x23=
/0x98)
[<bf908e1b>] (rzadma_tasklet) from [<bf810d9b>] (tasklet_action+0x3f/0x5c)
[<bf810d9b>] (tasklet_action) from [<bf810a47>] (__do_softirq+0x7f/0x144)
[<bf810a47>] (__do_softirq) from [<bf829917>] (__handle_domain_irq+0x51/0x6=
a)
[<bf829917>] (__handle_domain_irq) from [<bf80128b>] (gic_handle_irq+0x37/0=
x58)
[<bf80128b>] (gic_handle_irq) from [<bf807d25>] (__irq_svc+0x65/0x94)


I noticed that in rcar-dmac.c, the DMA channel IRQs are threaded:

	ret =3D devm_request_threaded_irq(dmac->dev, irq, rcar_dmac_isr_channel,
					rcar_dmac_isr_channel_thread, 0,
					irqname, rchan);

Is it now a requirement that I have to register my DMA channel=20
interrupts as devm_request_threaded_irq?

Will that fix my issue?

Thank you,
Chris
