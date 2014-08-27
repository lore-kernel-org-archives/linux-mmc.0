From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH v14 1/6] mmc: omap_hsmmc: Enable SDIO interrupt
Date: Wed, 27 Aug 2014 09:53:19 +0200
Message-ID: <53FD8E6F.1060003@epfl.ch>
References: <1401352085-22781-1-git-send-email-afenkart@gmail.com> <1401352085-22781-2-git-send-email-afenkart@gmail.com> <53F9A1B5.2080409@epfl.ch> <20140824184102.GF17254@atomide.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20140824184102.GF17254@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andreas Fenkart <afenkart@gmail.com>, Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, Andreas Mueller <schnitzeltony@googlemail.com>, Sebastian Reichel <sre@kernel.org>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Tony, Andreas,

On 08/24/2014 08:41 PM, Tony Lindgren wrote:
> * Florian Vaussard <florian.vaussard@epfl.ch> [140824 01:29]:
>> --- a/arch/arm/boot/dts/omap3-overo-base.dtsi
>> +++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
>> @@ -119,7 +119,7 @@
>>  			OMAP3_CORE1_IOPAD(0x2158, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_clk.sdmmc2_clk */
>>  			OMAP3_CORE1_IOPAD(0x215a, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_cmd.sdmmc2_cmd */
>>  			OMAP3_CORE1_IOPAD(0x215c, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat0.sdmmc2_dat0 */
>> -			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat1.sdmmc2_dat1 */
>> +			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | PIN_OFF_WAKEUPENABLE | MUX_MODE0)		/* sdmmc2_dat1.sdmmc2_dat1 */
>>  			OMAP3_CORE1_IOPAD(0x2160, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat2.sdmmc2_dat2 */
>>  			OMAP3_CORE1_IOPAD(0x2162, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat3.sdmmc2_dat3 */
>>  		>;
> 
> No need to have PIN_OFF_WAKEUPENABLE any longer here, it gets
> enabled automatically after you do request_irq on it.
> 

Good to know.

>> @@ -195,6 +195,9 @@
>>  	vmmc_aux-supply = <&w3cbw003c_wifi_nreset>;
>>  	bus-width = <4>;
>>  	cap-sdio-irq;
>> +	
>> +	interrupts-extended = <&intc 86>,
>> +			      <&gpio5 5 GPIO_ACTIVE_HIGH>; /* gpio_133 (mmc2.dat1) */
>>  	non-removable;
>>  };
> 
> The second interrupt here just needs to be &omap3_pmx_core
> (or &omap3_pmx_core2 depending where it's located) with the
> offset to the dat1 pin from it's padconf area. For example,
> on mmc3 it should be:
> 
> interrupts-extended = <&intc 94 &omap3_pmx_core2 0x46>;
> 
> So you need to look it up from the TRM to figure out the right
> offset for mmc2.
>   

So now I have:

interrupts-extended = <
	&intc 86
	&omap3_pmx_core OMAP_IOPAD_OFFSET(0x215e, 0x2030)>;

I checked that I have the right offset in the .dtb for mmc2_dat according
to the TRM (0x12E). But the wake-up path seems to be not working any more.
I get several timeouts and a BUG() inside libertas SDIO driver.

[   16.286407] libertas_sdio mmc0:0001:1 (unregistered net_device): 00:19:88:15:b7:c0, fw 9.70.3p24, cap 0x00000303
[   16.292938] libertas_sdio mmc0:0001:1 wlan0: Marvell WLAN 802.11 adapter
[   16.302703] cfg80211: Calling CRDA to update world regulatory domain
[   24.758880] libertas_sdio mmc0:0001:1 wlan0: command 0x0006 timed out
[   24.759582] libertas_sdio mmc0:0001:1 wlan0: Timeout submitting command 0x0006
[   24.761962] libertas_sdio mmc0:0001:1 wlan0: PREP_CMD: command 0x0006 failed: -110
[   24.762084] libertas_sdio: Resetting card...
[   29.768890] libertas_sdio mmc0:0001:1 wlan0: command 0x0006 timed out
[   29.769378] libertas_sdio mmc0:0001:1 wlan0: Timeout submitting command 0x0006
[   29.769531] libertas_sdio mmc0:0001:1 wlan0: PREP_CMD: command 0x0006 failed: -110
[   29.770538] ------------[ cut here ]------------
[   29.775421] kernel BUG at drivers/net/wireless/libertas/if_sdio.c:226!
[   29.782287] Internal error: Oops - BUG: 0 [#1] PREEMPT ARM
[   29.788055] Modules linked in:
[   29.791290] CPU: 0 PID: 471 Comm: ksdioirqd/mmc0 Not tainted 3.16.1mobovero-00014-g9e1602f-dirty #690
[   29.800994] task: dd81c480 ti: def48000 task.ti: def48000
[   29.806671] PC is at if_sdio_interrupt+0x1b4/0x330
[   29.811737] LR is at if_sdio_interrupt+0x194/0x330
[   29.816772] pc : [<c0428e68>]    lr : [<c0428e48>]    psr: 200e0093
[   29.816772] sp : def49ed0  ip : def49ed0  fp : def49efc
[   29.828826] r10: 00000000  r9 : 00000000  r8 : dece0024
[   29.834320] r7 : 0000016e  r6 : 00000001  r5 : 800e0013  r4 : decc43c0
[   29.841186] r3 : 0000051b  r2 : 000003b3  r1 : 00000001  r0 : 00000001
[   29.848052] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[   29.855834] Control: 10c5387d  Table: 9edd4019  DAC: 00000015
[   29.861877] Process ksdioirqd/mmc0 (pid: 471, stack limit = 0xdef48240)
[   29.868835] Stack: (0xdef49ed0 to 0xdef4a000)
[   29.873413] 9ec0:                                     00000000 00000000 c04d82b0 00000001
[   29.882019] 9ee0: df4c9000 dec7f400 00000000 00000001 def49f34 def49f00 c04d010c c0428cc0
[   29.890624] 9f00: 00100100 00200200 def49f34 dec7f400 def48000 dec7f400 def48000 7fffffff
[   29.899230] 9f20: 00000000 00000001 def49f64 def49f38 c04d02f8 c04d00d4 c04d024c 00000001
[   29.907836] 9f40: 00000000 dd9bda40 00000000 dec7f400 c04d024c 00000000 def49fac def49f68
[   29.916442] 9f60: c005c724 c04d0258 def49f94 00000000 c0066e50 dec7f400 00000000 def49f7c
[   29.925048] 9f80: def49f7c 00000000 def49f88 def49f88 dd9bda40 c005c644 00000000 00000000
[   29.933654] 9fa0: 00000000 def49fb0 c000f1a8 c005c650 00000000 00000000 00000000 00000000
[   29.942260] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   29.950866] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[   29.959503] [<c0428e68>] (if_sdio_interrupt) from [<c04d010c>] (process_sdio_pending_irqs+0x44/0x184)
[   29.969207] [<c04d010c>] (process_sdio_pending_irqs) from [<c04d02f8>] (sdio_irq_thread+0xac/0x1d8)
[   29.978729] [<c04d02f8>] (sdio_irq_thread) from [<c005c724>] (kthread+0xe0/0xf4)
[   29.986511] [<c005c724>] (kthread) from [<c000f1a8>] (ret_from_fork+0x14/0x20)
[   29.994140] Code: e283300a e7942103 e3520000 0a000000 (e7f001f2) 
[   30.000549] ---[ end trace 7fc618cf4aa9adbc ]---
[   30.005401] note: ksdioirqd/mmc0[471] exited with preempt_count 1
[   30.280792] init: tty1 main process (849) killed by TERM signal
[   32.778930] libertas_sdio mmc0:0001:1 wlan0: command 0x0010 timed out
[   32.785827] libertas_sdio mmc0:0001:1 wlan0: Timeout submitting command 0x0010

>> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
>> index b2891a9..1347bc9 100644
>> --- a/arch/arm/boot/dts/omap3.dtsi
>> +++ b/arch/arm/boot/dts/omap3.dtsi
>> @@ -417,7 +417,6 @@
>>  		mmc2: mmc@480b4000 {
>>  			compatible = "ti,omap3-hsmmc";
>>  			reg = <0x480b4000 0x200>;
>> -			interrupts = <86>;
>>  			ti,hwmods = "mmc2";
>>  			dmas = <&sdma 47>, <&sdma 48>;
>>  			dma-names = "tx", "rx";
> 
> I think there's a patch now in mainline tree that by default tries
> to use interrupts-extended first, so this may not need to be
> changed.
> 

I based my tests on 3.16.1, this is why I had to do this.
I just tried with 3.17-rc2, same result.

Unfortunately, I do not have a lot of time to debug this issue for
now, but if you have ideas, I would be happy to test.

Regards
Florian
