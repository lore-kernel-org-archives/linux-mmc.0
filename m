From: Zhangfei Gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Wed, 11 Dec 2013 13:55:10 +0800
Message-ID: <CAMj5BkjO0A=eC6vnjq4cTPHT2-J8=2h9B2+dqL=4VYnC7H2GGQ@mail.gmail.com>
References: <1383889128-12540-1-git-send-email-zhangfei.gao@linaro.org>
	<1383889128-12540-3-git-send-email-zhangfei.gao@linaro.org>
	<CAL_Jsq+r0QBHdx1XLRJ6SmppWFKe9qELtjMgjcQFSrU_F_RwHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:54584 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab3LKFzL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Dec 2013 00:55:11 -0500
In-Reply-To: <CAL_Jsq+r0QBHdx1XLRJ6SmppWFKe9qELtjMgjcQFSrU_F_RwHA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Kumar Gala <galak@codeaurora.org>, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Dear Rob

On Thu, Dec 5, 2013 at 10:29 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Thu, Nov 7, 2013 at 11:38 PM, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:

>> +++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>> @@ -0,0 +1,83 @@
>> +* Hisilicon specific extensions to the Synopsys Designware Mobile
>> +  Storage Host Controller
>> +
>> +Read synopsis-dw-mshc.txt for more details
>> +The Synopsys designware mobile storage host controller is used to interface
>> +a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
>> +differences between the core Synopsys dw mshc controller properties described
>> +by synopsis-dw-mshc.txt and the properties used by the Hisilicon specific
>> +extensions to the Synopsys Designware Mobile Storage Host Controller.
>> +
>> +Required Properties:
>> +
>> +* compatible: should be
>> +       - "hisilicon,hi4511-dw-mshc": for controllers with hi4511
>> +         specific extentions.
>> +* reg: should be address and size of mmc controller
>
> This should be covered by the base binding.
Yes, got it.

>
>> +* vmmc-supply: should be vmmc used in dwmmc
>> +* fifo-depth: should be provided if register can not provide correct value
>> +* tuning-table: should be array to tune mmc controller, including clock rate
>> +       to be set and values for setting optional register.
>
> Please define the size and what the values mean.
>
>> +
>> +Optional properties:
>> +
>> +/* These registers from pctrl node used for tuning mmc controller if required */
>> +* clken-reg: should be clock enable register and offset bit
>> +* drv-sel-reg: should be driver delay select register, start bit and bits numbers
>> +* sam-sel-reg: should be sample delay select register, start bit and bits numbers
>> +* div-reg: should be divider register, start bit and bits numbers
>
> Do these really vary on different boards or versions of the IP? If
> not, then put this information in the kernel.
>
> Otherwise, these need better description such as number of words and
> order of values.

Double checked these registers are not used in newer version.
Will follow Arnd's suggestion to abstract in clock.

>> +
>> +       /* Board portion */
>> +       dwmmc0@fcd03000 {
>> +               num-slots = <1>;
>> +               vmmc-supply = <&ldo12>;
>> +               fifo-depth = <0x100>;
>> +               supports-highspeed;
>
> Please reference that the binding uses standard SD properties (state
> which binding document).
Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt is used for
base doc describing supports-highspeed.

>
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&sd_pmx_pins &sd_cfg_func1 &sd_cfg_func2>;
>> +               slot@0 {
>> +                       reg = <0>;
>> +                       bus-width = <4>;
>> +                       disable-wp;
>> +                       cd-gpios = <&gpio10 3 0>;
>> +               };
>> +       };
>> +
>> +PCTRL: Peripheral misc control register
>
> Is this only MMC control bits? Seems like this belongs in its own doc.
OK, will move out.

Thanks
