From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCHv3 3/4] mmc: dw_mmc: remove the "supports-highspeed"
 property.
Date: Fri, 30 May 2014 17:12:25 +0900
Message-ID: <53883D69.4010701@samsung.com>
References: <1401255351-17653-1-git-send-email-jh80.chung@samsung.com>
 <1401255351-17653-4-git-send-email-jh80.chung@samsung.com>
 <CAPDyKFpTTYHtkKjFmbPi6P_xfdfd8Fv8qfpKZMfpQBppRNZLwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAPDyKFpTTYHtkKjFmbPi6P_xfdfd8Fv8qfpKZMfpQBppRNZLwg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ludovic Desroches <ludovic.desroches@atmel.com>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi, Ulf.

On 05/30/2014 05:01 PM, Ulf Hansson wrote:
> On 28 May 2014 07:35, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Removed the parser for "supports-highspeed".
>> It can be parsed with "cap-mmc-highsped" or "cap-sd-highspeed" at
>> mmc_of_parse().
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c |    3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 3285bdd..34b5210 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2281,9 +2281,6 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>>                         return ERR_PTR(ret);
>>         }
>>
>> -       if (of_find_property(np, "supports-highspeed", NULL))
>> -               pdata->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
>> -
> 
> According to DT guys, normally we shouldn't remove DT bindings. Thus,
> you need to keep this, unless you can get some of the DT guys to ack
> it.
As you mentioned, this patch didn't need, right?

> 
> Though, you still want to move the DTs to use common mmc bindings. And
> you could mark the documentation of the above binding as deprecated.
I added the comment for deprecated into dw-mmc dt-binding doc file.
"[PATCHv3,4/4] ARM: dts: replace the slot property into slot sub-node for dwmmc."

I think this patch can be discarded. then everything is ok.!? :)

If i'm wrong, let me know, plz.

Thank you for sharing the information.

Best Regards,
Jaehoon Chung
> 
> Kind regards
> Ulf Hansson
> 
