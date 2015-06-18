From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 5/7] samples: kdbus: disable for mn10300
Date: Thu, 18 Jun 2015 21:49:05 +0530
Message-ID: <20150618161905.GB21198@sudip-PC>
References: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1434629873-11668-6-git-send-email-sudipm.mukherjee@gmail.com>
 <20150618143958.GA8830@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150618143958.GA8830-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-am33-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Jun 18, 2015 at 07:39:58AM -0700, Greg Kroah-Hartman wrote:
> On Thu, Jun 18, 2015 at 05:47:51PM +0530, Sudip Mukherjee wrote:
> > While building it failed with:
> > In function 'prime_new':
> > error: '__NR_memfd_create' undeclared (first use in this function)
> > 
> > memfd_create syscall has not yet been implemented for mn10300.
> > so disable compilation of samples/kdbus for now with mn10300.
> > 
> > Signed-off-by: Sudip Mukherjee <sudip-ofJRbWXBVFamYgehrs7/Lw@public.gmane.org>
> > ---
> >  samples/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/samples/Kconfig b/samples/Kconfig
> > index a4c6b2f..20c55af 100644
> > --- a/samples/Kconfig
> > +++ b/samples/Kconfig
> > @@ -57,7 +57,7 @@ config SAMPLE_KDB
> >  
> >  config SAMPLE_KDBUS
> >  	bool "Build kdbus API example"
> > -	depends on KDBUS
> > +	depends on KDBUS && !MN10300
> 
> Why not just add the memfd syscall to this arch?
Yes, I intend to. But for now this will fix allmodconfig.
>I thought someone had already sent such a patch in a while ago.
Then it is still not merged. :(
I will try to find that patch adding memfd syscall. And if i find it whom
shall I forward it to?

regards
sudip
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
