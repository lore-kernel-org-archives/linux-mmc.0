From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6] mmc: Add mmc CMD+ACMD passthrough ioctl
Date: Thu, 21 Apr 2011 12:47:35 +0200
Message-ID: <201104211247.35903.arnd@arndb.de>
References: <alpine.DEB.2.00.1104131713570.15392@peruna> <alpine.DEB.2.00.1104201011230.28189@peruna> <m3wrioesql.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:54947 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514Ab1DUKsU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 06:48:20 -0400
In-Reply-To: <m3wrioesql.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: John Calixto <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>, =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirqus@gmail.com>

On Wednesday 20 April 2011, Chris Ball wrote:
> On Wed, Apr 20 2011, John Calixto wrote:
> > Have you had the chance to look at v6 of this patch?  If so, what do you
> > think?
> 
> Looks good to me.  Since Arnd's been reviewing, it'd be nice to get a
> Reviewed-by: tag from him and acknowledgement that his concerns are all
> addressed, and then I'll merge it.

Once the pointer passing is worked out, I think we have basically resolved
the technical issues. One more thing that I just noticed: The 
__u64 data_ptr needs to be aligned, otherwise you get a problem
on x86, which uses different alignment for 64 bit members in structures
between 32 and 64 bit ABIs. Putting the 64 bit members first in the data
structure, and adding padding at the end to have a size that is a multiple
of 8 bytes should take care of this.

I don't quite understand the timeout stuff in there, so I'm not sure how
I'd fill these from an application like qemu that blindly passes down
commands. I'd feel more comfortable if we didn't have to specify these
in the interface, but I have no strict objection if you think that passing
those is a reasonable requirement.

The more important question that is still unresolved however is the
nontechnical one:

Do we want users to use this interface for DRM applications?

I would still prefer having a more high-level interface for this, ideally
something where we just export a block device for the encrypted partition,
with an ioctl interface to do the authentication. Alternatively, I could
imagine an ioctl interface that exports each SD security command as a
separate ioctl command, including the block read/write ones.

The information to do this seems to be available in
http://issuu.com/sravan/docs/sd_card, which describes the ACMDs.
It shouldn't be too hard to implement them in a high-level API.
What I don't know is whether we have a clear policy about implementing
SD standard interfaces in the kernel that are not part of the redacted
specs.

	Arnd
