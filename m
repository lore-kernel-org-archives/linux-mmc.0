From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 4/4] ARM: tegra: fix Venice2 VQMMC regulators
Date: Wed, 16 Apr 2014 13:24:25 -0700
Message-ID: <CAL1qeaENYazDf6cuWsFLgJcsAPTU9D4nz1dPr3Jva_++Po_mrw@mail.gmail.com>
References: <1397526163-20126-1-git-send-email-abrestic@chromium.org>
	<1397526163-20126-5-git-send-email-abrestic@chromium.org>
	<CAL1qeaGGSs5fpqrKWA4u4+RXRy9Ko2pN=s9QQdbXAfLG3ujR8g@mail.gmail.com>
	<534EAD91.90704@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <534EAD91.90704-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Apr 16, 2014 at 9:19 AM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> On 04/15/2014 06:29 PM, Andrew Bresticker wrote:
>>>         sdhci@0,700b0600 {
>>>                 status = "okay";
>>>                 bus-width = <8>;
>>> +               vqmmc-supply = <&vddio_1v8>;
>>
>> It turns out this bit isn't needed as the initialization failures are
>> instead due to +3V3_RUN toggling, which Stephen has fixed:
>> http://patchwork.ozlabs.org/patch/339386/
>
> Indeed, if I apply patches 1, 2, and 4 from this series, revert the hunk
> above, apply my Venice2 regulator patch, and finally apply your AS3722
> regulator GPIO patch, then everything works fine for me:-)

Great, I'll fix up and resend without patch 3 as it looks like that
will need some more work.
