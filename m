From: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2] mmc: core: add DT binding for CMD23
Date: Mon, 28 Nov 2016 18:40:28 +0900
Message-ID: <8af2b7b1-7473-e048-87b7-4acf7e2ba014@samsung.com>
References: <20161125065215.10833-1-jh80.chung@samsung.com>
 <CGME20161125082443epcas2p2c0f10ecaf32225c09747a7736b1bb7cc@epcas2p2.samsung.com>
 <CAPDyKFr3CMeqDpQxf13Z1Ae5W_Q3X75if4fK9eYstXaVeTTVwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <CAPDyKFr3CMeqDpQxf13Z1Ae5W_Q3X75if4fK9eYstXaVeTTVwg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 11/25/2016 05:19 PM, Ulf Hansson wrote:
> On 25 November 2016 at 07:52, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>> Provide the option to configure one type of multiple block read/wrte
>> transatction (CMD23 - it's optional.)
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> ---
>>  drivers/mmc/core/host.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>> index 98f25ff..9bdc369 100644
>> --- a/drivers/mmc/core/host.c
>> +++ b/drivers/mmc/core/host.c
>> @@ -321,6 +321,8 @@ int mmc_of_parse(struct mmc_host *host)
>>                 host->caps2 |= MMC_CAP2_NO_SD;
>>         if (of_property_read_bool(np, "no-mmc"))
>>                 host->caps2 |= MMC_CAP2_NO_MMC;
>> +       if (of_property_read_bool(np, "cap-mmc-cmd23"))
>> +               host->caps |= MMC_CAP_CMD23;
>>
>>         host->dsr_req = !of_property_read_u32(np, "dsr", &host->dsr);
>>         if (host->dsr_req && (host->dsr & ~0xffff)) {
>> --
>> 2.10.1
>>
> 
> I don't think this as HW configuration, but more a SW configuration.
> Thus we don't need a DT binding for it, right?

Got it. Then discard these patches.

Best Regards,
Jaehoon Chung

> 
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
