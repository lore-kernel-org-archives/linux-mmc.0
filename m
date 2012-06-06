From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: omap: Fix NULL pointer dereference if mmc_omap_new_slot() fails
Date: Wed, 06 Jun 2012 09:46:35 -0400
Message-ID: <87aa0g4kp0.fsf@octavius.laptop.org>
References: <20120528065347.GR17852@atomide.com>
	<20120528103641.GA12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120528103641.GA12766@atomide.com> (Tony Lindgren's message of
	"Mon, 28 May 2012 03:36:42 -0700")
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, May 28 2012, Tony Lindgren wrote:
> Commit b01a4f1c (mmc: omap: convert to per instance workqueue) initializes
> the workqueue too late causing the following:
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pgd = c0004000
> [00000000] *pgd=00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Modules linked in:
> CPU: 0    Not tainted  (3.4.0-08218-gb48b2c3 #158)
> PC is at __queue_work+0x8/0x46c
> LR is at queue_work_on+0x38/0x40
> pc : [<c005bb4c>]    lr : [<c005c00c>]    psr: 60000193
> sp : c0691e1c  ip : 00000000  fp : c07374ac
> r10: c7aae400  r9 : c0395700  r8 : 00000100
> r7 : c0691e70  r6 : 00000000  r5 : 00000000  r4 : c7aae440
> r3 : 00000001  r2 : c7aae440  r1 : 00000000  r0 : 00000000
> Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 00c5387d  Table: 80004000  DAC: 00000017
> Process swapper/0 (pid: 0, stack limit = 0xc06902f8)
> Stack: (0xc0691e1c to 0xc0692000)
>
> Fix this by initializing the workqueue before mmc_omap_remove_slot()
> get called. Tested on n770, looks like n800 at least still has some
> other issue with MMC.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Thanks, pushed to mmc-next for 3.5.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
