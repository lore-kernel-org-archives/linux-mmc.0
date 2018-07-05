From: Stefan Agner <stefan@agner.ch>
Subject: Re: Self-detected stall on CPU when using SD card
Date: Thu, 05 Jul 2018 13:10:34 +0200
Message-ID: <0ba425d59b0739272cf871722441f69c@agner.ch>
References: <037cbd3560a68bad0cea92f453c1b819@agner.ch>
 <0f262b04fab61ec75b7e368a8f4968aa@agner.ch>
 <aaa1f8ec2668ce0c654b6225a7d8737c@agner.ch>
 <AM0PR04MB42118B1DC96FFF0143DEB84680400@AM0PR04MB4211.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AM0PR04MB42118B1DC96FFF0143DEB84680400@AM0PR04MB4211.eurprd04.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, linux-mmc-owner@vger.kernel.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 05.07.2018 05:13, A.s. Dong wrote:
>> -----Original Message-----
>> From: Stefan Agner [mailto:stefan@agner.ch]
>> Sent: Tuesday, July 3, 2018 9:13 PM
>> To: adrian.hunter@intel.com; A.s. Dong <aisheng.dong@nxp.com>; Fabio
>> Estevam <fabio.estevam@nxp.com>
>> Cc: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> mmc-owner@vger.kernel.org
>> Subject: Re: Self-detected stall on CPU when using SD card
>>
>> Dong Aisheng,
>>
>> Maybe you can shed some light on the issue below?
>>
> 
> I tried on MX6Q SDB board but did not reproduce it with a SD card
> plugged into Slot2 with 4.18-rc1.
> Any difference we need to care?
> 
>>
>> On 26.06.2018 16:45, Stefan Agner wrote:
>> > On 26.06.2018 12:53, Stefan Agner wrote:
>> >> Hi,
>> >>
>> >> On our Colibri iMX6 (arch/arm/boot/dts/imx6qdl-colibri.dtsi) we
>> >> experience the following stack trace when a SD card is plugged in:
>> >>
>> >
>> > [...]
>> >
>> >> [<c08396f4>] (esdhc_pltfm_set_clock) from [<c083622c>]
>> >> (sdhci_set_ios+0xd8/0x584)
>> >>  r10:ffffe000 r9:c1105900 r8:00004097 r7:d818f2e8 r6:d818f480
>> >> r5:d818f2e8
>> >>  r4:d818f000
>> >> [<c0836154>] (sdhci_set_ios) from [<c0836070>]
>> >> (sdhci_runtime_resume_host+0xa0/0x184)
>> >>  r9:c1105900 r8:00004097 r7:d818f2e8 r6:d818f648 r5:d818f000
>> >> r4:d818f480
>> >
>> > [...]
>> >
>> >>
>> >> It used to work in v4.9, so I started a git bisect. It pointed me to
>> >> this commit:
>> >>
>> >> Commit d1e4f74f911d ("mmc: sdhci: Do not use spin lock in set_ios
>> >> paths").
>> >>
>> >> Reverting the commit on-top of v4.18-rc1 seems to fix the issue too.
>> >>
>> >> Any idea?
>> >
>> > I figured out that the same platform had a GPIO Key which triggered
>> > all the time. This seems to exacerbate the MMC issue such that it
>> > triggers on very boot, about rootfs mount time.
>> >
> 
> That's a bit strange.... Why that GPIO key triggers all the time?
> 

This was a bug in our device tree: we configured a 100k pull-up where
there is a 100k pull-down externally... The level was always around 1.6V
and caused thousands of interrupts during boot up.

The stack trace really suggests that there are simply to many interrupts
happening on the GPIO key and stalling the CPU. Of course, at this point
I could have stopped and just do the device tree fix.

But the question was just nagging me: Why does disabling interrupts
during esdhc_pltfm_set_clock fixes the issue too?? There must be
something particular with esdhc_pltfm_set_clock.


After digging some hours I finally found the issue, and it is somewhat
mind blowing:

The SD card clock and the GPIO key pins happen to be routed right next
to each other! Without SD card the GPIO key stays at a stable level and
does not cause interrupts. However, when the SD card clock next to the
GPIO key is enabled it reliably generates interrupts due to cross talk!

But the SD card clock is enabled even outside of esdhc_pltfm_set_clock.
If just cross talk is the problem then disabling interrupts during clock
change esdhc_pltfm_set_clock should make no real difference...

It turns out, that in the i.MX 6 case the driver clears ESDHC_CLOCK_MASK
which generates 200MHz on the SD card clk pin for a short period of
time! This exacerbated cross talk just enough to cause a complete stall!

When interrupts are disabled during that short phase, cross talk does
not do any harm.... And it seems that with 50MHz (which is the rate on
function exit) cross talk does not appear/doe not cause enough
interrupts to stall the CPU completely...


Anyway, we probably don't want the card to be clocked at 200MHz for that
short time. Fixing this is rather trivial, just make sure that we
disable card clock before changing rate:

--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -708,14 +708,14 @@ static inline void esdhc_pltfm_set_clock(struct
sdhci_host *host,
        int div = 1;
        u32 temp, val;
 
+       if (esdhc_is_usdhc(imx_data)) {
+               val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
+               writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
+                               host->ioaddr + ESDHC_VENDOR_SPEC);
+       }
+
        if (clock == 0) {
                host->mmc->actual_clock = 0;
-
-               if (esdhc_is_usdhc(imx_data)) {
-                       val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
-                       writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
-                                       host->ioaddr +
ESDHC_VENDOR_SPEC);
-               }
                return;
        }
 

With that clocks get disabled before we clear the divider registers
further down. I will send a patch for this.

--
Stefan


>> > This change seems to fix the issue as well, not sure though whether
>> > this is a proper fix:
>> >
>> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> > @@ -697,6 +697,7 @@ static inline void esdhc_pltfm_set_clock(struct
>> > sdhci_host *host,
>> >         int ddr_pre_div = imx_data->is_ddr ? 2 : 1;
>> >         int pre_div = 1;
>> >         int div = 1;
>> > +       unsigned long flags;
>> >         u32 temp, val;
>> >
>> >         if (clock == 0) {
>> > @@ -724,6 +725,7 @@ static inline void esdhc_pltfm_set_clock(struct
>> > sdhci_host *host,
>> >                         pre_div = 2;
>> >         }
>> >
>> > +       spin_lock_irqsave(&host->lock, flags);
>> >         temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
>> >         temp &= ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN |
>> > ESDHC_CLOCK_PEREN
>> >                 | ESDHC_CLOCK_MASK);
>> > @@ -754,6 +756,7 @@ static inline void esdhc_pltfm_set_clock(struct
>> > sdhci_host *host,
>> >                 writel(val | ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
>> >                 host->ioaddr + ESDHC_VENDOR_SPEC);
>> >         }
>> > +       spin_unlock_irqrestore(&host->lock, flags);
>>
>> The bits ESDHC_CLOCK_IPGEN, ESDHC_CLOCK_HCKEN,
>> ESDHC_CLOCK_PEREN which are cleared and written in that section are
>> actually mentioned as "Reserved. Always write as 1." in the reference
>> manual...
>>
> 
> That's for legacy platforms like MX5. No side affect on MX6&7 as we know.
> So keep it now. Is the issue related to that?
> 
> Regards
> Dong Aisheng
> 
>> --
>> Stefan
>>
>> >
>> >         mdelay(1);
>> >  }
>> >
>> > --
>> > Stefan
