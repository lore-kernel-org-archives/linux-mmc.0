From: Suneel G <suneelgarapati@gmail.com>
Subject: Re: [PATCH] drivers: mmc: sdhci: update max frequency only if undefined
Date: Thu, 18 Jun 2015 13:28:17 +0530
Message-ID: <CAOZ77oiV=2yFRNXgOD_ApEZGtd+LYK1oh+vrtaJZKr1g=EMBdQ@mail.gmail.com>
References: <1434612427-1758-1-git-send-email-suneel.garapati@xilinx.com> <20150618072939.GA31104@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:36377 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbbFRH66 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Jun 2015 03:58:58 -0400
In-Reply-To: <20150618072939.GA31104@shlinux1.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: Suneel Garapati <suneel.garapati@xilinx.com>, linux-mmc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, michals@xilinx.com, sorenb@xilinx.com, Adrian Hunter <adrian.hunter@intel.com>, Haibo Chen <haibo.chen@freescale.com>, Tim Kryger <tim.kryger@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Yi Sun <yi.y.sun@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Suman Tripathi <stripathi@apm.com>

Hi,

On Thu, Jun 18, 2015 at 12:59 PM, Dong Aisheng <b29396@freescale.com> wrote:
> On Thu, Jun 18, 2015 at 12:57:07PM +0530, Suneel Garapati wrote:
>> f_max parameter of mmc structure is updated unconditionally.
>> If dt property max-frequency is assigned, this update is
>> overwriting the dt property value which is undesired.
>>
>> Signed-off-by: Suneel Garapati <suneel.garapati@xilinx.com>
>> ---
>>  drivers/mmc/host/sdhci.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index bc14452..c2917d5 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -3047,7 +3047,10 @@ int sdhci_add_host(struct sdhci_host *host)
>>        * Set host parameters.
>>        */
>>       mmc->ops = &sdhci_ops;
>> -     mmc->f_max = host->max_clk;
>> +
>> +     if(!mmc->f_max)
>> +             mmc->f_max = host->max_clk;
>> +
>
> This is probably not going to work properly.
> mmc->f_max will be overwritten again if host->clk_mul enabled.
> And you did not do sanity check if f_max from device tree is valid.
>
> Please see:
> http://www.spinics.net/lists/arm-kernel/msg426167.html
> I already sent a proper fix.

Ok, I missed your series.
My platform doesn't have clk_mul enabled hence couldn't check on that.
Agree on the sanity check.

Regards,
Suneel

>
> Regards
> Dong Aisheng
>
>>       if (host->ops->get_min_clock)
>>               mmc->f_min = host->ops->get_min_clock(host);
>>       else if (host->version >= SDHCI_SPEC_300) {
>> --
>> 2.1.2
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
