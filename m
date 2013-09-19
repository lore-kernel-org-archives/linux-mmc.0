From: =?UTF-8?B?SmnFmcOtIFByY2hhbA==?= <jiri.prchal@aksignal.cz>
Subject: Re: [PATCH] at91: mmc: fix missing pinctrl in dt
Date: Thu, 19 Sep 2013 15:24:54 +0200
Message-ID: <523AFB26.9030701@aksignal.cz>
References: <1379411857-18516-1-git-send-email-jiri.prchal@aksignal.cz>
 <1379411857-18516-2-git-send-email-jiri.prchal@aksignal.cz>
 <523AFA48.80606@atmel.com>
Reply-To: jiri.prchal@aksignal.cz
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <523AFA48.80606@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, ludovic.desroches@atmel.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

OK.

Dne 19.9.2013 15:21, Nicolas Ferre napsal(a):
> On 17/09/2013 11:57, Jiri Prchal :
>> This patch adds pinctrl to soc dtsi file.
>>
>> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
>
>
> Jiri,
>
> I will rework your patch by splitting the two lines. This will allow us to be consistent with other AT91 SoC/boards
> Device Tree descriptions.
>
> +        pinctrl-names = "default";
>
> This one is going in the SoC file, like you did.
>
> +        pinctrl-0 = <&pinctrl_mmc0_slot0_clk_cmd_dat0>;
>
> This one is under the responsibility of the board itself. The reason behind this is that the dat0 line can be
> multiplexed on another pin.
>
> So, if you need a particular pinctrl configuration on the board side, please send another patch for this addition.
>
> Thanks bye,
>
>
>> ---
>>   arch/arm/boot/dts/at91sam9x5.dtsi |    2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
>> index cf78ac0..c5d26b0 100644
>> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
>> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
>> @@ -556,6 +556,8 @@
>>                   interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
>>                   dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(0)>;
>>                   dma-names = "rxtx";
>> +                pinctrl-names = "default";
>> +                pinctrl-0 = <&pinctrl_mmc0_slot0_clk_cmd_dat0>;
>>                   #address-cells = <1>;
>>                   #size-cells = <0>;
>>                   status = "disabled";
>>
>
>
