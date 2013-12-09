From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 2/2] mmc: sdhci-msm: Initial support for MSM chipsets
Date: Mon, 9 Dec 2013 09:46:44 +0000
Message-ID: <20131209094644.GC28379@e106331-lin.cambridge.arm.com>
References: <1383753405-23631-1-git-send-email-gdjakov@mm-sol.com>
 <1383753405-23631-3-git-send-email-gdjakov@mm-sol.com>
 <20131205102740.GI29200@e106331-lin.cambridge.arm.com>
 <52A1BCEF.30505@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52A1BCEF.30505@mm-sol.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Georgi Djakov <gdjakov@mm-sol.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "rob@landley.net" <rob@landley.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

> > [...]
> >
> >> +       /*
> >> +        * CORE_SW_RST above may trigger power irq if previous status of PWRCTL
> >> +        * was either BUS_ON or IO_HIGH_V. So before we enable the power irq
> >> +        * interrupt in GIC (by registering the interrupt handler), we need to
> >> +        * ensure that any pending power irq interrupt status is acknowledged
> >> +        * otherwise power irq interrupt handler would be fired prematurely.
> >> +        */
> >> +       irq_status = readl_relaxed(msm_host->core_mem + CORE_PWRCTL_STATUS);
> >> +       writel_relaxed(irq_status, (msm_host->core_mem + CORE_PWRCTL_CLEAR));
> >> +       irq_ctl = readl_relaxed(msm_host->core_mem + CORE_PWRCTL_CTL);
> >> +       if (irq_status & (CORE_PWRCTL_BUS_ON | CORE_PWRCTL_BUS_OFF))
> >> +               irq_ctl |= CORE_PWRCTL_BUS_SUCCESS;
> >> +       if (irq_status & (CORE_PWRCTL_IO_HIGH | CORE_PWRCTL_IO_LOW))
> >> +               irq_ctl |= CORE_PWRCTL_IO_SUCCESS;
> >> +       writel_relaxed(irq_ctl, (msm_host->core_mem + CORE_PWRCTL_CTL));
> >> +       /*
> >> +        * Ensure that above writes are propogated before interrupt enablement
> >> +        * in GIC.
> >> +        */
> >> +       mb();
> >
> > Does this guarantee that the device has finished responding to the write
> > and deasserted the interrupt line (i.e. does the device only acknowledge
> > the write once that is true)?
> >
> 
> I am not sure that i understand your concern. The write to 
> CORE_PWRCTL_CTL should acknowledge and deassert the interrupt.

The mb() ensures that the write has reached the device, and the device's
slave interface has acknowledged the write. On some devices this
acknowledgement of the write can be asynchronous with respect to the
device changing state in response to the write (i.e. the interrupt might
get deasserted a short time after the write completes). Typically there
is a register that should be polled to see whether the state change has
completed.

Does the acknowledgement of the write only occur once the device has
changed state? Or might it change state in the background?

Thanks,
Mark
