From: zhangfei <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Thu, 12 Dec 2013 21:27:16 +0800
Message-ID: <52A9B9B4.3080105@linaro.org>
References: <1386770541-15056-1-git-send-email-zhangfei.gao@linaro.org> <201312111549.14017.arnd@arndb.de> <52A8868A.3000105@linaro.org> <201312112112.52746.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201312112112.52746.arnd-r2nGTMty4D4@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Haojian Zhuang <haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Dear Arnd

On 12/12/2013 04:12 AM, Arnd Bergmann wrote:
> On Wednesday 11 December 2013, zhangfei wrote:
>>>
>>> I have not seen "clk-table" and "clk-table-num" before. Are these standard
>>> properties? What are the units that are used here, what does the index mean?
>>>
>>
>> "clk-table" and "clk-table-num" are private properties.
>> Instead simply on/off, the ip need different ciu clock for each timing mode.
>
> But aren't the times fixed for each mode? Why do you need to specify them in
> the DT? I would expect that the clock rates for each mode are set in the
> MMC and SD specifications. When you call clk_set_rate(), it should normally
> be enough to ask for the clock you actually want and let the clk subsystem
> figure out how to set up the parents and multipliers on the way.

Yes. that's will be perfect.

However, currently this ip still has no such capability.
1. Input rate for init are diferent for different controller, not the 
init 400K, some are 13M, others are 25M, since different clock source.
This can be easily solved by clock-freq-init = <25000000>
2. There is maxmum limit, also can be easily solved by define CLK_MAX.
3. However some mode can not use the max speed from ios->clock
for example UHS_SDR104_MAX_DTR 208000000 can not be used, only half may 
be reached, at least currently.

>
>> Take emmc as example,
>> clk-table-num = <8>;
>> clk-table =
>> <13000000 50000000 0 0 13000000 50000000 0 100000000>;
>> MMC_TIMING_LEGACY mode, 25M should be set with parent clock 180M,
>> MMC_TIMING_MMC_HS mode, 50M is required with parent clock 360M
>>
>> "clk-table" list all clocks to be set in all supported timing one by one.
>> "clk-table-num" is the table number, since not find function getting
>> table number.
>> For example, next version will support MMC_TIMING_MMC_HS200 mode, the
>> clk-table-num = <9> with 9 clocks in the "clk-table"
>
> If you have a property with an array, you can use of_find_property()
> to get to the 'struct property' and then read the 'length' member
> of that struct, or you can use of_property_for_each_u32() to iterate
> through each value.

Great, this works.

>
> While I still hope that you don't even need this array as per the reasoning
> above, if you actually need it, you should specify exactly what each
> value means, such as
>
> 1. CIU clock rate in HZ for 20MHz SPI mode operation
> 2. CIU clock rate in HZ for 25MHz SD card operation
> 3. CIU clock rate in HZ for 26MHz MMC card operation
> 4. CIU clock rate in HZ for 50MHz SD card operation
> ...

How about this desc

* clock-freq-table: should be the frequency (in Hz) array of the ciu 
clock
         in each supported timing. 

         1. CIU clock rate in HZ for MMC_TIMING_LEGACY mode 

         2. CIU clock rate in HZ for MMC_TIMING_MMC_HS mode
         3. CIU clock rate in HZ for MMC_TIMING_SD_HS mode
         4. CIU clock rate in HZ for MMC_TIMING_UHS_SDR12 mode 

         5. CIU clock rate in HZ for MMC_TIMING_UHS_SDR25 mode 

         6. CIU clock rate in HZ for MMC_TIMING_UHS_SDR50 mode 

         7. CIU clock rate in HZ for MMC_TIMING_UHS_SDR104 mode 

         8. CIU clock rate in HZ for MMC_TIMING_SD_HS mode 

         9. CIU clock rate in HZ for MMC_TIMING_MMC_HS200 mode 


Thanks
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
