From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: Disable UHS-I modes for tegra114
Date: Wed, 2 Mar 2016 15:50:38 +0200
Message-ID: <56D6EFAE.5050802@intel.com>
References: <1455806924-14967-1-git-send-email-jonathanh@nvidia.com>
 <1456479257-12147-1-git-send-email-jonathanh@nvidia.com>
 <20160229064338.GC23745@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160229064338.GC23745@ulmo>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 29/02/16 08:43, Thierry Reding wrote:
> On Fri, Feb 26, 2016 at 09:34:17AM +0000, Jon Hunter wrote:
>> SD card support for Tegra114 started failing after commit a8e326a911d3
>> ("mmc: tegra: implement module external clock change") was merged. This
>> commit was part of a series to enable UHS-I modes for Tegra. To
>> workaround this problem for now, disable UHS-I modes for Tegra114 by
>> separating the soc data structures for Tegra114 and Tegra124 so that
>> UHS-I is still enabled for Tegra124 but not Tegra114.
>>
>> Fixes: a8e326a911d3 ("mmc: tegra: implement module external clock change")
>>
>> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/mmc/host/sdhci-tegra.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 

Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
