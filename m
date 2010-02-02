From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] sdhci: add adma descriptor set call
Date: Tue, 2 Feb 2010 09:30:31 +0000
Message-ID: <20100202093031.GA24864@trinity.fluff.org>
References: <1264656597-19965-1-git-send-email-ben-linux@fluff.org> <1264656597-19965-2-git-send-email-ben-linux@fluff.org> <20100129152035.e04678a7.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100129152035.e04678a7.akpm@linux-foundation.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-samsung-soc@vger.kernel.org, pierre@ossman.eu, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 29, 2010 at 03:20:35PM -0800, Andrew Morton wrote:
> On Thu, 28 Jan 2010 05:29:56 +0000
> Ben Dooks <ben-linux@fluff.org> wrote:
> 
> > The code to write the ADMA descriptor into memory is repeated several
> > times throughout sdhci_adma_table_pre, and thus should be moved into a
> > common function. This will also be useful if the patch to make the write
> > more efficient is accepted.
> > 
> > ...
> >
> > @@ -499,15 +496,9 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
> >  		/*
> >  		* Add a terminating entry.
> >  		*/
> > -		desc[7] = 0;
> > -		desc[6] = 0;
> > -		desc[5] = 0;
> > -		desc[4] = 0;
> > -
> > -		desc[3] = 0;
> > -		desc[2] = 0;
> > -		desc[1] = 0x00;
> > -		desc[0] = 0x03; /* nop, end, valid */
> > +
> > +		/* nop, end, valid */
> > +		sdhci_set_adma_desc(desc, 0, 0, 0x3);
> >  	}
> 
> What kernel are you patching?  Current mainline is different from the above.

This follows Thomas Abraham's ADMA end fixup quirk.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
