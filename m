From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 3/4] mmc: sdhci: defer probing on regulator_get_optional()
 failures
Date: Tue, 15 Apr 2014 12:28:45 -0600
Message-ID: <534D7A5D.9090707@wwwdotorg.org>
References: <1397526163-20126-1-git-send-email-abrestic@chromium.org> <1397526163-20126-4-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397526163-20126-4-git-send-email-abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 04/14/2014 07:42 PM, Andrew Bresticker wrote:
> If regulator_get_optional() returns EPROBE_DEFER, it indicates
> that the regulator may show up later (e.g. the DT property is
> present but the corresponding regulator may not have probed).
> Instead of continuing without the regulator, return EPROBE_DEFER
> from sdhci_add_host().  Also, fix regulator leaks in the error
> paths in sdhci_add_host().

> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c

>  	if (IS_ERR_OR_NULL(host->vqmmc)) {

This is a pre-existing condition, but ick: Why doesn't this test either
IS_ERR() /or/ == NULL, but not both. On error, the regulator API should
either return and error-point or return NULL, so that client code
shouldn't need to check for both.

> +put_vmmc:
> +	if (host->vmmc)
> +		regulator_put(host->vmmc);
> +put_vqmmc:
> +	if (host->vqmmc)
> +		regulator_put(host->vqmmc);

If IS_ERR_OR_NULL() really is required above, it should be used here
too. More likely, I hope you need to replace if (host->vmmc) with if
(!IS_ERR(host->vmmc)).

I wonder if fixing this would help solve the crashes that Alex saw?
