From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] mmc: tegra: properly disable card clock
Date: Thu, 17 Mar 2016 14:55:47 +0100
Message-ID: <CAPDyKFoxMbgbttRxGBoG2X1fMpg+fFMT+NHM0eVVmQFWpU8-WQ@mail.gmail.com>
References: <1456779385-18996-1-git-send-email-dev@lynxeye.de>
	<56EA952B.5020900@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56EA952B.5020900-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 17 March 2016 at 12:29, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>
> On 29/02/16 20:56, Lucas Stach wrote:
>> The new code to do the clock rate setting externally to the SDMMC
>> module has a shortcut to not propagate changes with a 0 rate to
>> the CAR by simply bailing out. This breaks proper cutting of the
>> card clock. Fix it by directly calling the correct sdhci function.
>>
>> Fixes: a8e326a911d3 "mmc: tegra: implement module external clock change"
>> Signed-off-by: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
>> ---
>>  drivers/mmc/host/sdhci-tegra.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
>> index 212d51f..46a6bd1 100644
>> --- a/drivers/mmc/host/sdhci-tegra.c
>> +++ b/drivers/mmc/host/sdhci-tegra.c
>> @@ -194,7 +194,7 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>>       unsigned long host_clk;
>>
>>       if (!clock)
>> -             return;
>> +             return sdhci_set_clock(host, clock);;
>
> Looks like the above adds an unnecessary additional semi-colon.
>
> Ulf, are you able to correct, or do you want a patch?

Thanks for spotting this, I have amended the commit. No patch needed.

Thanks!

Kind regards
Uffe
