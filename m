From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/5] drivercore: add new error value for deferred probe
Date: Wed, 12 Oct 2011 22:10:14 -0600
Message-ID: <20111013041014.GF15829@ponder.secretlab.ca>
References: <1317963790-29426-1-git-send-email-manjugk@ti.com>
 <1317963790-29426-2-git-send-email-manjugk@ti.com>
 <20111007064349.GD27508@kroah.com>
 <CACxGe6uOmrLwJSPw4JHuOmt5B2wsukdDgVUr01pryq5Z9BFadw@mail.gmail.com>
 <32004.1318030113@turing-police.cc.vt.edu>
 <20111008001237.GA30551@kroah.com>
 <CACxGe6t+PfnNGniYUj3pbK22uqjqkbh2+D=7qvvd_-Yd4yR0dw@mail.gmail.com>
 <20111010010656.GA16537@kroah.com>
 <20111012061823.GB2080@manju-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37780 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab1JMEKS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2011 00:10:18 -0400
Content-Disposition: inline
In-Reply-To: <20111012061823.GB2080@manju-desktop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Greg KH <greg@kroah.com>, Valdis.Kletnieks@vt.edu, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Dilan Lee <dilee@nvidia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Manjunath GKondaiah <manjunath.gkondaiah@linaro.org>, Arnd Bergmann <arnd@arndb.de>

On Wed, Oct 12, 2011 at 11:48:23AM +0530, G, Manjunath Kondaiah wrote:
> On Sun, Oct 09, 2011 at 06:06:56PM -0700, Greg KH wrote:
> > On Sun, Oct 09, 2011 at 04:59:31PM -0600, Grant Likely wrote:
> > > On Fri, Oct 7, 2011 at 6:12 PM, Greg KH <greg@kroah.com> wrote:
> > > > On Fri, Oct 07, 2011 at 07:28:33PM -0400, Valdis.Kletnieks@vt.e=
du wrote:
> > > >> On Fri, 07 Oct 2011 16:12:45 MDT, Grant Likely said:
> > > >> > On Fri, Oct 7, 2011 at 12:43 AM, Greg KH <greg@kroah.com> wr=
ote:
> > > >> > > On Fri, Oct 07, 2011 at 10:33:06AM +0500, G, Manjunath Kon=
daiah wrote:
> > > >>
> > > >> > >> +#define EPROBE_DEFER 517 =A0 =A0 /* restart probe again =
after some time */
> > > >> > >
> > > >> > > Can we really do this?
> > > >>
> > > >> > According to Arnd, yes this is okay.
> > > >>
> > > >> > > =A0Isn't this some user/kernel api here?
> > > >>
> > > >> > > What's wrong with just "overloading" on top of an existing=
 error code?
> > > >> > > Surely one of the other 516 types could be used here, righ=
t?
> > > >>
> > > >> > overloading makes it really hard to find the users at a late=
r date.
> > > >>
> > > >> Would proposing '#define EPROBE_DEFER EAGAIN' be acceptable to=
 everybody? That
> > > >> would allow overloading EAGAIN, but still make it easy to tell=
 the usages apart
> > > >> if we need to separate them later...
> > > >
> > > > Yes, please do that, it is what USB does for it's internal erro=
r code
> > > > handling.
> > >=20
> > > Really?  When we've only currently used approximately 2^9 of a 2^=
31
> > > numberspace?  I'm fine with making sure that the number doesn't s=
how
> > > up in the userspace headers, but it makes no sense to overload th=
e
> > > #defines.  Particularly so in this case where it isn't feasible t=
o
> > > audit every driver to figure out what probe might possibly return=
=2E  It
> > > is well within the realm of possibility that existing drivers are
> > > already returning -EAGAIN.
> >=20
> > I doubt they are, but you are right, it's really hard to tell.
> >=20
> > > Besides; linux/errno.h *already* has linux-internal error codes t=
hat
> > > do not get exported out to userspace.  There is an #ifdef __KERNE=
L__
> > > block around ERESTARTSYS through EIOCBRETRY which is filtered out=
 when
> > > exporting headers.  I can't see any possible reason why we wouldn=
't
> > > add Linux internal error codes here.
> >=20
> > As long as it stays internal, that's fine, I was worried that this =
would
> > be exported to userspace.
> >=20
> > Alan, still object to this?
>=20
> I hope no one has objections to use EPROBE_DEFER

I say go with that value.  If Alan still objects, then he will speak up=
=2E

g.
