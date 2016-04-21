From: Lars Persson <lars.persson-VrBV9hrLPhE@public.gmane.org>
Subject: Re: [PATCH v3 2/3] mmc: usdhi6rol0: add support for UHS modes
Date: Thu, 21 Apr 2016 10:26:55 +0200
Message-ID: <57188ECF.70101@axis.com>
References: <cover.1461163234.git.larper@axis.com> <92b72ede5f8ddf2b2f74cdb7422bc8ef5458b23c.1461163234.git.larper@axis.com> <57187D74.8090601@axis.com> <4129305.Ka9B8YpEaI@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4129305.Ka9B8YpEaI@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Lars Persson <larper-VrBV9hrLPhE@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, g.liakhovetski-Mmb7MZpHnFY@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org



On 04/21/2016 09:53 AM, Arnd Bergmann wrote:
> On Thursday 21 April 2016 09:12:52 Lars Persson wrote:
>> On 04/20/2016 04:53 PM, Lars Persson wrote:
>>> Add a start_signal_voltage_switch() operation to support enabling of
>>> UHS modes.
>>>
>>> Signed-off-by: Lars Persson <larper-VrBV9hrLPhE@public.gmane.org>
>>> ---
>>>    drivers/mmc/host/usdhi6rol0.c | 13 +++++++++++++
>>>    1 file changed, 13 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
>>> index 807c06e..2585ea4 100644
>>> --- a/drivers/mmc/host/usdhi6rol0.c
>>> +++ b/drivers/mmc/host/usdhi6rol0.c
>>> @@ -1147,12 +1147,25 @@ static void usdhi6_enable_sdio_irq(struct mmc_host *mmc, int enable)
>>>        }
>>>    }
>>>
>>> +static int usdhi6_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>>> +{
>>> +     int ret;
>>> +
>>
>> To support boards without regulator we need to put a
>> IS_ERR_OR_NULL(mmc->supply.vqmmc) check here and bail out with return 0.
>> Missing vqmmc is OK according to our binding document, but treated as an
>> error by mmc_regulator_set_vqmmc().
>
> mmc_regulator_set_vqmmc() should already take care of handling
> all the those cases. In general, it's almost always a bug to use
> IS_ERR_OR_NULL(): if you ever feel the need to use it, you should
> either fix the code that made the pointer ambiguous or you have
> misunderstood the interface.
>
> 	Arnd
>

Yes it should of course be IS_ERR() rather than IS_ERR_OR_NULL().

It is a common pattern in all upstream mmc drivers to not make the call 
to mmc_regulator_set_vqmmc() when a regulator is missing. We basically 
want to log errors except for the EINVAL returned in case of a missing 
regulator.


- Lars
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
