From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: Applied "regulator: pbias: Select voltage table based on
 max-voltage" to the regulator tree
Date: Mon, 4 Sep 2017 11:16:54 +0530
Message-ID: <f50319d6-9b18-0538-4eb1-6ff4226cac02@ti.com>
References: <E1dnO3z-0000tI-7K@debutante>
 <64d9c623-456c-9142-9c5b-a94593628643@ti.com>
 <20170831135050.adiek6iqqzhndgci@sirena.org.uk>
 <CAPDyKFo=UdnVhFU7k+K1=N0e-1sniC+WZjZ4dZKSF8mXhM43Uw@mail.gmail.com>
 <20170901162322.xrjnim4khn3wfslj@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170901162322.xrjnim4khn3wfslj-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Ravikumar Kattekola <rk-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Mark,

On Friday 01 September 2017 09:53 PM, Mark Brown wrote:
> On Fri, Sep 01, 2017 at 03:18:03PM +0200, Ulf Hansson wrote:
>> On 31 August 2017 at 15:50, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>> On Thu, Aug 31, 2017 at 05:37:34PM +0530, Kishon Vijay Abraham I wrote:
> 
>>>> This patch should be merged along with the 1st patch of the series "mmc: host:
>>>> omap_hsmmc: Remove setting PBIAS voltage". Or else it'll break MMC with
>>>> omap_hsmmc driver.
> 
> Hang on, how can this break anything?  If it breaks things shouldn't
> there be bugfixes for incorrect constraints somewhere?

omap_hsmmc sets the pbias voltage to 3V. But here we program the volt table to
support either 1.8V or 3.3V (Initially the volt table was programmed to support
3V because of a bug in TRM). So set_voltage of pbias voltage in omap_hsmmc will
fail.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
