From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 3/4 v5] SDHCI: add sdhci_get_cd callback to detect the
 card
Date: Sun, 18 Nov 2012 19:31:01 -0800
Message-ID: <20121119033101.GA17901@lizard>
References: <1351584769-16662-1-git-send-email-r66093@freescale.com>
 <1351584769-16662-2-git-send-email-r66093@freescale.com>
 <1351584769-16662-3-git-send-email-r66093@freescale.com>
 <110EED8CC96DFC488B7E717A2027A27C224F8F@039-SN1MPN1-004.039d.mgd.msft.net>
 <20121119025816.GB5165@lizard>
 <110EED8CC96DFC488B7E717A2027A27C22503C@039-SN1MPN1-004.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:64522 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556Ab2KSDeQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Nov 2012 22:34:16 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so124543pad.19
        for <linux-mmc@vger.kernel.org>; Sun, 18 Nov 2012 19:34:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C22503C@039-SN1MPN1-004.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Mon, Nov 19, 2012 at 03:15:53AM +0000, Huang Changming-R66093 wrote:
[...]
> > > > @@ -1573,6 +1573,26 @@ static int sdhci_get_ro(struct mmc_host *mmc)
> > > >  	return ret;
> > > >  }
> > > >
> > > > +/* Return values for the sdjco_get_cd callback:
> > > > + *   0 for a absent card
> > > > + *   1 for a present card
> > > > + *   -ENOSYS when not supported (equal to NULL callback)
> > > > + */
> > 
> > Incorrect style.
> Hi, Anton, you mean the comment style is incrorrect?
> It should be:
> /*
>  * xxxxx
>  * xxxxxx
>  */

Yup.

> 
> > > > +static int sdhci_get_cd(struct mmc_host *mmc) {
> > 
> > ditto
> I don't see the issue, could you explain it?

The issue is in the brace placement. It should be

static int sdhci_get_cd(struct mmc_host *mmc)
{
	...
}

Please refer to Documentation/CodingStyle -- it's a great document.

Thanks,
Anton.
