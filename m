From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] regulator: core: Ensure we are at least in bounds for
 our constraints
Date: Tue, 29 Mar 2016 20:05:34 +0200
Message-ID: <CAMuHMdXx_=LzH7w+9u=o3WZ-qVPqMA2LDCeanvdGs-ywXRCy_A@mail.gmail.com>
References: <1458587912-32665-1-git-send-email-broonie@kernel.org>
	<1458587912-32665-2-git-send-email-broonie@kernel.org>
	<56F0624C.8010004@gmail.com>
	<CAJKOXPd5h0Cq++OxdiXytNJH94PN4Kh_wM3M=p3JdU1m_qyFTA@mail.gmail.com>
	<CAJKOXPcBOT_8NOH-=sEHSP0Rc+=Dvz-aqVTsBTMKg-VNWqQotw@mail.gmail.com>
	<CAJAp7OgGQ3qm-_QhydvN0n6QeNoHFdso4zOk41qvVJhKNeRn8Q@mail.gmail.com>
	<20160327090859.GH5028@sirena.org.uk>
	<CAMuHMdXuy2TxACTcsgOpZvrJEeTSQbCgCUmS9PXfBhhZfgbBBA@mail.gmail.com>
	<20160329145823.GK2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:34005 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbcC2SFg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2016 14:05:36 -0400
In-Reply-To: <20160329145823.GK2350@sirena.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Bjorn Andersson <bjorn@kryo.se>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-renesas-soc@vger.kernel.org

On Tue, Mar 29, 2016 at 4:58 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Mar 29, 2016 at 02:00:52PM +0200, Geert Uytterhoeven wrote:
>> On Sun, Mar 27, 2016 at 11:08 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > The existing check in the patch should be an || not an ==, or possibly
>> > we should just not bother looking for min_uV at all.  I just pushed out
>> > a version of that, let's see how that goes.
>
>> Has the fix really been pushed out?
>
> Yes.
>
>> WARNING: CPU: 1 PID: 31 at drivers/regulator/core.c:2223
>> _regulator_disable+0x2c/0x128
>> unbalanced disables for SDHI0 VccQ
>
>> when booting on r8a7791/koelsch.
>
> This seems like a bug somewhere else in your code, we're looking at
> changes in the voltage setting code but this is an unbalanced disable.
>
>> I'm a bit confused by the discussion of "&&" vs. "||" vs. "==", but the
>> warnings do go away when using "!=", cfr. the whitespace-damaged patch below.
>
>>         /* Voltage change possible? */
>> -       if (constraints->min_uV && constraints->max_uV) {
>> +       if (constraints->min_uV != constraints->max_uV) {
>
> Do you have constraints that specify a maximum voltage but no minimum
> (which I'd say are broken), or constraints that are just plain wrong but
> are now being applied like specifying the entire range of the regulator?
> The above might be some follow on error handling from something that
> happened the change in handling of the constraints.  You need to look at
> what the relevant regulator constraints are...
>
> Previously both voltages needed to be non-zero and equal for anything to
> happen, now they only need to both be non-zero.

There are 3 regulators with equal constraints:

/regulator@0: constraints->min_uV = 3300000, constraints->max_uV = 3300000
/regulator@2: constraints->min_uV = 3300000, constraints->max_uV = 3300000
/regulator@4: constraints->min_uV = 3300000, constraints->max_uV = 3300000

and 3 with different constraints:

/regulator@1: constraints->min_uV = 1800000, constraints->max_uV = 3300000
/regulator@3: constraints->min_uV = 1800000, constraints->max_uV = 3300000
/regulator@5: constraints->min_uV = 1800000, constraints->max_uV = 3300000

For the first SDHI channel, these come from:

        vcc_sdhi0: regulator@0 {
                compatible = "regulator-fixed";

                regulator-name = "SDHI0 Vcc";
                regulator-min-microvolt = <3300000>;
                regulator-max-microvolt = <3300000>;

                gpio = <&gpio7 17 GPIO_ACTIVE_HIGH>;
                enable-active-high;
        };

        vccq_sdhi0: regulator@1 {
                compatible = "regulator-gpio";

                regulator-name = "SDHI0 VccQ";
                regulator-min-microvolt = <1800000>;
                regulator-max-microvolt = <3300000>;

                gpios = <&gpio2 12 GPIO_ACTIVE_HIGH>;
                gpios-states = <1>;
                states = <3300000 1
                          1800000 0>;
        };

        &sdhi0 {
                pinctrl-0 = <&sdhi0_pins>;
                pinctrl-names = "default";

                vmmc-supply = <&vcc_sdhi0>;
                vqmmc-supply = <&vccq_sdhi0>;
                cd-gpios = <&gpio6 6 GPIO_ACTIVE_LOW>;
                wp-gpios = <&gpio6 7 GPIO_ACTIVE_HIGH>;
                status = "okay";
        };

giving:

        sh_mobile_sdhi ee100000.sd: GPIO lookup for consumer cd
        sh_mobile_sdhi ee100000.sd: using device tree for GPIO lookup
        of_get_named_gpiod_flags: parsed 'cd-gpios' property of node
'/sd@ee100000[0]' - status (0)
        sh_mobile_sdhi ee100000.sd: Got CD GPIO
        sh_mobile_sdhi ee100000.sd: GPIO lookup for consumer wp
        sh_mobile_sdhi ee100000.sd: using device tree for GPIO lookup
        of_get_named_gpiod_flags: parsed 'wp-gpios' property of node
'/sd@ee100000[0]' - status (0)
        sh_mobile_sdhi ee100000.sd: Got WP GPIO
======> sh_mobile_sdhi ee100000.sd: could not set regulator OCR (-22)
        gpio_rcar e6055400.gpio: sense irq = 6, type = 3
        sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 clock rate 97 MHz

The line marked with the arrow is introduced by the changed check, and looks
to be the origin of the failure.

Later, the "unbalanced disables for SDHI0 VccQ" warning is triggered.
Probably the error path always disables the second regulator, even if it was
never enabled due an the earlier failure.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
