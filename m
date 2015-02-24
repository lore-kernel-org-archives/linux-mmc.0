From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH v2] mmc: dw_mmc: Don't start commands while busy
Date: Tue, 24 Feb 2015 12:20:16 +0100
Message-ID: <54EC5E70.40300@collabora.co.uk>
References: <1424464316-4397-1-git-send-email-dianders@chromium.org>	<54EB5658.6080004@collabora.co.uk> <CAD=FV=Uc+x=qAEmUwJ=ifq0n=5TqDuwmOAnFQ30gkz2GOdVcUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:48730 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbbBXLUX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Feb 2015 06:20:23 -0500
In-Reply-To: <CAD=FV=Uc+x=qAEmUwJ=ifq0n=5TqDuwmOAnFQ30gkz2GOdVcUQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hello Doug,

On 02/23/2015 08:45 PM, Doug Anderson wrote:
> On Mon, Feb 23, 2015 at 8:33 AM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
>>
>> Addy's "mmc: dw_mmc: fix bug that cause 'Timeout sending command" [0] patch
>> reset the controller if it was busy for more than 500ms while your patch
>> doesn't. I don't mean that your patch is not correct, I'm just mentioning
>> because calling dw_mci_ctrl_reset() does makes the command to succeed the
>> next time and I can see the SDIO devices enumerated in /sys/bus/sdio/devices:
>>
>> [    5.892124] dwmmc_exynos 12210000.mmc: Busy; trying anyway
>> [    5.892135] mmc_host mmc2: Timeout sending command (cmd 0x202000 arg 0x0 status 0x0)
>> [    5.913885] mmc2: new high speed SDIO card at address 0001
>> [    6.582133] dwmmc_exynos 12210000.mmc: Busy; trying anyway
> 
> Hmmmmm.  In the cases I was seeing I didn't need the "reset" since the
> "SDMMC_CMD_UPD_CLK" was the one from dw_mci_set_ios() and my patch:
> 
> * mmc: dw_mmc: Give a good reset after we give power
>   https://patchwork.kernel.org/patch/5858281/
> 
> ...gave the needed reset after vqmmc power was applied.  Then dw_mmc
> never got wedged and didn't need the reset to get it unwedged.  In
> your care you're getting called from dw_mci_init_card().  That should
> happen _after_ dw_mci_set_ios() as far as I know.  Can you put a
> printout in the reset in dw_mci_set_ios() and make sure it runs?
>

Added a printout in dw_mci_set_ios() and I see that the card is reset
at MMC_POWER_ON. So you are right that it gets wedged somehow between
dw_mci_set_ios() and dw_mci_init_card().

This only happens when the slot is attached to a SDIO device though
since the controller neither gets busy nor a command timeouts for
the eMMC and uSD.

> How many resets do you need before things work?  If just one then
> something must be happening between the initial "set_ios" and the

The card is reseted 3 times to make it "work", that is to avoid being
blocked constantly with "Timeout sending command" errors. But as I said
before, even when the reset in dw_mci_wait_while_busy(), the firmware
fails to load into the WiFi module so is not in the best state.

> "init_card".  Any chance you could figure out what that is?  If it
> needs multiple resets then it seems like something is fishy...
>

Sure, I'll investigate more what happens between dw_mci_set_ios()
and dw_mci_init_card(). Thanks for the suggestion.

