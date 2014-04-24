From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 00/38] MMC updates, plus CuBox-i WiFi support
Date: Thu, 24 Apr 2014 13:13:05 +0200
Message-ID: <CAPDyKFr=2=dg1NTYb1_EAgxXZq2Rd+o2Q2B5TE+GZwr8MUU1_Q@mail.gmail.com>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
	<CAPDyKFozP69yngKAkdwHYyyvi+pdLEm05udOmBiVshQFi4hnLQ@mail.gmail.com>
	<20140424101726.GH26756@n2100.arm.linux.org.uk>
	<CAPDyKFrGReKF0ucer7D195boEoQW26=4vDXT+=Wn6BO-p_B1gQ@mail.gmail.com>
	<20140424105745.GM26756@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140424105745.GM26756-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Anton Vorontsov <anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org>, Barry Song <baohua-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, Stephe
List-Id: linux-mmc@vger.kernel.org

On 24 April 2014 12:57, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> On Thu, Apr 24, 2014 at 12:52:11PM +0200, Ulf Hansson wrote:
>> On 24 April 2014 12:17, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
>> > On Thu, Apr 24, 2014 at 10:25:42AM +0200, Ulf Hansson wrote:
>> >> I have looked though the patches up until patch 33 and this is clearly
>> >> a nice piece of clean-up /fixes work for sdhci. Besides my minor
>> >> comments per patch, I don't have any objections code-review wise to
>> >> proceed merging them.
>> >>
>> >> I have also tried to applied them on Chris' mmc-next branch,
>> >> unfortunate it fails at patch 23, so it would be nice to get a
>> >> re-based patchset for the mmc-next branch.
>> >
>> > I /could/ rebase it but then I wouldn't be able to produce the patch
>> > sets/patches for others [*] (such as the Novena project) to derive
>> > their kernel tree from my iMX6 patch set.
>> >
>> > What I'd prefer is to keep the patch set intact, and provide Chris
>> > with a pull request for it up to patch 33, which would need a
>> > conflict fixed - and this would mean that I can be sure that what
>> > I'm testing, and what I'm distributing is what Chris will also be
>> > submitting.
>>
>> Whether there are more than one conflict, I don't know. I just stopped
>> at patch 23.
>>
>> Moreover, there are other patches for sdhci that have been posted and
>> being discussed. In principle, we then need to put all these on hold
>> to prevent further conflicts. I guess that doable, as long as we don't
>> to that for too long. Maybe Chris have some more thoughts how to
>> handle this!?
>
> This is nothing new or unexpected - it was last posted back in February,
> and I elected that it should be held off until after the last merge
> window.
>
> Unfortunately, I didn't have time to post it immediately after the merge
> window closed, partly because it needed to be rebased on top of tglx's
> IRQ changes on which it depends.  I was carrying those as separate commits
> to the ones Thomas was carrying in his tree - and in the event, Thomas had
> modified his patches slightly between sending me copies of them and the
> versions he sent during the merge window.

Okay, so let's keep up the frequency here then. I only had some minor
comments, please fix them and send a v2.

How about if I resolve the conflicts and send the pull request to
Chris? I suppose it makes life a bit easier for Chris.

Kind regards
Ulf Hansson

>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
