From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 23/38] mmc: sdhci: convert sdhci_set_uhs_signaling() into
 a library function
Date: Thu, 19 Jun 2014 09:57:06 -0600
Message-ID: <53A30852.2090405@wwwdotorg.org>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk> <E1Wd2Wd-0003vp-S2@rmk-PC.arm.linux.org.uk> <20140616104615.GA10701@n2100.arm.linux.org.uk> <CAPDyKFrp8JokqBbo3rg2i6WYykU1C9CuPF0FL7AOHh=Gcp5=hg@mail.gmail.com> <20140619122830.GP32514@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140619122830.GP32514-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Barry Song <baohua-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, Anton Vorontsov <anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Viresh Kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 06/19/2014 06:28 AM, Russell King - ARM Linux wrote:
> On Mon, Jun 16, 2014 at 02:17:30PM +0200, Ulf Hansson wrote:
>> Anyway, we did get some folks to test the patches and was thus fairly
>> confident that we could merge them. Chris asked me to try to collect
>> them in a PR for him, so I did. Sorry if I managed to screw some
>> things up, there were several conflicts and actual regressions, which
>> I tried to take care of.
>>
>> The mmc people were also very helping in sending patches to fixup
>> related regressions, immediately after we merged your patchset. Thus
>> together I think we managed to pull it off.
> 
> I tend to look through slightly less rose-tinted glasses.
> 
> The fact is... there's loads of ARM platforms which now fail in Olof's
> build/boot testing, and they all seem to have a very similar pattern:
> 
> hummingboard:
> [    1.149688] sdhci: Secure Digital Host Controller Interface driver
> [    1.155901] sdhci: Copyright(c) Pierre Ossman
> ...
> [    1.253630] Waiting for root device /dev/mmcblk0p2...
> [   60.325469] imx-sdma 20ec000.sdma: firmware not found
> ~$off
> # PYBOOT: Exception: timeout
> 
> jetson:
> [    2.261355] Waiting for root device /dev/mmcblk0p1...
> 
> wandboard:
> [    1.186870] sdhci: Secure Digital Host Controller Interface driver
> [    1.193075] sdhci: Copyright(c) Pierre Ossman
> ...
> [    1.291064] Waiting for root device /dev/mmcblk0p2...

Any SDHCI failures in Linus' tree (but not linux-next) that occur only
in multi_v7_defconfig are likely solved by:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/264012.html

[PATCH] ARM: multi_v7_defconfig: re-enable SDHCI drivers

> Whether these are caused by the patch set or not is anyone's guess,
> because we (a) don't know what's causing these failures, and (b)
> my patch series was never tested on anything but iMX6.

I thought that I'd tested at least some of it on Tegra.