> 
>> but that reset may not be right since the WiFi chip does not work because
>> the firmware later fails to load:
>>
>> [  240.273352] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  240.281159] kworker/2:1     D c04b3340     0  1260      2 0x00000000
>> [  240.287487] Workqueue: events request_firmware_work_func
>> [  240.292763] [<c04b3340>] (__schedule) from [<c04b36f0>] (schedule+0x34/0x98)
>> [  240.299815] [<c04b36f0>] (schedule) from [<c04b7198>] (schedule_timeout+0x120/0x16c)
>> [  240.307537] [<c04b7198>] (schedule_timeout) from [<c04b41b4>] (wait_for_common+0xb0/0x154)
>> [  240.315783] [<c04b41b4>] (wait_for_common) from [<c037abb8>] (mmc_wait_for_req+0xa0/0x140)
>> [  240.324020] [<c037abb8>] (mmc_wait_for_req) from [<c0384b04>] (mmc_io_rw_extended+0x304/0x34c)
>> [  240.332607] [<c0384b04>] (mmc_io_rw_extended) from [<c0385a90>] (sdio_io_rw_ext_helper+0x138/0x1a4)
>> [  240.341630] [<c0385a90>] (sdio_io_rw_ext_helper) from [<c0385b1c>] (sdio_writesb+0x20/0x28)
>> [  240.349962] [<c0385b1c>] (sdio_writesb) from [<c02e60d4>] (mwifiex_write_data_sync+0x4c/0x80)
>> [  240.358460] [<c02e60d4>] (mwifiex_write_data_sync) from [<c02e68e4>] (mwifiex_prog_fw_w_helper+0x1b0/0x2c4)
>> [  240.368176] [<c02e68e4>] (mwifiex_prog_fw_w_helper) from [<c02c7d6c>] (mwifiex_dnld_fw+0x58/0x10c)
>> [  240.377127] [<c02c7d6c>] (mwifiex_dnld_fw) from [<c02c5f10>] (mwifiex_fw_dpc+0x264/0x408)
>> [  240.385263] [<c02c5f10>] (mwifiex_fw_dpc) from [<c0291b28>] (request_firmware_work_func+0x30/0x50)
>> [  240.394200] [<c0291b28>] (request_firmware_work_func) from [<c0032ae8>] (process_one_work+0x120/0x324)
>> [  240.403482] [<c0032ae8>] (process_one_work) from [<c0032e58>] (worker_thread+0x138/0x464)
>> [  240.411635] [<c0032e58>] (worker_thread) from [<c0037470>] (kthread+0xd8/0xf4)
>> [  240.418837] [<c0037470>] (kthread) from [<c000e680>] (ret_from_fork+0x14/0x34)
>>
>> The DTS changes on top of linux-next to add WiFi support is [1] in case you can
>> find something that is wrong with my patch.
> 
> I still haven't had time to try using the new MMC power sequencing :(
> so I can't say for sure, but one thought below...
> 
> 
>> I also checked that the external reference clock for the WiFi module is enabled
>> correctly according to /sys/kernel/debug/clk/clk_summary and also by looking
>> at the value in the max77802 i2c register address that enables that clock.
>>
>> Any hints will be highly appreciated.
>>
>> Thanks a lot and best regards,
>> Javier
>>
>> [0]: https://lkml.org/lkml/2015/2/5/222
>> [1]:
>> From ced0974472d109019e1ee551a6dd08f16ae5cfc2 Mon Sep 17 00:00:00 2001
>> From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Date: Mon, 23 Feb 2014 15:42:15 +0100
>> Subject: [PATCH] ARM: dts: Add Peach Pit board WiFi support
>>
>> Peach boards have an SDIO WiFi module that is always powered but it
>> needs a power sequence involving the reset and enable pins and also
>> a 32kHz reference clock.
>>
>> Add a dev node for the SDIO slot and the MMC power sequence provider.
>>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>>  arch/arm/boot/dts/exynos5420-peach-pit.dts | 59 ++++++++++++++++++++++++++++++
>>  1 file changed, 59 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
>> index ec86d9523935..26df041e46e7 100644
>> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
>> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
>> @@ -125,6 +125,14 @@
>>                         };
>>                 };
>>         };
>> +
>> +       mmc1_pwrseq: mmc1_pwrseq {
>> +               compatible = "mmc-pwrseq-simple";
>> +               reset-gpios = <&gpx0 1 GPIO_ACTIVE_LOW>, /* WIFI_RSTn */
>> +                             <&gpx0 0 GPIO_ACTIVE_LOW>; /* WIFI_EN */
> 
> Any chance you want "WIFI_EN" to actually be specified as "vmmc" for
> the slot?  ...possibly with a 'regulator-enable-ramp-delay' specified?
>  I know that with SD Cards on an rk3288 board I needed to make sure
> there was a bit of delay after "vqmmc" came up...
>

If that's the case then we would had a bug in the MMC power sequencing
support but I don't think that is needed because there is a mmc_delay(10)
in mmc_power_up() between mmc_pwrseq_pre_power_on() and mmc_set_ios().

But just in case, I tried removing the "reset-gpios" property and adding
"WIFI_EN" as a fixed regulator with a "regulator-enable-ramp-delay" but
the behavior is the same.

> BTW: IIRC the "WIFI_RSTn" ended up being totally unused.  It was used
> in earlier revs of the board that had a different rev of the WiFi
> chip...
>

You are right, I removed WIFI_RSTn and the SDIO devices are still enumerated.

>> +               clocks = <&max77802 MAX77802_CLK_32K_CP>;
>> +               clock-names = "ext_clock";
>> +       };
>>  };
>>
>>  &adc {
>> @@ -691,6 +699,24 @@
>>         bus-width = <8>;
>>  };
>>
>> +&mmc_1 {
>> +       status = "okay";
>> +       num-slots = <1>;
>> +       broken-cd;
>> +       cap-sdio-irq;
>> +       card-detect-delay = <200>;
>> +       clock-frequency = <400000000>;
>> +       samsung,dw-mshc-ciu-div = <1>;
>> +       samsung,dw-mshc-sdr-timing = <0 1>;
> 
> Just for kicks, does this help if you do:
> 
> ciu-div = 3
> sdr-timing = 2 3
> 
> ...I know we have ciu-div = 1 downstream, but we also have tuning...
>

This makes it even worst since with those values the boot hangs after a
"Timeout sending command" error even with the reset in wait while busy.

>> +       samsung,dw-mshc-ddr-timing = <0 2>;
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&sd1_clk>, <&sd1_cmd>, <&sd1_int>, <&sd1_bus4>,
>> +                   <&sd1_bus8>, <&wifi_en>, <&wifi_rst>;
>> +       bus-width = <4>;
>> +       cap-sd-highspeed;
>> +       mmc-pwrseq = <&mmc1_pwrseq>;
> 
> Should you be specifying a "vqmmc-supply" here?  I know that we don't
> change voltages for WiFi (starts at 1.8V and ends up at 1.8V) but
> still might be good to specify it...
>

Sure, I added a "vqmmc-supply = <&buck10_reg>" here. It does not have an
effect though but is true that is better to specify it.

Best regards,
Javier
