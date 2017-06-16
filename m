From: Frank Wang <frank.wang@rock-chips.com>
Subject: Re: [PATCH 6/6] ARM: dts: rockchip: add efuse device node for rk3228
Date: Fri, 16 Jun 2017 17:24:23 +0800
Message-ID: <da5fbd76-c9a1-a16f-3ed8-adfd2b1c346f@rock-chips.com>
References: <1497510980-23207-1-git-send-email-frank.wang@rock-chips.com>
 <1497511396-23308-1-git-send-email-frank.wang@rock-chips.com>
 <2537345.MJmYY2BcSn@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2537345.MJmYY2BcSn@phil>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, gregkh@linuxfoundation.org
Cc: robh+dt@kernel.org, ulf.hansson@linaro.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, charles.chen@rock-chips.com, kevan.lan@rock-chips.com, huangtao@rock-chips.com, finley.xiao@rock-chips.com, david.wu@rock-chips.com, shawn.lin@rock-chips.com, wmc@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

Hi Heiko,

On 2017/6/15 23:10, Heiko Stuebner wrote:
> Hi Frank,
>
> Am Donnerstag, 15. Juni 2017, 15:23:16 CEST schrieb Frank Wang:
>> From: Finley Xiao <finley.xiao@rock-chips.com>
>>
>> Add a efuse node in the device tree for the rk3228 SoC.
>>
>> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
>> ---
>>   arch/arm/boot/dts/rk322x.dtsi | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
>> index c2a78f4..dad195e 100644
>> --- a/arch/arm/boot/dts/rk322x.dtsi
>> +++ b/arch/arm/boot/dts/rk322x.dtsi
>> @@ -314,6 +314,23 @@
>>   		status = "disabled";
>>   	};
>>   
>> +	efuse: efuse@11040000 {
>> +		compatible = "rockchip,rk322x-efuse";
> was this binding included already? Simply because compatibles should
> not contain placeholders, so rockchip,rk3228-efuse please - same for
> the driver side.

Actually, I always remember it should be without placeholders from the 
first time you commented :-)
but I saw that the binding and driver (rockchip,rk322x-efuse) have 
already been applied, so I send this one keep the same with driver side.
Shall I resend a new patch to correct both of them to 
'rockchip,rk3228-efuse' ?


BR.
Frank

>
> Heiko
>
>
>> +		reg = <0x11040000 0x20>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		clocks = <&cru PCLK_EFUSE_256>;
>> +		clock-names = "pclk_efuse";
>> +
>> +		/* Data cells */
>> +		efuse_id: id@7 {
>> +			reg = <0x7 0x10>;
>> +		};
>> +		cpu_leakage: cpu_leakage@17 {
>> +			reg = <0x17 0x1>;
>> +		};
>> +	};
>> +
>>   	i2c0: i2c@11050000 {
>>   		compatible = "rockchip,rk3228-i2c";
>>   		reg = <0x11050000 0x1000>;
>>
