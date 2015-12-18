From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: SDHCI long sleep with interrupts off
Date: Fri, 18 Dec 2015 20:09:34 +0000
Message-ID: <20151218200934.GR8644@n2100.arm.linux.org.uk>
References: <20151217112814.6250a3b9@archvile>
 <1450350190.3163.93.camel@pengutronix.de>
 <20151217122053.036daf37@archvile>
 <1450351655.3163.97.camel@pengutronix.de>
 <CAPDyKFosBeyP3YYXz-1uyiqoaLuMQj3+ojzpt1-QY7JU9epggw@mail.gmail.com>
 <20151217132229.1c699f69@archvile>
 <CAPDyKFpxx5oXM=MAYcdg1fBiodOo2HjoEvHmZk9nHBCW=qqBQQ@mail.gmail.com>
 <20151217160903.556af1af@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:34068 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932736AbbLRUJp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Dec 2015 15:09:45 -0500
Content-Disposition: inline
In-Reply-To: <20151217160903.556af1af@archvile>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Jander <david@protonic.nl>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Pierre Ossman <pierre@ossman.eu>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>

On Thu, Dec 17, 2015 at 04:09:03PM +0100, David Jander wrote:
> 
> Dear Ulf,
> 
> On Thu, 17 Dec 2015 15:54:54 +0100
> Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > The code is in general fragile. We have have kind of reached the
> > point, when I apply changes that fixes one issue it may cause another.
> 
> Oh, that is indeed bad.
> I wish I was in the position to do this... but this really goes beyond my time
> and my knowledge. I think most of the effort will be at cleaning up the mess
> and make sure that each one of the many users works well afterwards, and it
> definitely takes someone who knows the code (and it's users) very well to pull
> this off.

By way of illustration, when SolidRun released their Hummingboards, I
spent a while working with Jon Nettleton getting UHS support going on
these boards (which initially required a hardware hack.)  I put
together a patch set which resolved all the problems that there were
at that time.

Yesterday, I tried adding the necessary bits to DT, as people have
started reporting _one_ problem with the SDHCI driver with UHS cards.
What I found dismayed me: I found a total of six problems or variable
severity in around two hours.

This evening, I'm starting to work through those problems, starting
with the damned trivial ones where printk()s are inappropriately
noisy, which can only come down to a lack of review of submissions
before applying changes.  Some of these are core MMC code, so I'm
afraid they aren't attributable to "no sdhci maintainer".

Eg, this one is particularly annoying as it takes something like 23
attempts to probe one of two SDHCI interfaces, so we end up with
24 "voltage-ranges unspecified" messages at boot time.

Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Fri Dec 18 19:57:05 2015 +0000

    mmc: core: shut up "voltage-ranges unspecified" pr_info()

    Each time a driver such as sdhci-esdhc-imx is probed, we get a info
    printk complaining that the DT voltage-ranges property has not been
    specified.

    However, the DT binding specifically says that the voltage-ranges
    property is optional.  That means we should not be complaining that
    DT hasn't specified this property: by indicating that it's optional,
    it is valid not to have the property in DT.

    Silence the warning if the property is missing.

    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5ae89e48fd85..b5e663b67cb5 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1220,8 +1220,12 @@ int mmc_of_parse_voltage(struct device_node *np, u32 *mask)

        voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
        num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
-       if (!voltage_ranges || !num_ranges) {
-               pr_info("%s: voltage-ranges unspecified\n", np->full_name);
+       if (!voltage_ranges) {
+               pr_debug("%s: voltage-ranges unspecified\n", np->full_name);
+               return -EINVAL;
+       }
+       if (!num_ranges) {
+               pr_err("%s: voltage-ranges empty\n", np->full_name);
                return -EINVAL;
        }



-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
