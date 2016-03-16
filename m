From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] mmc: tegra: properly disable card clock
Date: Wed, 16 Mar 2016 13:35:50 +0100
Message-ID: <CAPDyKFpOv4tAdWywzYZh0JmVa3VaVMRC4Lew3wcXagcS3GVDZg@mail.gmail.com>
References: <1456779385-18996-1-git-send-email-dev@lynxeye.de>
	<CAPDyKFoJfNE7HcL3BcbRQpw6uOvQYrD=bEYvgUxjvOaX36o=fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFoJfNE7HcL3BcbRQpw6uOvQYrD=bEYvgUxjvOaX36o=fA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 4 March 2016 at 10:41, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 29 February 2016 at 21:56, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org> wrote:
>> The new code to do the clock rate setting externally to the SDMMC
>> module has a shortcut to not propagate changes with a 0 rate to
>> the CAR by simply bailing out. This breaks proper cutting of the
>> card clock. Fix it by directly calling the correct sdhci function.
>>
>> Fixes: a8e326a911d3 "mmc: tegra: implement module external clock change"
>> Signed-off-by: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
>
> Thanks, applied for fixes!
>

Unfortunate I failed to send this in a PR to Linus within the 4.5 rc
cycle, apologize for the inconvenience!
Instead I have this queued for 4.6 and I have added a stable tag to it.

[...]

Kind regards
Uffe
