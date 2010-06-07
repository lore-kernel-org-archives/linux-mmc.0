From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 2/2] mmc: fix mmc card disappearence on resume on ricoh
 mmc controllers
Date: Mon, 07 Jun 2010 03:33:15 +0300
Message-ID: <1275870795.24091.4.camel@maxim-laptop>
References: <1275859475.3151.4.camel@maxim-laptop>
	 <1275859731-2898-2-git-send-email-maximlevitsky@gmail.com>
	 <20100606232313.GA5444@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100606232313.GA5444@void.printf.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Philip Langdale <philipl@overt.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 2010-06-07 at 00:23 +0100, Chris Ball wrote: 
> Hi,
> 
> On Mon, Jun 07, 2010 at 12:28:51AM +0300, Maxim Levitsky wrote:
> > +	/* Some controllers (especialy the ricoh mmc controller) delay
> > +		card detection on resume (probably since the controller
> > +		has to poke the card to determine if its MMC or not */
> > +
> > +	if (host->mmc->bus_ops && (host->quirks &
> > +			SDHCI_QUIRK_WAIT_CARD_ON_RESUME)) {
> > +
> > +		unsigned long timeout = jiffies + msecs_to_jiffies(2000);
> > +
> > +		while (!time_after(jiffies, timeout))
> > +			if (sdhci_readl(host, SDHCI_PRESENT_STATE)
> > +							& SDHCI_CARD_PRESENT) {
> > +				break;
> 
> It looks like your editor is set to four-space instead of eight-space
> tab characters, else you wouldn't be using so many tabs here. 
Nope, I think indention is right here.

the break is inside 'if' condition.

Best regards
Maxim Levitsky
