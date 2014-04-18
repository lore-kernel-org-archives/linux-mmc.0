From: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/4] mmc: sdhci: add a driver for Berlin SoCs
Date: Fri, 18 Apr 2014 14:06:39 +0800
Message-ID: <20140418140639.03c450f3@xhacker>
References: <1397652011-21284-1-git-send-email-antoine.tenart@free-electrons.com>
	<1397652011-21284-2-git-send-email-antoine.tenart@free-electrons.com>
	<534E92FE.8010400@gmail.com>
	<20140417133359.GB31034@kwain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140417133359.GB31034@kwain>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Antoine =?UTF-8?B?VMOpbmFydA==?= <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org" <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, "anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org" <anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org>, "alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jimmy Xu <zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, 17 Apr 2014 06:33:59 -0700
Antoine T=C3=A9nart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> Sebastian,
>=20
> On Wed, Apr 16, 2014 at 04:26:06PM +0200, Sebastian Hesselbarth wrote=
:
> > On 04/16/2014 02:40 PM, Antoine T=C3=A9nart wrote:
> > >Add a Driver to support the SDHCI controller of the Marvell Berlin=
 SoCs.
> > >This controller supports 3 sockets.
> >=20
> > nit: Isn't it three controller with one socket each?
>=20
> It's a little bit confusing, there are 3 different register regions a=
nd
> I can see 3 separate data lines but, I quote: "The SD host controller
> supports three sockets".
>=20
> Maybe Jisheng can advise on that matter ?


It's three controller with one socket each ;)

Thanks
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
