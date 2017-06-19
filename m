From: Frank Wang <frank.wang@rock-chips.com>
Subject: Re: [PATCH 1/6] ARM: dts: rockchip: add basic dtsi file for RK3229
 SoC
Date: Mon, 19 Jun 2017 18:34:27 +0800
Message-ID: <7e8e2097-d5ca-a594-cb87-1b7b221fd58a@rock-chips.com>
References: <1497510980-23207-1-git-send-email-frank.wang@rock-chips.com>
 <1497510980-23207-2-git-send-email-frank.wang@rock-chips.com>
 <18070472.si2qlgbqtt@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.136]:43412 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752350AbdFSKen (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Jun 2017 06:34:43 -0400
In-Reply-To: <18070472.si2qlgbqtt@phil>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: robh+dt@kernel.org, ulf.hansson@linaro.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, charles.chen@rock-chips.com, kevan.lan@rock-chips.com, huangtao@rock-chips.com, wmc@rock-chips.com

Hi Heiko,

On 2017/6/18 2:12, Heiko Stuebner wrote:
> Am Donnerstag, 15. Juni 2017, 15:16:15 CEST schrieb Frank Wang:
>> Due to some tiny differences between RK3228 and RK3229, this patch
>> adds a basic dtsi file which includes a new CPU opp table and PSCI
>> brought up support for RK3229.
>>
>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>> ---
>>   arch/arm/boot/dts/rk3229-evb.dts |   2 +-
>>   arch/arm/boot/dts/rk3229.dtsi    | 110 +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 111 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/arm/boot/dts/rk3229.dtsi
>>
>> diff --git a/arch/arm/boot/dts/rk3229-evb.dts b/arch/arm/boot/dts/rk3229-evb.dts
>> index 1b55192..82e8a53 100644
>> --- a/arch/arm/boot/dts/rk3229-evb.dts
>> +++ b/arch/arm/boot/dts/rk3229-evb.dts
>> @@ -40,7 +40,7 @@
>>   
>>   /dts-v1/;
>>   
>> -#include "rk322x.dtsi"
>> +#include "rk3229.dtsi"
>>   
>>   / {
>>   	model = "Rockchip RK3229 Evaluation board";
>> diff --git a/arch/arm/boot/dts/rk3229.dtsi b/arch/arm/boot/dts/rk3229.dtsi
>> new file mode 100644
>> index 0000000..d43d133
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/rk3229.dtsi
>> @@ -0,0 +1,110 @@
>> +/*
>> + * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This library is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License as
>> + *     published by the Free Software Foundation; either version 2 of the
>> + *     License, or (at your option) any later version.
>> + *
>> + *     This library is distributed in the hope that it will be useful,
>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *     GNU General Public License for more details.
>> + *
>> + *  Or, alternatively,
>> + *
>> + *  b) Permission is hereby granted, free of charge, to any person
>> + *     obtaining a copy of this software and associated documentation
>> + *     files (the "Software"), to deal in the Software without
>> + *     restriction, including without limitation the rights to use,
>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> + *     sell copies of the Software, and to permit persons to whom the
>> + *     Software is furnished to do so, subject to the following
>> + *     conditions:
>> + *
>> + *     The above copyright notice and this permission notice shall be
>> + *     included in all copies or substantial portions of the Software.
>> + *
>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + *     OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +#include "rk322x.dtsi"
>> +
>> +/ {
>> +	compatible = "rockchip,rk3229";
>> +
>> +	/delete-node/ opp-table0;
>> +
>> +	cpu0_opp_table: opp_table0 {
>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp-408000000 {
>> +			opp-hz = /bits/ 64 <408000000>;
>> +			opp-microvolt = <950000>;
>> +			clock-latency-ns = <40000>;
>> +			opp-suspend;
>> +		};
>> +		opp-600000000 {
>> +			opp-hz = /bits/ 64 <600000000>;
>> +			opp-microvolt = <975000>;
>> +		};
>> +		opp-816000000 {
>> +			opp-hz = /bits/ 64 <816000000>;
>> +			opp-microvolt = <1000000>;
>> +		};
>> +		opp-1008000000 {
>> +			opp-hz = /bits/ 64 <1008000000>;
>> +			opp-microvolt = <1175000>;
>> +		};
>> +		opp-1200000000 {
>> +			opp-hz = /bits/ 64 <1200000000>;
>> +			opp-microvolt = <1275000>;
>> +		};
>> +		opp-1296000000 {
>> +			opp-hz = /bits/ 64 <1296000000>;
>> +			opp-microvolt = <1325000>;
>> +		};
>> +		opp-1392000000 {
>> +			opp-hz = /bits/ 64 <1392000000>;
>> +			opp-microvolt = <1375000>;
>> +		};
>> +		opp-1464000000 {
>> +			opp-hz = /bits/ 64 <1464000000>;
>> +			opp-microvolt = <1400000>;
>> +		};
>> +	};
>> +
>> +	psci {
>> +		compatible = "arm,psci-1.0", "arm,psci-0.2";
>> +		method = "smc";
>> +	};
>> +};
>> +
>> +&cpu0 {
>> +	enable-method = "psci";
>> +};
> Hmm, I don't really understand this.
> What method of core-bringup does the rk3228 use? In the current
> rk322x.dtsi there is no enable-method at all defined.

For non-security, the same with rk3036 SoC, we use rk3036-smp method to 
bring-up cores, and for security, we use arm-psci method.
As security become more and more important and required, we would prefer 
using arm-psci method, and it is also an easy way to use.

> So is the rk3228 firmware using a different method than the rk3229?

No, they are the same. How about I move these changes to rk322x.dtsi?

> And out of curiosity as this is a arm32 without atf, is the psci
> implementation (for uboot?) you're using available somewhere?

Ah, it is included in op-tee :-)


BR.
Frank

>
> Thanks
> Heiko
>
>> +
>> +&cpu1 {
>> +	enable-method = "psci";
>> +};
>> +
>> +&cpu2 {
>> +	enable-method = "psci";
>> +};
>> +
>> +&cpu3 {
>> +	enable-method = "psci";
>> +};
>>
>

