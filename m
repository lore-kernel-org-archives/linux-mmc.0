From: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/5] mmc: sdhci-pltfm: Do not use parent as the host's
 device
Date: Mon, 11 Aug 2014 10:15:50 +0100
Message-ID: <1407748550.3680.10.camel@hornet>
References: <1406298233-27876-1-git-send-email-pawel.moll@arm.com>
	 <1406298233-27876-3-git-send-email-pawel.moll@arm.com>
	 <1407515785.31897.28.camel@hornet>
	 <CAPDyKFoLU6pnJFmKe7CB0q-hKfwv4uCPSr0cE4aoYMvfhjMteQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFoLU6pnJFmKe7CB0q-hKfwv4uCPSr0cE4aoYMvfhjMteQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Anton Vorontsov <anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org" <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 2014-08-11 at 10:07 +0100, Ulf Hansson wrote:
> On 8 August 2014 18:36, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org> wrote:
> > On Fri, 2014-07-25 at 15:23 +0100, Pawel Moll wrote:
> >> The code selecting a device for the sdhci host has been
> >> continuously tweaked (4b711cb13843f5082e82970dd1e8031383134a65
> >> "mmc: sdhci-pltfm: Add structure for host-specific data" and
> >> a4d2177f00a5252d825236c5124bc1e9918bdb41 "mmc: sdhci-pltfm: dt
> >> device does not pass parent to sdhci_alloc_host") while there
> >> does not seem to be any reason to use platform device's parent
> >> in the first place.
> >>
> >> The comment saying "Some PCI-based MFD need the parent here"
> >> seem to refer to Timberdale FPGA driver (the only MFD driver
> >> registering SDHCI cell, drivers/mfd/timberdale.c) but again,
> >> the only situation when parent device matter is runtime PM,
> >> which is not implemented for Timberdale.
> >>
> >> Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>
> >> Cc: Anton Vorontsov <anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org>
> >> Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >> Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >> Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> >> Signed-off-by: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
> >> ---
> >>
> >> This patch is a part of effort to remove references to platform_bus
> >> and make it static.
> >>
> >> Chris, Anton, Ulf - could you please advise if the assumptions
> >> above are correct or if I'm completely wrong? Do you know what
> >> where the real reasons to use parent originally? The PCI comment
> >> seems like a red herring to me...
> >
> > Can I take the silence as a suggestion that the change looks ok-ish for
> > you?
> 
> Sorry for the delay. I suppose this make sense, but I really don't
> know for sure.
> 
> I guess we need some testing in linux-next, to get some confidence.

Would you take it into -next then? Unless I'm completely wrong there
should be no impact on any in-tree driver...

Cheers!

Pawel
