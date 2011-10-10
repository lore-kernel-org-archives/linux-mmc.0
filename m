From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/5] drivercore: add new error value for deferred probe
Date: Sun, 9 Oct 2011 18:06:56 -0700
Message-ID: <20111010010656.GA16537@kroah.com>
References: <1317963790-29426-1-git-send-email-manjugk@ti.com>
	<1317963790-29426-2-git-send-email-manjugk@ti.com>
	<20111007064349.GD27508@kroah.com>
	<CACxGe6uOmrLwJSPw4JHuOmt5B2wsukdDgVUr01pryq5Z9BFadw@mail.gmail.com>
	<32004.1318030113@turing-police.cc.vt.edu>
	<20111008001237.GA30551@kroah.com>
	<CACxGe6t+PfnNGniYUj3pbK22uqjqkbh2+D=7qvvd_-Yd4yR0dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CACxGe6t+PfnNGniYUj3pbK22uqjqkbh2+D=7qvvd_-Yd4yR0dw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Dilan Lee <dilee@nvidia.com>, Valdis.Kletnieks@vt.edu, Arnd Bergmann <arnd@arndb.de>, "G, Manjunath Kondaiah" <manjugk@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Manjunath GKondaiah <manjunath.gkondaiah@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Sun, Oct 09, 2011 at 04:59:31PM -0600, Grant Likely wrote:
> On Fri, Oct 7, 2011 at 6:12 PM, Greg KH <greg@kroah.com> wrote:
> > On Fri, Oct 07, 2011 at 07:28:33PM -0400, Valdis.Kletnieks@vt.edu wrote:
> >> On Fri, 07 Oct 2011 16:12:45 MDT, Grant Likely said:
> >> > On Fri, Oct 7, 2011 at 12:43 AM, Greg KH <greg@kroah.com> wrote:
> >> > > On Fri, Oct 07, 2011 at 10:33:06AM +0500, G, Manjunath Kondaiah wr=
ote:
> >>
> >> > >> +#define EPROBE_DEFER 517 =A0 =A0 /* restart probe again after so=
me time */
> >> > >
> >> > > Can we really do this?
> >>
> >> > According to Arnd, yes this is okay.
> >>
> >> > > =A0Isn't this some user/kernel api here?
> >>
> >> > > What's wrong with just "overloading" on top of an existing error c=
ode?
> >> > > Surely one of the other 516 types could be used here, right?
> >>
> >> > overloading makes it really hard to find the users at a later date.
> >>
> >> Would proposing '#define EPROBE_DEFER EAGAIN' be acceptable to everybo=
dy? That
> >> would allow overloading EAGAIN, but still make it easy to tell the usa=
ges apart
> >> if we need to separate them later...
> >
> > Yes, please do that, it is what USB does for it's internal error code
> > handling.
> =

> Really?  When we've only currently used approximately 2^9 of a 2^31
> numberspace?  I'm fine with making sure that the number doesn't show
> up in the userspace headers, but it makes no sense to overload the
> #defines.  Particularly so in this case where it isn't feasible to
> audit every driver to figure out what probe might possibly return.  It
> is well within the realm of possibility that existing drivers are
> already returning -EAGAIN.

I doubt they are, but you are right, it's really hard to tell.

> Besides; linux/errno.h *already* has linux-internal error codes that
> do not get exported out to userspace.  There is an #ifdef __KERNEL__
> block around ERESTARTSYS through EIOCBRETRY which is filtered out when
> exporting headers.  I can't see any possible reason why we wouldn't
> add Linux internal error codes here.

As long as it stays internal, that's fine, I was worried that this would
be exported to userspace.

Alan, still object to this?

greg k-h
