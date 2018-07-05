From: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: Self-detected stall on CPU when using SD card
Date: Thu, 5 Jul 2018 03:13:50 +0000
Message-ID: <AM0PR04MB42118B1DC96FFF0143DEB84680400@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <037cbd3560a68bad0cea92f453c1b819@agner.ch>
 <0f262b04fab61ec75b7e368a8f4968aa@agner.ch>
 <aaa1f8ec2668ce0c654b6225a7d8737c@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <aaa1f8ec2668ce0c654b6225a7d8737c@agner.ch>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Agner <stefan@agner.ch>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@nxp.com>
Cc: "linux-mmc-owner@vger.kernel.org" <linux-mmc-owner@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

> -----Original Message-----
> From: Stefan Agner [mailto:stefan@agner.ch]
> Sent: Tuesday, July 3, 2018 9:13 PM
> To: adrian.hunter@intel.com; A.s. Dong <aisheng.dong@nxp.com>; Fabio
> Estevam <fabio.estevam@nxp.com>
> Cc: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> mmc-owner@vger.kernel.org
> Subject: Re: Self-detected stall on CPU when using SD card
> 
> Dong Aisheng,
> 
> Maybe you can shed some light on the issue below?
> 

I tried on MX6Q SDB board but did not reproduce it with a SD card
plugged into Slot2 with 4.18-rc1.
Any difference we need to care?

> 
> On 26.06.2018 16:45, Stefan Agner wrote:
> > On 26.06.2018 12:53, Stefan Agner wrote:
> >> Hi,
> >>
> >> On our Colibri iMX6 (arch/arm/boot/dts/imx6qdl-colibri.dtsi) we
> >> experience the following stack trace when a SD card is plugged in:
> >>
> >
> > [...]
> >
> >> [<c08396f4>] (esdhc_pltfm_set_clock) from [<c083622c>]
> >> (sdhci_set_ios+0xd8/0x584)
> >>  r10:ffffe000 r9:c1105900 r8:00004097 r7:d818f2e8 r6:d818f480
> >> r5:d818f2e8
> >>  r4:d818f000
> >> [<c0836154>] (sdhci_set_ios) from [<c0836070>]
> >> (sdhci_runtime_resume_host+0xa0/0x184)
> >>  r9:c1105900 r8:00004097 r7:d818f2e8 r6:d818f648 r5:d818f000
> >> r4:d818f480
> >
> > [...]
> >
> >>
> >> It used to work in v4.9, so I started a git bisect. It pointed me to
> >> this commit:
> >>
> >> Commit d1e4f74f911d ("mmc: sdhci: Do not use spin lock in set_ios
> >> paths").
> >>
> >> Reverting the commit on-top of v4.18-rc1 seems to fix the issue too.
> >>
> >> Any idea?
> >
> > I figured out that the same platform had a GPIO Key which triggered
> > all the time. This seems to exacerbate the MMC issue such that it
> > triggers on very boot, about rootfs mount time.
> >

That's a bit strange.... Why that GPIO key triggers all the time?

> > This change seems to fix the issue as well, not sure though whether
> > this is a proper fix:
> >
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -697,6 +697,7 @@ static inline void esdhc_pltfm_set_clock(struct
> > sdhci_host *host,
> >         int ddr_pre_div = imx_data->is_ddr ? 2 : 1;
> >         int pre_div = 1;
> >         int div = 1;
> > +       unsigned long flags;
> >         u32 temp, val;
> >
> >         if (clock == 0) {
> > @@ -724,6 +725,7 @@ static inline void esdhc_pltfm_set_clock(struct
> > sdhci_host *host,
> >                         pre_div = 2;
> >         }
> >
> > +       spin_lock_irqsave(&host->lock, flags);
> >         temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
> >         temp &= ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN |
> > ESDHC_CLOCK_PEREN
> >                 | ESDHC_CLOCK_MASK);
> > @@ -754,6 +756,7 @@ static inline void esdhc_pltfm_set_clock(struct
> > sdhci_host *host,
> >                 writel(val | ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
> >                 host->ioaddr + ESDHC_VENDOR_SPEC);
> >         }
> > +       spin_unlock_irqrestore(&host->lock, flags);
> 
> The bits ESDHC_CLOCK_IPGEN, ESDHC_CLOCK_HCKEN,
> ESDHC_CLOCK_PEREN which are cleared and written in that section are
> actually mentioned as "Reserved. Always write as 1." in the reference
> manual...
> 

That's for legacy platforms like MX5. No side affect on MX6&7 as we know.
So keep it now. Is the issue related to that?

Regards
Dong Aisheng

> --
> Stefan
> 
> >
> >         mdelay(1);
> >  }
> >
> > --
> > Stefan
