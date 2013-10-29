From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Tue, 29 Oct 2013 00:02:25 -0700
Message-ID: <CAMj5Bkhd1+JJV88ec7UNz2sK7DpugfK3MAgFxTiEgFx9FawTsw@mail.gmail.com>
References: <1382339639-16764-3-git-send-email-zhangfei.gao@linaro.org>
	<1382533396-6584-1-git-send-email-zhangfei.gao@linaro.org>
	<0D287D95-C302-4A59-98AC-C654F5AC97B4@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:42079 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476Ab3J2HC0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Oct 2013 03:02:26 -0400
In-Reply-To: <0D287D95-C302-4A59-98AC-C654F5AC97B4@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Haojian Zhuang <haojian.zhuang@linaro.org>

Dear Kumar

Thanks for the careful review.

On Sun, Oct 27, 2013 at 11:29 PM, Kumar Gala <galak@codeaurora.org> wrote:
>
> On Oct 23, 2013, at 8:03 AM, Zhangfei Gao wrote:
>

>> +Required Properties:
>> +
>> +* compatible: should be
>> +     - "hisilicon,hi4511-dw-mshc": for controllers with hi4511
>> +       specific extentions.
>> +* vmmc-supply: should be vmmc used in dwmmc
>> +* fifo-depth: should be provided if register can not provide correct value
>> +* clken-reg: should be clock enable register and offset
>> +* drv-sel-reg: should be driver delay select register, offset and bits
>> +* sam-sel-reg: should be sample delay select register, offset and bits
>> +* div-reg: should be divider register, offset and bits
>> +* tune-table: should be array of clock tune mmc controller
>> +
>
> 1. These should have vendor prefixes
However Olof and Mark once suggested not using prefix if vector is
internally used.

Example before:
> + - #hisilicon,clkdiv-table-cells : the number of parameters after phandle in
> +   hisilicon,clkdiv-table property.
> + - hisilicon,clkdiv-table : list of value that are used to configure clock

Olof:
For a binding that is your own, you don't need to prefix the properties.
Prefixes are mostly used when adding new vendor-specific attributes to a common
binding.

Mark:
People seem to be *very* keen on adding them for all bindings for some
reason.

> 2. why do we need the *-reg properties
> 3. for the *-reg properties its not clear what bits means?

The silicon has some limitaiton to tune the clock timing according to
working mode,
including driver delay, sample delay, and divider.
If not set even the host register may not read out.
The register in PCTRL described below,
And one register may contains sereral usage,
for example
mmc0: 0x1f8: bit 0 is clock en/dis, bit 1 ~ bit 3 controls div, bit
4~7 controls drv-sel, bit 8 ~11 controls sam-sel
mmc1: 0x1f8: bit 12 ~~
register, offset and bits stands for 0x1f8, start bit and how many bits.
Is this fine?


> 4. tune-table is not well described, what does 'clock tune' mean, why an array?
Will change to  "tuning-table"
It is values used for computing these div, drv, sample register,
Also contains system clock need to be set, and output clock output
after PCTRL control.

>
>
>> +Example:
>> +
>> +  The MSHC controller node can be split into two portions, SoC specific and
>> +  board specific portions as listed below.
>> +
>
> Does dtc merge this all into a single node?  Would probably be good to have comments
> in the example stating both that the merge into one node, and which is board and which
> is soc.
OK, will add comments to distinguish dtsi for soc and dts for board.

>
>> +     dwmmc_0: dwmmc0@fcd03000 {
>> +             compatible = "hisilicon,hi4511-dw-mshc";
>> +             reg = <0xfcd03000 0x1000>;
>> +             interrupts = <0 16 4>;
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +             clocks = <&clk_sd>, <&clk_ddrc_per>;
>> +             clock-names = "ciu", "biu";
>> +             clken-reg = <0x1f8 0>;
>> +             drv-sel-reg = <0x1f8 4 4>;
>> +             sam-sel-reg = <0x1f8 8 4>;
>> +             div-reg = <0x1f8 1 3>;
>> +             tune-table =
>> +             <180000000 6 6 13 13 25000000>,
>> +             <0 0 0 0 0 0>,
>> +             <360000000 6 4 2 0 50000000>,
>> +             <180000000 6 4 13 13 25000000>,
>> +             <360000000 6 4 2 0 50000000>,
>> +             <720000000 6 1 9 4 100000000>,
>> +             <0 0 0 0 0 0>,
>> +             <360000000 7 1 3 0 50000000>;
>> +     };
>> +     dwmmc0@fcd03000 {
>> +             num-slots = <1>;
>> +             vmmc-supply = <&ldo12>;
>> +             fifo-depth = <0x100>;
>> +             supports-highspeed;
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&sd_pmx_pins &sd_cfg_func1 &sd_cfg_func2>;
>> +             slot@0 {
>> +                     reg = <0>;
>> +                     bus-width = <4>;
>> +                     disable-wp;
>> +                     cd-gpios = <&gpio10 3 0>;
>> +             };
>> +     };
>> +
>> +PCTRL:
>> +
>
> should have a description
OK.

>
>> +Required Properties:
>> +* compatible: should be
>> +     - "hisilicon,pctrl": Peripheral control
>> +
>
> Reg is not described as a required property.
OK.

>
>> +Example:
>> +
>> +     pctrl: pctrl@fca09000 {
>> +             compatible = "hisilicon,pctrl";
>> +             reg = <0xfca09000 0x1000>;
>> +     };
>
> This should be in its own binding document, and not part of the mmc binding
bindings/arm/hisilicon/hisilicon.txt still not been merged in another
patch, where
we want to push such desc as well as other system binding.
Is it OK adding this node desc twice in two files, since mmc need such node.
or move this desc after hisilicon.txt get merged for saving conflict?

Thanks
