From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH 02/12] mmc: sd: add support for signal voltage switch
 procedure
Date: Wed, 16 Feb 2011 02:08:45 -0600
Message-ID: <6C03668EAF45B747AF947A1603D1B300DCDEF800@SAUSEXMBP01.amd.com>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
 <1297762510-2696-3-git-send-email-arindam.nath@amd.com>
 <alpine.LFD.2.00.1102151604410.14920@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:32437
	"EHLO VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752234Ab1BPII7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Feb 2011 03:08:59 -0500
In-Reply-To: <alpine.LFD.2.00.1102151604410.14920@xanadu.home>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>

> -----Original Message-----
> From: Nicolas Pitre [mailto:nico@fluxnic.net]
> Sent: Wednesday, February 16, 2011 2:48 AM
> To: Nath, Arindam
> Cc: cjb@laptop.org; linux-mmc@vger.kernel.org; Su, Henry; Lu, Aaron;
> anath.amd@gmail.com
> Subject: Re: [PATCH 02/12] mmc: sd: add support for signal voltage
> switch procedure
> 
> On Tue, 15 Feb 2011, Arindam Nath wrote:
> 
> > @@ -1340,11 +1342,76 @@ out:
> >  	spin_unlock_irqrestore(&host->lock, flags);
> >  }
> >
> > +static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc)
> > +{
> > +	struct sdhci_host *host;
> > +	u8 pwr;
> > +	u16 clk, ctrl;
> > +	u32 present_state;
> > +	unsigned long flags;
> > +
> > +	host = mmc_priv(mmc);
> > +
> > +	spin_lock_irqsave(&host->lock, flags);
> > +
> > +	/* Stop SDCLK */
> > +	host = mmc_priv(mmc);
> > +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +	clk &= ~SDHCI_CLOCK_CARD_EN;
> > +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > +
> > +	/* Check whether DAT[3:0] is 0000 */
> > +	present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
> > +	if (!((present_state & SDHCI_DATA_LVL_MASK) >>
> SDHCI_DATA_LVL_SHIFT)) {
> > +		/* Enable 1.8V Signal Enable in the Host Control2 register
> */
> > +		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > +		ctrl |= SDHCI_CTRL_VDD_180;
> > +		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> > +
> > +		/* Wait for 5ms */
> > +		mdelay(5);
> 
> You're busy-waiting for 5 ms while holding a spinlock and with
> interrupts masked off.  This is totally unacceptable.
> 
> There shouldn't be any other concurrent access to the controller here
> as
> the
> core code should have claimed the host through mmc_claim_host(), if not
> this is a bug.  So if the only thing you're worried about is some sdhci
> specific interrupts then simply mask interrupts at the controller
> level,
> do your business including this 5 ms delay using msleep() and _not_
> mdelay(), and unmask them afterwards.  If this is called in a non
> sleepable context then please make it so.

Yes, it makes sense. I will use msleep() instead of mdelay() and the changes will reflect in V2 of the patchset.

Regards,
Arindam

