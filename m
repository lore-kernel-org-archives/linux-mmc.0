From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 0/2] genirq: Add functions to avoid driver hackery
Date: Sat, 15 Feb 2014 00:55:18 -0000
Message-ID: <20140215002742.507053194@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>, Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-mmc@vger.kernel.org

Russell tricked me to look into the homebrewn kthread hackery of
drivers/mmc. I'm still trying to recover from that.

But it spurred an interesting discussion how to improve things and the
outcome was the following series of patches:

1) Provide means to synchronize only hard irq context

2) Provide means to trigger a threaded irq handler from any context

The main rationale is to cleanup the mess in drivers/mmc and other
places but each of the patches has a justification for itself
exemplified by the drivers/mmc use case, which is explained in detail
in the changelogs of the individual patches.

Russell has a working implementation for sdhci which relies on patch
#1 ready and quite some ideas how to make use of #2 to kill the
sdio_irq kthread hackery.

Thanks,

	tglx
