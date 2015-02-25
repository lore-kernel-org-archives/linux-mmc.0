From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] mmc: dw_mmc: Don't start commands while busy
Date: Tue, 24 Feb 2015 21:43:11 -0800
Message-ID: <CAD=FV=WqbOWQtFCXe+2wOpHOB1puu0p01jbVBpwufg_9M65Crw@mail.gmail.com>
References: <1424464316-4397-1-git-send-email-dianders@chromium.org>
	<54EB5658.6080004@collabora.co.uk>
	<CAD=FV=Uc+x=qAEmUwJ=ifq0n=5TqDuwmOAnFQ30gkz2GOdVcUQ@mail.gmail.com>
	<54EC5E70.40300@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54EC5E70.40300@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Javier,

On Tue, Feb 24, 2015 at 3:20 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
>> Hmmmmm.  In the cases I was seeing I didn't need the "reset" since the
>> "SDMMC_CMD_UPD_CLK" was the one from dw_mci_set_ios() and my patch:
>>
>> * mmc: dw_mmc: Give a good reset after we give power
>>   https://patchwork.kernel.org/patch/5858281/
>>
>> ...gave the needed reset after vqmmc power was applied.  Then dw_mmc
>> never got wedged and didn't need the reset to get it unwedged.  In
>> your care you're getting called from dw_mci_init_card().  That should
>> happen _after_ dw_mci_set_ios() as far as I know.  Can you put a
>> printout in the reset in dw_mci_set_ios() and make sure it runs?
>>
>
> Added a printout in dw_mci_set_ios() and I see that the card is reset
> at MMC_POWER_ON. So you are right that it gets wedged somehow between
> dw_mci_set_ios() and dw_mci_init_card().

Actually, if your code needs 3 resets then maybe there's something else wrong...


> This only happens when the slot is attached to a SDIO device though
> since the controller neither gets busy nor a command timeouts for
> the eMMC and uSD.

It sounds like there's something else going on here.


>> How many resets do you need before things work?  If just one then
>> something must be happening between the initial "set_ios" and the
>
> The card is reseted 3 times to make it "work", that is to avoid being
> blocked constantly with "Timeout sending command" errors. But as I said
> before, even when the reset in dw_mci_wait_while_busy(), the firmware
> fails to load into the WiFi module so is not in the best state.

3 times?  ...but that doesn't make a lot of sense to me.  Is it simply
the delay that makes it work, or do you actually need the 3 resets?
Is anything else happening between all the resets?  I guess you keep
trying to send the command and resetting between?  Hrmmm...

Seems like there has got to be something else going on in this case...


>> BTW: IIRC the "WIFI_RSTn" ended up being totally unused.  It was used
>> in earlier revs of the board that had a different rev of the WiFi
>> chip...
>>
>
> You are right, I removed WIFI_RSTn and the SDIO devices are still enumerated.

I just checked.  WIFI_RSTn goes to the 3G connector which (as far as I
know) was never hooked up to anything.  ...so yeah, you can safely
leave that out.



>>> +&mmc_1 {
>>> +       status = "okay";
>>> +       num-slots = <1>;
>>> +       broken-cd;
>>> +       cap-sdio-irq;
>>> +       card-detect-delay = <200>;
>>> +       clock-frequency = <400000000>;
>>> +       samsung,dw-mshc-ciu-div = <1>;
>>> +       samsung,dw-mshc-sdr-timing = <0 1>;
>>
>> Just for kicks, does this help if you do:
>>
>> ciu-div = 3
>> sdr-timing = 2 3
>>
>> ...I know we have ciu-div = 1 downstream, but we also have tuning...
>>
>
> This makes it even worst since with those values the boot hangs after a
> "Timeout sending command" error even with the reset in wait while busy.

I don't have a pit or pi hooked up on my desk right now, but I will
try to give it a shot soon and see what it ends up at.  ...of course
you might still be at 400kHz mode in which case the divs just have to
not be totally wrong, I think...


>>> +       samsung,dw-mshc-ddr-timing = <0 2>;
>>> +       pinctrl-names = "default";
>>> +       pinctrl-0 = <&sd1_clk>, <&sd1_cmd>, <&sd1_int>, <&sd1_bus4>,
>>> +                   <&sd1_bus8>, <&wifi_en>, <&wifi_rst>;
>>> +       bus-width = <4>;
>>> +       cap-sd-highspeed;
>>> +       mmc-pwrseq = <&mmc1_pwrseq>;
>>
>> Should you be specifying a "vqmmc-supply" here?  I know that we don't
>> change voltages for WiFi (starts at 1.8V and ends up at 1.8V) but
>> still might be good to specify it...
>>
>
> Sure, I added a "vqmmc-supply = <&buck10_reg>" here. It does not have an
> effect though but is true that is better to specify it.

Yeah, makes sense.

---

OK, so looking through things I _think_ I found another difference
that _might_ matter...

Upstream (arch/arm/boot/dts/exynos5420-pinctrl.dtsi):
                sd1_bus1: sd1-bus-width1 {
                        samsung,pins = "gpc1-3";
                        ...
                };

                sd1_bus4: sd1-bus-width4 {
                        samsung,pins = "gpc1-4", "gpc1-5", "gpc1-6";
                        ...
               };

                sd1_bus8: sd1-bus-width8 {
                        samsung,pins = "gpd1-4", "gpd1-5", "gpd1-6", "gpd1-7";
                        ...
               };

Upsttream (arch/arm/boot/dts/exynos5420-peach-pit.dts) -- your patch:
       pinctrl-0 = <&sd1_clk>, <&sd1_cmd>, <&sd1_int>, <&sd1_bus4>,
                   <&sd1_bus8>, <&wifi_en>, <&wifi_rst>;

Downstream (arch/arm/boot/dts/exynos542x-pinctrl.dtsi):
                sd1_bus1: sd1-bus-width1 {
                        samsung,pins = "gpc1-3";
                        ...
               };

                sd1_bus4: sd1-bus-width4 {
                        samsung,pins = "gpc1-3", "gpc1-4", "gpc1-5", "gpc1-6";
                        ...
               };

                sd1_bus8: sd1-bus-width8 {
                        samsung,pins = "gpd1-4", "gpd1-5", "gpd1-6", "gpd1-7";
                        ...
               };

Downstream (arch/arm/boot/dts/exynos542x-peach.dtsi):
                pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_int &sd1_bus4 &sd1_bus8>;


Notice the difference?  You need to add "sd1_bus1" to the pinctrl for
upstream.  The upstream DTS makes more sense.  I think I remember
discussing this in the past (finding the conversation on the lists is
left as an exercise to the reader) and you can in fact see that the
upstream 5250 pinctrl file is like the downstream 5420 pinctrl...

I think the same bug is present in eMMC and SD but possibly the
bootloader inits the pinctrl properly there?


Crossing my fingers that's your bug, but I can't say for sure why
adding a tons of resets would somehow make it better?

-Doug
