From: CaT <cat@zip.com.au>
Subject: Re: SDHCI regression since 2.6.39
Date: Thu, 3 Nov 2011 23:53:54 +1100
Message-ID: <20111103125354.GZ3428@zip.com.au>
References: <4E6FCE28.5040403@goop.org>
 <F54ECF19-5E4C-40A6-8E26-99BF223F9FE2@marvell.com>
 <4E6FDA0B.9060007@goop.org>
 <4E6FDC3E.8030702@goop.org>
 <003A4041-99F9-4598-AB9A-D08C76CDAECB@marvell.com>
 <4E6FFADE.5090004@goop.org>
 <m2k49b9qvu.fsf@bob.laptop.org>
 <4E70D62B.2030007@goop.org>
 <m2boun9dg1.fsf@bob.laptop.org>
 <4E710660.1060101@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4E710660.1060101@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Ball <cjb@laptop.org>, Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Manoj Iyer <manoj.iyer@canonical.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Sep 14, 2011 at 12:54:08PM -0700, Jeremy Fitzhardinge wrote:

Ok. Thread is a bit dated but the bug is the same by the looks of it.
Apologies to anyone hit by the funk of a thousand years. :)

> On 09/14/2011 11:38 AM, Chris Ball wrote:
> > It could indeed be some kind of signal integrity issue.  The easy way to
> > investigate that would be to boot Windows and see if it works there, and
> > the hard way would be to find a friendly hardware hacker with a nice scope.
> 
> I have the original HDD with Windows on it around here somewhere; when I
> get the chance I'll switch them around and see what Windows thinks of it
> (I guess if its still failing then its a warranty fix).

I have an X220 with the same issue. Using a MicroSDHC card with an adapter.

Windows likes it, Linux does not. Very similar looking errors as what Jeremy
has.

Linux: 3.1
BIOS: 1.21 (08/02/2011)
OS: Debian Wheezy

SanDisk adapter with Kingston 4GB MicroSDHC card.

I could help with any testing.

-- 
  "A search of his car uncovered pornography, a homemade sex aid, women's 
  stockings and a Jack Russell terrier."
    - http://www.dailytelegraph.com.au/news/wacky/indeed/story-e6frev20-1111118083480
