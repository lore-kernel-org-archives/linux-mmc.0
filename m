From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/4] mmc: sdhci: defer probing on regulator_get_optional() failures
Date: Tue, 15 Apr 2014 12:59:37 -0700
Message-ID: <CAL1qeaEGpz-9rOtp4fAHFz8KG2fCscFsqu1tbi2d9mxTM8yHQQ@mail.gmail.com>
References: <1397526163-20126-1-git-send-email-abrestic@chromium.org>
	<1397526163-20126-4-git-send-email-abrestic@chromium.org>
	<534D7A5D.9090707@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <534D7A5D.9090707-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Apr 15, 2014 at 11:28 AM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> On 04/14/2014 07:42 PM, Andrew Bresticker wrote:
>> If regulator_get_optional() returns EPROBE_DEFER, it indicates
>> that the regulator may show up later (e.g. the DT property is
>> present but the corresponding regulator may not have probed).
>> Instead of continuing without the regulator, return EPROBE_DEFER
>> from sdhci_add_host().  Also, fix regulator leaks in the error
>> paths in sdhci_add_host().
>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>
>>       if (IS_ERR_OR_NULL(host->vqmmc)) {
>
> This is a pre-existing condition, but ick: Why doesn't this test either
> IS_ERR() /or/ == NULL, but not both. On error, the regulator API should
> either return and error-point or return NULL, so that client code
> shouldn't need to check for both.

Unfortunately, this is necessary.  regulator_get() returns NULL if
!CONFIG_REGULATOR and we do not want to call
regulator_is_supported_voltage() in this case since it will always
return false, causing sdhci_add_host() to disable UHS modes.
Alternatively, we could put the regulator_is_supported_voltage() check
wihin an #ifdef CONFIG_REGULATOR, as is done when checking supported
vmmc voltages below.

>
>> +put_vmmc:
>> +     if (host->vmmc)
>> +             regulator_put(host->vmmc);
>> +put_vqmmc:
>> +     if (host->vqmmc)
>> +             regulator_put(host->vqmmc);
>
> If IS_ERR_OR_NULL() really is required above, it should be used here
> too. More likely, I hope you need to replace if (host->vmmc) with if
> (!IS_ERR(host->vmmc)).

host->vmmc and host->vqmmc are set to NULL in the case of IS_ERR(), so
the IS_ERR() check here isn't necessary.

>
> I wonder if fixing this would help solve the crashes that Alex saw?

I believe the crash Alex is seeing is due to a race between tearing
down the sdhci driver on probe deferral and the card-detect IRQ.
Looking at it now.
