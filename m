From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH V2 2/4] mmc: pwrseq: Document DT bindings for the simple
 MMC power sequence
Date: Fri, 16 Jan 2015 11:36:46 +0000
Message-ID: <20150116113646.GH12302@n2100.arm.linux.org.uk>
References: <1421240530-7971-1-git-send-email-ulf.hansson@linaro.org>
 <1421240530-7971-3-git-send-email-ulf.hansson@linaro.org>
 <20150115165825.GL16217@leverpostej>
 <20150116075308.3f4e250a@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150116075308.3f4e250a-wvvUuzkyo1EYVZTmpyfIwg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 16, 2015 at 07:53:08AM +1300, NeilBrown wrote:
> Also, it isn't clear to me whether the need for power/reset is a function of
> the mmc-host, or a function of the device attached to the host.  I suspect
> some are needed by one, some by the other.  Any by both?

Neil,

There's a horrid issue there.  The standard model of MMC/SD is that the
device will be powered up by the host, and will then be probed to find
out what the device is.  This normally works fine as the host is
responsible for controlling the power to the socket which the card is
plugged into.

Where things fall down is when you have a MMC/SD device embedded onto
a board, and they decide that it'll be given separate controls for
power and reset which are not under the control of the host.

If the MMC/SD device is not powered up before we probe the bus, then
the device is not discoverable, and this breaks the standard model:
- If we run the standard MMC/SD device discovery code with the device
  powered down, it will find no device attached, so no device will be
  created.

- If we create a device, then the device driver will be probed
  immediately.  While the device driver can then bind, discover the
  power and reset controls, and activate them, it can't then talk to
  its device because the MMC layer hasn't gone through the required
  standard device discovery and probe sequence.  If we could do that,
  we would then need some way to stop that mechanism creating another
  device.

If we instead take the view that the host is responsible for powering
up the device, then we are merely keeping with the standard MMC/SD
model, and we don't have to hack around his.

Keeping to the standard model of a host responsible for power control
of its child devices is just a whole lot nicer.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
