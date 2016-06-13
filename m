From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC v4 01/14] regulator: of: Add helper for getting all supplies
Date: Mon, 13 Jun 2016 11:44:16 +0800
Message-ID: <20160613034416.GD32615@shlinux2>
References: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
 <1465465471-28740-2-git-send-email-k.kozlowski@samsung.com>
 <20160609102925.GS7510@sirena.org.uk>
 <5759560A.70107@samsung.com>
 <20160610173056.GA16503@rob-hp-laptop>
 <20160612072901.GD22054@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160612072901.GD22054@shlinux2>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-fy+rA21nqHI@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Sun, Jun 12, 2016 at 03:29:01PM +0800, Peter Chen wrote:
> On Fri, Jun 10, 2016 at 12:30:56PM -0500, Rob Herring wrote:
> > On Thu, Jun 09, 2016 at 01:42:02PM +0200, Krzysztof Kozlowski wrote:
> > > On 06/09/2016 12:29 PM, Mark Brown wrote:
> > > > On Thu, Jun 09, 2016 at 11:44:18AM +0200, Krzysztof Kozlowski wrote:
> > > >> Few drivers have a need of getting regulator supplies without knowing
> > > >> their names:
> > > >> 1. The Simple Framebuffer driver works on setup provided by bootloader
> > > >>    (outside of scope of kernel);
> > > >> 2. Generic power sequence driver may be attached to any device node.
> > > >>
> > > >> Add a Device Tree helper for parsing "-supply" properties and returning
> > > >> allocated bulk regulator consumers.
> > > > 
> > > > I'm still very concerned that this is just an invitation to people to
> > > > write half baked regulator consumers and half baked DTs to go along with
> > > > it, making it a standard API that doesn't have big red flags on it that
> > > > will flag up when "normal" drivers use it is not good.  Right now this
> > > > just looks like a standard API and people are going to just start using
> > > > it.  If we are going to do this perhaps we need a separate header or
> > > > something to help flag this up.
> > > 
> > > No problem, I can move it to a special header.  Actually, if you dislike
> > > this as an API, it does not have to be in header at all.  I can just
> > > duplicate the simplefb code.
> > > 
> > > > In the case of power sequences I'd expect the sequences to perform
> > > > operations on named supplies - the core shouldn't know what the supplies
> > > > are but the thing specifying the sequence should.
> > > 
> > > Hm, so maybe passing names like:
> > > 
> > > usb3503@08 {
> > > 	reset-gpios = <&gpx3 5 GPIO_ACTIVE_HIGH>;
> > > 	initial-mode = <1>;
> > > 	vdd-supply = <&buck8_reg>;
> > > 	foo-supply = <&buck9_reg>;
> > > 
> > >         power-sequence;
> > > 	power-sequence-supplies = "vdd", "foo";
> > 
> > This alone would be fine as it is just one property, but then what's 
> > next? power-sequence-delay, power-sequence-clocks, etc. What if you 
> > need to express ordering relationship of supplies, clocks, gpios? We end 
> > up with a scripting language in DT and we don't want to have that.
> > 
> 
> Can we do things like below:
> 
> - DT describes hardware elements (clock, gpios, etc) for power sequence, and we
> need a node for power sequence.
> - Power sequence framework handles getting hardware elements.

Framework may do few things, since hardware elements are also different
for devices.

> - Power sequence platform driver handles special sequence for devices,
> and we can create some generic drivers for generic devices.
> 

So, my suggestion is do like mmc does (like this patch set does). The
reasons like belows:

- This piece of power sequence code needs to work like device driver, not
library, it is easy to manage resources using device driver.
- The device on the bus has still not been found, so this piece of code
can't be in device driver on each subsystem.
- We need to have a place for these power sequences drivers

Ideally, I hope it can work like regulator class, but it seems hard to
compatible with current mmc-pwrseq DT node.

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
