From: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/5] clk: berlin: bg2q: remove CLK_IGNORE_UNUSED flag for
 sdio clk
Date: Fri, 16 Oct 2015 15:27:14 +0200
Message-ID: <5620FB32.8030705@gmail.com>
References: <1444628796-5484-1-git-send-email-jszhang@marvell.com>
 <1444628796-5484-5-git-send-email-jszhang@marvell.com>
 <20151016124705.20687.51712@quantum>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151016124705.20687.51712@quantum>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 16.10.2015 14:47, Michael Turquette wrote:
> Quoting Jisheng Zhang (2015-10-11 22:46:35)
>> Since we have added the necessary axi clk properties in dts, we can
>> remove the "sdio" clk's CLK_IGNORE_UNUSED flag now.
>>
>> Signed-off-by: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>
> Applied to clk-next.

Mike,

these two patches will break Berlin SoCs if not applied
after the sdhci and DT changes went in. Please hold them
back until the discussion has been settled.

Thanks,
   Sebastian

>
>> ---
>>   drivers/clk/berlin/bg2q.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/berlin/bg2q.c b/drivers/clk/berlin/bg2q.c
>> index 221f40c..243f421 100644
>> --- a/drivers/clk/berlin/bg2q.c
>> +++ b/drivers/clk/berlin/bg2q.c
>> @@ -283,7 +283,7 @@ static const struct berlin2_gate_data bg2q_gates[] __initconst = {
>>          { "usb2",       "perif",        13 },
>>          { "usb3",       "perif",        14 },
>>          { "pbridge",    "perif",        15, CLK_IGNORE_UNUSED },
>> -       { "sdio",       "perif",        16, CLK_IGNORE_UNUSED },
>> +       { "sdio",       "perif",        16 },
>>          { "nfc",        "perif",        18 },
>>          { "pcie",       "perif",        22 },
>>   };
>> --
>> 2.6.1
>>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
