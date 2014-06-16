From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 23/38] mmc: sdhci: convert sdhci_set_uhs_signaling() into
 a library function
Date: Mon, 16 Jun 2014 18:10:55 +0200
Message-ID: <CAPDyKFoeZLMCNpMMyLKKES+CUmTXt1g1rCPLB6HKXy9AMw1Zng@mail.gmail.com>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
	<E1Wd2Wd-0003vp-S2@rmk-PC.arm.linux.org.uk>
	<20140616104615.GA10701@n2100.arm.linux.org.uk>
	<CAPDyKFrp8JokqBbo3rg2i6WYykU1C9CuPF0FL7AOHh=Gcp5=hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFrp8JokqBbo3rg2i6WYykU1C9CuPF0FL7AOHh=Gcp5=hg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Barry Song <baohua-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Anton Vorontsov <anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Viresh Kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 16 June 2014 14:17, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 16 June 2014 12:46, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
>> On Wed, Apr 23, 2014 at 08:08:07PM +0100, Russell King wrote:
>>> @@ -1507,25 +1529,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>>>                       host->ops->set_clock(host, host->clock);
>>>               }
>>>
>>> -             if (host->ops->set_uhs_signaling)
>>> -                     host->ops->set_uhs_signaling(host, ios->timing);
>>> -             else {
>>> -                     ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>> -                     /* Select Bus Speed Mode for host */
>>> -                     ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
>>> -                     if ((ios->timing == MMC_TIMING_MMC_HS200) ||
>>> -                         (ios->timing == MMC_TIMING_UHS_SDR104))
>>> -                             ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
>>> -                     else if (ios->timing == MMC_TIMING_UHS_SDR12)
>>> -                             ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
>>> -                     else if (ios->timing == MMC_TIMING_UHS_SDR25)
>>> -                             ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
>>> -                     else if (ios->timing == MMC_TIMING_UHS_SDR50)
>>> -                             ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
>>> -                     else if (ios->timing == MMC_TIMING_UHS_DDR50)
>>> -                             ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
>>> -                     sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>>> -             }
>>> +             host->ops->set_uhs_signaling(host, ios->timing);
>>>
>>>               if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
>>>                               ((ios->timing == MMC_TIMING_UHS_SDR12) ||
>>
>> Whoever decided to poorly pick these patches up against my will has
>> slightly messed this patch up - whereas my original patch left the
>> code correctly formatted, when whoever applied this patch did so, they
>> left an additional blank line in the above.
>

[snip]

> Please, feel free to send a patch to fixup my misstake. I will happily apply it.

I had a second look to fix it up myself, but I just can't find that
your patch was different than the one I applied (beside the conflict I
resolved).

If you do find any other issue regarding the patches in this patchset
- please let me know and I will try to help.

Kind regards
Uffe
