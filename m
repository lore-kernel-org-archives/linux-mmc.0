From: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dts: tegra: fix the activate polarity of
 cd-gpio in mmc host
Date: Thu, 21 Feb 2013 16:30:35 +0800
Message-ID: <1361435435.5678.113.camel@jlo-ubuntu-64.nvidia.com>
References: <1361343902-15223-1-git-send-email-josephl@nvidia.com>
	 <1361343902-15223-2-git-send-email-josephl@nvidia.com>
	 <512500EB.1070802@wwwdotorg.org>
	 <20130221081809.GB7718@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130221081809.GB7718-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Thierry,

Thanks for your verification.

On Thu, 2013-02-21 at 16:18 +0800, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Wed, Feb 20, 2013 at 09:59:23AM -0700, Stephen Warren wrote:
> > On 02/20/2013 12:05 AM, Joseph Lo wrote:
> > > The GPIO pin of SD slot card detection should active low.
> > 
> > Thierry, Lucas, can you please check if the same change should be made
> > to all the Avionic Design and Toradex boards? I assume MMC CD should be
> > active low on all of them. Once you've confirmed this, Joseph can respin
> > this first patch, and perhaps we can get it into 3.9/stable as a
> > bug-fix. Thanks.
> 
> The card-detect GPIO is certainly low-active on Tamonten. I'm not quite
> sure why things worked before, but I guess it was due to the MMC core
> assuming the CD GPIO to be low-active unless otherwise specified and the
> Tegra DT code didn't pass the GPIO flags to the core.
> 
Yes. And the original sdhci-tegra driver didn't use the GPIO flag to
config anything. After we use mmc_of_parse, it will be taken care in the
core. So both of the cp-gpio and wp-gpio should be config right in DT.

> Anyway, I've verified that on Tamonten the same change doesn't break
> anything, card detect still works as expected with this patch series
> applied, so if Joseph could carry the Tamonten change as part of this
> patch it'd be great.

Thanks. Will do.
