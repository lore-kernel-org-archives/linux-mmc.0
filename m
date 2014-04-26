From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH RESEND 0/3] Orion irqchip and Kirkwood SDIO
Date: Sat, 26 Apr 2014 21:34:12 +0200
Message-ID: <1398540855-27367-1-git-send-email-sebastian.hesselbarth@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Nicolas Pitre <nico@fluxnic.net>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Guys,

we somehow forgot this patch set, which was aimed for v3.12/v3.13
and first sent and acked in November 2013 [1]. Now this is rebase on
to v3.15-rc1 and should be taken for v3.16.

In contrast to the original patch set, I reordered the individual
patches by subsystem and made some cosmetic but no functional changes.

>From the original patch set:

This patch set tries to deal with a minor irq issue seen on Marvell
Kirkwood SoCs with irqchip/irq-orion and mvsdio drivers. In contrast
to non-DT irq handling, irqchip driver does handle irqs a little bit
different. First of all, it reads irq cause register once and works
through all bits set while non-DT irq handling read irq cause and
handled only one irq. Second, irqchip reverses irq priorities by
using ffs() instead of fls().
This now, seems to trigger a minor ip design issue in sdio peripheral
where sdio irq can occur upstream while sdio interrupts are all
disabled in the ip registers. This extra, unexpected irq does neither
harm correct function of HW nor SW driver but triggers a warning in
mvsdio irq handler.

I have tried to debug this and can say that the sequence of irq
related events is:
(a) sdio irq is set in upstream irq
(b) generic-chip handler masks sdio irq
(c) sdio irq handler deals with it,
    acks and disables all peripheral irq registers
(d) sdio irq cause is cleared
(e) generic-chip handler unmasks sdio irq
(f) sdio irq is set in upstream irq and cleared little later
(g) sdio irq handler is upset about being called with no irq to handle

This patch set is actually three independent patches in one as mvsdio
irq workaround just motivates irqchip handling changes. The third just
silences a noisy mvsdio dev_notice down to dev_dbg. I have chosen to
keep them together anyway. Below is a more detailed description of the
individual patches.

First patch silences a card detect mechanism related dev_notice to
dev_dbg to not bother users with that.

Second patch works around the spurious irq issue in mvsdio by bailing
out of the irq handler early, if peripheral irq registers indicate that
none should have been fired.

Third patch reverses irq handling priority for irqchip driver to what
non-DT irq did before by using fls() instead of ffs(). The "read cause
once, work through all irqs" handling is maintained.

[1] https://lkml.org/lkml/2013/11/15/276

Sebastian Hesselbarth (3):
  mmc: mvsdio: silence card detect notice
  mmc: mvsdio: workaround for spurious irqs
  irqchip: orion: reverse irq handling priority

 drivers/irqchip/irq-orion.c |  4 ++--
 drivers/mmc/host/mvsdio.c   | 20 +++++++++++++++++---
 2 files changed, 19 insertions(+), 5 deletions(-)

---
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
-- 
1.9.1
