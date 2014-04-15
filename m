From: Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] mmc: sdhci: defer probing on regulator_get_optional() failures
Date: Tue, 15 Apr 2014 12:03:49 -0700
Message-ID: <CAAYSxhrmCbGLsu43mK15ParXHa_FJ9OVQiCPUdqyWEpTE=r1uw@mail.gmail.com>
References: <1397526163-20126-1-git-send-email-abrestic@chromium.org>
	<1397526163-20126-4-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397526163-20126-4-git-send-email-abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, mike.looijmans-Oq418RWZeHk@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Apr 14, 2014 at 6:42 PM, Andrew Bresticker
<abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> If regulator_get_optional() returns EPROBE_DEFER, it indicates
> that the regulator may show up later (e.g. the DT property is
> present but the corresponding regulator may not have probed).
> Instead of continuing without the regulator, return EPROBE_DEFER
> from sdhci_add_host().  Also, fix regulator leaks in the error
> paths in sdhci_add_host().
>
> Signed-off-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/mmc/host/sdhci.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)

This appears to be an improvement on Mike Looijmans patch:

https://lkml.org/lkml/2014/4/7/34

The regulator_put() calls are appropriate but I wonder if we should
take this a step farther.  Ulf is sure to point out that
mmc_regulator_get_supply() can be used to get regulators (though it
does stuff the pointers in host->mmc->supply.vmmc/vqmmc instead of
host->vmmc/vqmmc).  However, that function doesn't put back the
reference to vmmc if the request for vqmmc returns EPROBE_DEFER.  If
it did, it believe it could be used here to simplify the error
handling as all the regulator checks would happen up front.  What do
you think?

-Tim
