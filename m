From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH v2 03/20] mmc: support embedded data field in mmc_host
Date: Wed, 4 Aug 2010 12:41:48 +0100
Message-ID: <20100804114147.GB6852@n2100.arm.linux.org.uk>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com> <1279733634-21974-4-git-send-email-ohad@wizery.com> <AANLkTimzA_JJ-byTDWznbL3YzeJ8LAP4M50onf2_3fBF@mail.gmail.com> <AANLkTi=Oy8X1xMOwWL_cKBB1LWULT6=p+adUgB+AuSJS@mail.gmail.com> <AANLkTi=BUX59heXAW2Uf4wZo2dSS19Je54dkQ5u2YGAW@mail.gmail.com> <AANLkTimZQKj7H_GeE=+O9cwxEMTR+LhfFbt=AyXGzN3d@mail.gmail.com> <AANLkTikfRja-h9mz7uyRXCZNZjKdU_yB8e58XQucUzrn@mail.gmail.com> <AANLkTi=vhWV1RNyemtfppfjvLYAbzd3aRjFOVgLLpG3Z@mail.gmail.com> <AANLkTin4m8gJR50zwMB2b0jRMHdNA6CQToKBTAhOL9wF@mail.gmail.com> <AANLkTinu2S19r8fueM-jVkc35XL2G0Z16BddE92Ci9KB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinu2S19r8fueM-jVkc35XL2G0Z16BddE92Ci9KB-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kalle Valo <kalle.valo-X3B1VOXEql0@public.gmane.org>, Pandita Vikram <vikram.pandita-l0cyMroinI0@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Chikkature Rajashekar Madhusudhan <madhu.cr-l0cyMroinI0@public.gmane.org>, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Aug 04, 2010 at 02:24:39PM +0300, Ohad Ben-Cohen wrote:
> Hi Vitaly,
> 
> On Tue, Aug 3, 2010 at 5:17 PM, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > On Mon, Aug 2, 2010 at 11:35 PM, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org> wrote:
> >> I'm honestly trying to understand your concerns, but I'm afraid that
> >> just saying "it's a hack" is not too informative. Can you please
> >> explain what do you think is technically wrong with the proposed
> >> solution ? is it not general enough for other use cases ? will it
> >> break something ?
> 
> > So if I'd like to set the *same* structure for the *same* WL1271
> > driver, provided that I'm working with the other platform, I'll need
> > to do the following:
> > - add the pointer to the board-specific header;
> > - add the structure to the board-specific C file and propagate its
> > pointer to the controller driver;
> > - add setting the pointer in the core structure into the controller driver.
> >
> > This is far from being intuitive. This means we need to hack,
> > generally speaking, all the MMC controller drivers to get it working
> > on all platforms. This is error prone.
> 
> You make it sound really complex.
> 
> Let's see what it means to add it to a totally different platform.
> 
> As an example, let's take Google's ADP1 which is based on a different
> host controller (msm-sdcc), and add the required support (untested of
> course, just a quick sketch, patch is based on android's msm git):

What if some other driver gets attached and tries to use this
platform data?  This whole idea sounds extremely silly, cumbersome,
error prone, and is inviting misuse by normal MMC sockets.

Why not arrange for a small piece of code to be built into the kernel
when this driver is selected as a module or built-in, which handles
the passing of platform data to the driver?

Something like:

wl12xx_platform_data.c:
#include <linux/module.h>
#include <whatever/required/for/wl12xx.h>

static struct wl12xx_platform_data *platform_data;

int __init wl12xx_set_platform_data(const struct wl12xx_platform_data *data)
{
	if (platform_data)
		return -EBUSY;
	platform_data = kmemdup(data, sizeof(*data), GFP_KERNEL);
	if (!platform_data)
		return -ENOMEM;
	return 0;
}

int wl12xx_get_platform_data(struct wl12xx_platform_data *data)
{
	if (platform_data) {
		memcpy(data, platform_data, sizeof(*data));
		return 0;
	}
	return -ENODEV;
}
EXPORT_SYMBOL(wl12xx_get_platform_data);

And in the Kconfig, something like:

config WL12XX_PLATFORM_DATA
	bool
	depends on WL12XX != n
	default y

This means there'll be no confusion over who owns the 'embedded data',
typechecking is preserved, and no possibility for the wrong driver to
pick up the data.
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
