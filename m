From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: fix wakeirq handling on removal
Date: Tue, 4 Sep 2018 08:38:28 -0700
Message-ID: <20180904153828.GC5662@atomide.com>
References: <20180902073058.17053-1-andreas@kemnade.info>
 <CAPDyKFpHPre_turpYtpB+N+LHR+EMW2p2GJ92J1zu8h6p5W=LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpHPre_turpYtpB+N+LHR+EMW2p2GJ92J1zu8h6p5W=LQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andreas Kemnade <andreas@kemnade.info>, Kishon <kishon@ti.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-mmc@vger.kernel.org

* Ulf Hansson <ulf.hansson@linaro.org> [180904 14:39]:
> On 2 September 2018 at 09:30, Andreas Kemnade <andreas@kemnade.info> wrote:
> > after unbinding mmc I get things like this:
> > [  185.294067] mmc1: card 0001 removed
> > [  185.305206] omap_hsmmc 480b4000.mmc: wake IRQ with no resume: -13
> >
> > The wakeirq stays in /proc-interrupts
> >
> > rebinding shows this:
> > [  289.795959] genirq: Flags mismatch irq 112. 0000200a (480b4000.mmc:wakeup) vs. 0000200a (480b4000.mmc:wakeup)
> > [  289.808959] omap_hsmmc 480b4000.mmc: Unable to request wake IRQ
> > [  289.815338] omap_hsmmc 480b4000.mmc: no SDIO IRQ support, falling back to polling
> >
> > That bug seems to be introduced by switching from devm_request_irq()
> > to generic wakeirq handling.
> >
> > So let us cleanup at removal.
> >
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > Fixes: 5b83b2234be6 ("mmc: omap_hsmmc: Change wake-up interrupt to use generic wakeirq")

Ooops sorry about that.

> Applied for fixes, and added a stable tag, thanks!

OK and thanks for fixing this Andreas!

Regards,

Tony
