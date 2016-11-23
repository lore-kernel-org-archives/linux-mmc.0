From: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 5/5] sdhci: Add quirk for delayed IRQ ACK
Date: Wed, 23 Nov 2016 12:12:09 +0800
Message-ID: <20161123121209.3623e14b@xhacker>
References: <1479863388-23678-1-git-send-email-jeremymc@redhat.com>
        <1479863388-23678-6-git-send-email-jeremymc@redhat.com>
        <20161123113647.0b3deac0@xhacker>
        <ecacec51-4b06-49cd-c756-489128729499@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ecacec51-4b06-49cd-c756-489128729499-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeremy McNicoll <jmcnicol-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Jeremy McNicoll <jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 22 Nov 2016 19:48:56 -0800 Jeremy McNicoll wrote:

> On 2016-11-22 7:36 PM, Jisheng Zhang wrote:
> > On Tue, 22 Nov 2016 17:09:48 -0800
> > Jeremy McNicoll <jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> >  
> >> On msm8992 it has been observed that IRQs were not getting
> >> ACK'd correctly when clocked at speeds greater than 400KHz.
> >>
> >> Signed-off-by: Jeremy McNicoll <jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >> ---
> >>  drivers/mmc/host/sdhci-msm.c |  7 +++++++
> >>  drivers/mmc/host/sdhci.c     | 12 ++++++++++--
> >>  drivers/mmc/host/sdhci.h     |  2 ++
> >>  3 files changed, 19 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> >> index 1fcda96..459003c 100644
> >> --- a/drivers/mmc/host/sdhci-msm.c
> >> +++ b/drivers/mmc/host/sdhci-msm.c
> >> @@ -1303,6 +1303,13 @@ static int sdhci_msm_probe(struct platform_device *pdev)
> >>  			       CORE_VENDOR_SPEC_CAPABILITIES0);
> >>  	}
> >>
> >> +	/* Enable delayed IRQ handling workaround on 8992 */
> >> +	if (core_major == 1 && core_minor == 0x3e) {
> >> +		/* Add 40us delay in interrupt handler when operating
> >> +		 * at initialization frequency of 400KHz. */
> >> +		host->quirks2 |= SDHCI_QUIRK2_SLOW_INT_CLR;
> >> +	}
> >> +
> >>  	/* Setup IRQ for handling power/voltage tasks with PMIC */
> >>  	msm_host->pwr_irq = platform_get_irq_byname(pdev, "pwr_irq");
> >>  	if (msm_host->pwr_irq < 0) {
> >> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >> index 5911f98..c1aae22 100644
> >> --- a/drivers/mmc/host/sdhci.c
> >> +++ b/drivers/mmc/host/sdhci.c
> >> @@ -2703,11 +2703,19 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
> >>  			result = IRQ_WAKE_THREAD;
> >>  		}
> >>
> >> -		if (intmask & SDHCI_INT_CMD_MASK)
> >> +		if (intmask & SDHCI_INT_CMD_MASK) {
> >> +			if ((host->quirks2 & SDHCI_QUIRK2_SLOW_INT_CLR) && (host->clock <= 400000)) {
> >> +				udelay(40);
> >> +			}
> >>  			sdhci_cmd_irq(host, intmask & SDHCI_INT_CMD_MASK);
> >> +		}
> >>
> >> -		if (intmask & SDHCI_INT_DATA_MASK)
> >> +		if (intmask & SDHCI_INT_DATA_MASK) {
> >> +			if ((host->quirks2 & SDHCI_QUIRK2_SLOW_INT_CLR) && (host->clock <= 400000)) {
> >> +				udelay(40);
> >> +			}
> >>  			sdhci_data_irq(host, intmask & SDHCI_INT_DATA_MASK);
> >> +		}
> >>
> >>  		if (intmask & SDHCI_INT_BUS_POWER)
> >>  			pr_err("%s: Card is consuming too much power!\n",
> >> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> >> index c055e24..5f8301e 100644
> >> --- a/drivers/mmc/host/sdhci.h
> >> +++ b/drivers/mmc/host/sdhci.h
> >> @@ -24,6 +24,8 @@
> >>   * Controller registers
> >>   */
> >>
> >> +#define SDHCI_QUIRK2_SLOW_INT_CLR	(1<<5)  
> >
> > IIRC, new quirk isn't allowed now.
> >  
> 
> Why not?

IIRC, mmc subsystem will behave as a lib in the long run, so the community
and developers call for no new quirk. For your case, we may need to handle
the udelay in sdhci-msm.c, export sdhci_irq as a helper function?

Thanks
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
