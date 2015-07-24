From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: Re: [PATCH v2] mmc: sunxi: Don't start commands
 while the card is busy
Date: Fri, 24 Jul 2015 10:26:53 +0200
Message-ID: <20150724082653.GB2564@lukather>
References: <1436541284-11800-1-git-send-email-hdegoede@redhat.com>
 <20150720080007.GR28632@lukather>
 <55AD1278.3060308@redhat.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBCXPY6WQKGQEPYD2HJQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55AD1278.3060308-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Eugene K <sigintmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, Jul 20, 2015 at 05:23:36PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 20-07-15 10:00, Maxime Ripard wrote:
> >Hi,
> >
> >On Fri, Jul 10, 2015 at 05:14:44PM +0200, Hans de Goede wrote:
> >>Some sdio wifi modules have not been working reliable with the sunxi-mmc
> >>host code. This turns out to be caused by it starting new commands while
> >>the card signals that it is still busy processing a previous command.
> >>
> >>This commit fixes this, thereby fixing the wifi reliability issues on
> >>the Cubietruck and other sunxi boards using sdio wifi.
> >>
> >>Reported-by: Eugene K <sigintmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>Suggested-by: Eugene K <sigintmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>Cc: Eugene K <sigintmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >
> >You should use the "real" name here, and not some shortening.
> 
> I don't know the real name, and AFAIK this is really only important
> for S-o-b lines.

This is mandatory only for SoB, but it's pointless to have it in the
other tags. This is to identify the developper that sets these tags,
and we can't do that without a full name.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--TakKZr9L6Hm6aLOc--
