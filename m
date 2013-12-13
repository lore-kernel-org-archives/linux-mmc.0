From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Fri, 13 Dec 2013 10:57:47 +0800
Message-ID: <52AA77AB.9030203@linaro.org>
References: <1386770541-15056-1-git-send-email-zhangfei.gao@linaro.org> <201312112112.52746.arnd@arndb.de> <52A9B9B4.3080105@linaro.org> <201312122140.08566.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:55251 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829Ab3LMC57 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Dec 2013 21:57:59 -0500
Received: by mail-wg0-f42.google.com with SMTP id a1so1414542wgh.1
        for <linux-mmc@vger.kernel.org>; Thu, 12 Dec 2013 18:57:58 -0800 (PST)
In-Reply-To: <201312122140.08566.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <cjb@laptop.org>, Mike Turquette <mturquette@linaro.org>, Rob Herring <robherring2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Kumar Gala <galak@codeaurora.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, Dinh Nguyen <dinguyen@altera.com>



On 12/13/2013 04:40 AM, Arnd Bergmann wrote:
> On Thursday 12 December 2013, zhangfei wrote:
>> On 12/12/2013 04:12 AM, Arnd Bergmann wrote:
>>> On Wednesday 11 December 2013, zhangfei wrote:
>>>
>>> But aren't the times fixed for each mode? Why do you need to specify them in
>>> the DT? I would expect that the clock rates for each mode are set in the
>>> MMC and SD specifications. When you call clk_set_rate(), it should normally
>>> be enough to ask for the clock you actually want and let the clk subsystem
>>> figure out how to set up the parents and multipliers on the way.
>>
>> Yes. that's will be perfect.
>>
>> However, currently this ip still has no such capability.
>>   Input rate for init are diferent for different controller, not the
>> init 400K, some are 13M, others are 25M, since different clock source.
>> This can be easily solved by clock-freq-init = <25000000>
>> 2. There is maxmum limit, also can be easily solved by define CLK_MAX.
>> 3. However some mode can not use the max speed from ios->clock
>> for example UHS_SDR104_MAX_DTR 208000000 can not be used, only half may
>> be reached, at least currently.
>
> I don't fully understand the explanation,

This is the ip's limitation currently, that some mode can only operate 
at limited freq, rather than the max freq from spec.
Will upgrade to use ios->clock once the limitation is solved.

but if some of the other
> people with interest in dw-mmc (I've added some more to Cc now) think
> this makes sense, I'm fine with it too.
>
Could I treat this as Ack or Partially Ack for the next version :)

>> How about this desc
>>
>> * clock-freq-table: should be the frequency (in Hz) array of the ciu
>> clock
>>           in each supported timing.
>>
>>           1. CIU clock rate in HZ for MMC_TIMING_LEGACY mode
>>
>>           2. CIU clock rate in HZ for MMC_TIMING_MMC_HS mode
>>           3. CIU clock rate in HZ for MMC_TIMING_SD_HS mode
>>           4. CIU clock rate in HZ for MMC_TIMING_UHS_SDR12 mode
>>
>>           5. CIU clock rate in HZ for MMC_TIMING_UHS_SDR25 mode
>>
>>           6. CIU clock rate in HZ for MMC_TIMING_UHS_SDR50 mode
>>
>>           7. CIU clock rate in HZ for MMC_TIMING_UHS_SDR104 mode
>>
>>           8. CIU clock rate in HZ for MMC_TIMING_SD_HS mode
>>
>>           9. CIU clock rate in HZ for MMC_TIMING_MMC_HS200 mode
>>
>
> Yes, that is much better. but please avoid using Linux internal
> identifiers (e.g. MMC_TIMING_LEGACY) and instead use the terminology from
> the MMC and SD specs. Also 'Hz' is the official symbol for Hertz, not 'HZ'.
>

Update to

* clock-freq-table: should be the frequency (in Hz) array of the ciu clock
         in each supported mode.
         0. CIU clock rate in Hz for DS mode
         1. CIU clock rate in Hz for MMC HS mode
         2. CIU clock rate in Hz for SD HS mode
         3. CIU clock rate in Hz for SDR12 mode
         4. CIU clock rate in Hz for SDR25 mode
         5. CIU clock rate in Hz for SDR50 mode
         6. CIU clock rate in Hz for SDR104 mode
         7. CIU clock rate in Hz for DDR50 mode
         8. CIU clock rate in Hz for HS200 mode

Thanks
