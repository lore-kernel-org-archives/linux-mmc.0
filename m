From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH] powerpc/esdhc: enable the card insert/remove interrupt
Date: Thu, 25 Oct 2012 03:30:38 -0700
Message-ID: <20121025103038.GA5107@lizard>
References: <1350975677-8195-1-git-send-email-r66093@freescale.com>
 <20121023082648.GA21690@lizard>
 <110EED8CC96DFC488B7E717A2027A27C1C68D9@039-SN1MPN1-003.039d.mgd.msft.net>
 <110EED8CC96DFC488B7E717A2027A27C1D7A42@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62917 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738Ab2JYKdm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Oct 2012 06:33:42 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1913079pbb.19
        for <linux-mmc@vger.kernel.org>; Thu, 25 Oct 2012 03:33:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C1D7A42@039-SN1MPN1-003.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kumar Gala <galak@kernel.crashing.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>

On Thu, Oct 25, 2012 at 10:05:44AM +0000, Huang Changming-R66093 wrote:
> Hi, Anton.
> Could you have any comment about it?
> If not, I will resend this patch with v2.

Technically, the patch looks fine.

But again, as far as I recall, the card detection logic was broken on the
SOC level (it's actually very hard to break it on the board level -- it
would either work or not, but in the eSDHC case it was just unreliable,
again, if I recall everything correctly -- I might be wrong).

Of course you know the hardware much better, so your words weight more, so
you don't need my ack on the patch. :)

Although there's a second issue: for P4080DS and mpc837x boards you still
have the same problem with polling method, right? It is causing
performance drops/freezes every like 100 ms, and that's why you want to
avoid the polling.

So, you've "fixed" some boards, but left others to suffer. Ideally, the
best fix would be to also make the card polling cheap.

Anyways, using (d) clause of the "Reviewer's statement of oversight", I
can easily give this:

	Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>

:)

Thanks!

[...]
> > > IIRC, the card detection is broken SOC-revision-wise, not board-wise.
> > > So the change seems wrong.
> > >
> > > Also, take a look at this:
> > >
> > > 	http://lkml.org/lkml/2010/7/14/127
> > >
> > > I started the work but never finished, unfortunately it caused some
> > > regressions for non-FSL hardware...
> > >
> > > >  drivers/mmc/host/sdhci-of-esdhc.c |    7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/mmc/host/sdhci-of-esdhc.c
> > > > b/drivers/mmc/host/sdhci-of-esdhc.c
> > > > index ffc1226..5dc362f 100644
> > > > --- a/drivers/mmc/host/sdhci-of-esdhc.c
> > > > +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> > > > @@ -196,6 +196,11 @@ static void esdhc_of_detect_limitation(struct
> > > platform_device *pdev,
> > > >  	if (vvn == VENDOR_V_22)
> > > >  		pdata->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
> > > >
> > > > +	/* P4080DS and MPC837XMDS board don't support interrupt mode */
> > > > +	if (of_machine_is_compatible("fsl,mpc837xmds") ||
> > > > +	    of_machine_is_compatible("fsl,P4080DS"))
> > > > +		pdata->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> > > > +
> > > >  	iounmap(ioaddr);
> > > >  end:
> > > >  	return;
> > > > @@ -223,7 +228,7 @@ static struct sdhci_pltfm_data sdhci_esdhc_pdata
> > > > =
> > > {
> > > >  	 * card detection could be handled via GPIO
> > > >  	 * eSDHC cannot support End Attribute in NOP ADMA descriptor
> > > >  	 */
> > > > -	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_CARD_DETECTION
> > > > +	.quirks = ESDHC_DEFAULT_QUIRKS
> > > >  		| SDHCI_QUIRK_NO_CARD_NO_RESET
> > > >  		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> > > >  	.ops = &sdhci_esdhc_ops,
> > > > --
> > > > 1.7.9.5
