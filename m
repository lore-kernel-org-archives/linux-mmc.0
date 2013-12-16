From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Mon, 16 Dec 2013 19:07:03 +0800
Message-ID: <52AEDED7.2010407@linaro.org>
References: <1386987174-1788-1-git-send-email-zhangfei.gao@linaro.org> <1386987174-1788-3-git-send-email-zhangfei.gao@linaro.org> <000001cefa11$eb02f270$c108d750$%jun@samsung.com> <52AE8A0E.2050005@linaro.org> <003901cefa30$93c3cce0$bb4b66a0$%jun@samsung.com> <52AEB4FD.4070707@linaro.org> <004c01cefa3f$b9afe880$2d0fb980$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:65213 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122Ab3LPLHM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2013 06:07:12 -0500
Received: by mail-pd0-f181.google.com with SMTP id p10so5181521pdj.40
        for <linux-mmc@vger.kernel.org>; Mon, 16 Dec 2013 03:07:11 -0800 (PST)
In-Reply-To: <004c01cefa3f$b9afe880$2d0fb980$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, 'Chris Ball' <cjb@laptop.org>, 'Arnd Bergmann' <arnd@arndb.de>, 'Mike Turquette' <mturquette@linaro.org>, 'Rob Herring' <robherring2@gmail.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Kumar Gala' <galak@codeaurora.org>, 'Haojian Zhuang' <haojian.zhuang@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org, 'Zhigang Wang' <brooke.wangzhigang@huawei.com>



On 12/16/2013 05:18 PM, Seungwon Jeon wrote:
> On Mon, December 16, 2013, Zhangfei Gao wrote:
>> On 12/16/2013 03:29 PM, Seungwon Jeon wrote:
>>> On Mon, December 16, 2013, Zhangfei Gao wrote:
>>>> Dear Seungwon
>>>>
>>>> On 12/16/2013 11:50 AM, Seungwon Jeon wrote:
>>>>> On Sat, December 14, 2013, Zhangfei Gao wrote:
>>>>
>>>>>> +	/* SoC portion */
>>>>>> +	dwmmc_0: dwmmc0@fcd03000 {
>>>>>> +		compatible = "hisilicon,hi4511-dw-mshc";
>>>>>> +		reg = <0xfcd03000 0x1000>;
>>>>>> +		interrupts = <0 16 4>;
>>>>>> +		#address-cells = <1>;
>>>>>> +		#size-cells = <0>;
>>>>>> +		clocks = <&mmc_clock HI3620_SD_CIUCLK>, <&clock HI3620_DDRC_PER_CLK>;
>>>>>> +		clock-names = "ciu", "biu";
>>>>>> +		clock-freq-table =
>>>>>> +		<25000000 0 50000000 25000000 50000000 100000000 0 50000000>;
>>>>> I think it could be solved with mmc->f_min and mmc->f_max(from clock-freq-min-max property)
>>>>> if there is no limitation per each speed mode. As seeing described table, it looks that.
>>>>
>>>> Have tried them before, but unfortunately, they are different.
>>>>
>>>> The controller can not generate clock itself, while depending on the
>>>> outside clock generator, which may require to change clock source in
>>>> differnt mode.
>>>>
>>>> The value we want is set the capacibility of the clock input and the max
>>>> clock freq where mmc works stable in that mode, which may be different
>>>> in different mode.
>>>>
>>>> clock-freq-min-max will set the value for set_ios.
>>>> For example, we use 25M as clock capability when init, which can not be
>>>> set as freq-min, and used as set_ios, where 400K should be used,
>>>> otherwise init definitely fail.
>>> Can you check 'f_init' within 'drivers/mmc/core/core.c' file?
>>> If you set 'f_min = 25000000' for init-sequence, mmc_set_ios() will pass that rate through
>> 'ios.clock'
>>> Then, dw_mmc-k3 can do clk_set_rate() with 25MHz at dw_mci_k3_set_ios().
>>
>> This means controller directly use 25M init emmc and sd card, it will fail.
>> We still need 400K init freq, while the input clock source is 25M,
>> divided by the controller.
>>
>>> And other required speeds for each mode seem not specific compared with standard spec.
>>> Also clk_set_rate() would be possible with 'ios.clock' instead of specific table.
>>> I just referred your example's clock-freq-table above.
>> There also some controller limitation currently.
>> In some mode, the controller only works well in the limited freq.
>> For example UHS_SDR104_MAX_DTR 208000000 can not be used, only half may
>> be reached, at least currently
> Ok. I see your condition. I misunderstood a little bit.
> I wonder whether limitation is only max frequency(SDR104 or HS200) except for init-freq.
> How about other mode? Working is fine with normal clock rate(from clock-freq-table)?
> 

The root cause is the controller can not generate stable clock itself,
but depends on outside clock source, which is varying, and driver need
to decide input clock rate / choose clock source according to the
working mode.

Three cases here:
1. Input rate for init are diferent for different controller, not the
init 400K, some are 13M, others are 25M, since different clock source.
This can be easily solved by clock-freq-init = <25000000>

2. There is maxmum limit, also can be easily solved by define CLK_MAX.
For example, CLK_MAX = 180M.

3. However some mode can not use the max speed from ios->clock
for example UHS_SDR104_MAX_DTR 208000000 can not be used, only half may
be reached, at least currently.

The third case is current limitation, after this limitation is solved,
we can switch to ios->clock directly.

Considering all these cases, we think using table is more suitable now.

Thanks

