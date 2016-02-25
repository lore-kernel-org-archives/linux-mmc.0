From: Vishal Thanki <vishalthanki@gmail.com>
Subject: Re: omap_hsmmc: sdio: issue with generic wakeup IRQ handling
Date: Thu, 25 Feb 2016 13:18:34 +0100
Message-ID: <CAC3a_SCuuhgZuLiKgmJZ1bOcjVbA2pyLbhOnU=T3=C+zBEQiOw@mail.gmail.com>
References: <20160218182750.GA5948@c50.bag.software> <CALtMJEBdXLef8AJ1-8Txmg2iS413bVV7cpQSb+nL5M7jN_QYzw@mail.gmail.com>
 <20160219141135.GA14354@c50.bag.software> <CAC3a_SDH3zspEAUHkGN0qCBKQZBdnhmei2Rqw2Md=7R2iXostA@mail.gmail.com>
 <56CEDB90.6040708@ti.com> <20160225111813.GA19506@c50.bag.software> <56CEE9C1.2050207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:35592 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760548AbcBYMSz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Feb 2016 07:18:55 -0500
In-Reply-To: <56CEE9C1.2050207@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Andreas Fenkart <afenkart@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-omap@vger.kernel.org

On Thu, Feb 25, 2016 at 12:47 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
> On 02/25/2016 01:18 PM, Vishal Thanki wrote:
>
> [...]
>
>
>>>
>>> Suspend or Runtime suspend?
>>
>>
>> The it is the runtime suspend routine for omap_hsmmc.c
>>
>>         mmc1_pins: pinmux_mmc1_pins {
>>                 pinctrl-single,pins = <
>>                         0x0fc 0x38      /* MMC0_DAT0 */
>>                         0x0f8 0x38      /* MMC0_DAT1 */
>>                         0x0f4 0x38      /* MMC0_DAT2 */
>>                         0x0f0 0x38      /* MMC0_DAT3 */
>>                         0x100 0x38      /* MMC0_CLK */
>>                         0x104 0x38      /* MMC0_CMD */
>>                         0x88  0x07      /* GPMC_CSN3 -> GPIO2_0 */
>>                 >;
>>         };
>>
>>         mmc1_sleep_pins: pinmux_mmc1_sleep_pins {
>>                 pinctrl-single,pins = <
>>                         0x0fc 0x3f      /* MMC0_DAT0 */
>>                         0x0f8 0x3f      /* MMC0_DAT1 */
>>                         0x0f4 0x3f      /* MMC0_DAT2 */
>>                         0x0f0 0x3f      /* MMC0_DAT3 */
>>                         0x100 0x3f      /* MMC0_CLK */
>>                         0x104 0x3f      /* MMC0_CMD */
>>                         0x88  0x17      /* GPMC_CSN3 -> GPIO2_0 PULL UP */
>>                 >;
>>         };
>>
>>         mmc1_cirq_pin: pinmux_cirq_pin {
>>                 pinctrl-single,pins = <
>>                         0x0f8 0x3f      /* MMC0_DAT1 as GPIO2_28 */
>>                 >;
>>         };
>>
>>         wlan0_pwrseq: pwrseq {
>>                 compatible = "mmc-pwrseq-simple";
>>                 reset-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
>>                 clocks = <&clk_32768_ck>;
>>                 clock-names = "ext_clock";
>>         };
>>
>> &mmc1 {
>>         status = "okay";
>>         pinctrl-names = "default", "idle", "sleep";
>>         pinctrl-0 = <&mmc1_pins>;
>>         pinctrl-1 = <&mmc1_cirq_pin>;
>>         pinctrl-2 = <&mmc1_sleep_pins>;
>>         interrupts-extended = <&intc 64 &gpio2 28 0>;
>
>
> ^^ you can define IRQ type here
>
>  &gpio2 28 IRQ_TYPE_LEVEL_LOW
>

Thank you very much Grygorii for pointing it out.
With that change, I am not seeing any problem now.

Thanks,
Vishal



>>         ti,non-removable;
>>         bus-width = <4>;
>>         vmmc-supply = <&ldo2_reg>;
>>         vmmc_aux-supply = <&vmmc>;
>>         keep-power-in-suspend;
>>         enable-sdio-wakeup;
>>         mmc-pwrseq = <&wlan0_pwrseq>;
>> };
>>
>>
>>>
>>>>>
>>>>
>>>> Is there any other suggestion for mwifiex that I should try out? Or
>>>> is there any way in omap_hsmmc to specify the wakeup interrupt
>>>> type (IRQF_TRIGGER_LOW) while using generic wakeup IRQ
>>>> mechanism. I could not find it, but I may be missing something.
>>>
>>>
>>> How your irqs defined in DT? Could you provide mmc+wifi nodes?
>>
>>
>>
>>
>>>
>>>
>
> [..]
>
> --
> regards,
> -grygorii
