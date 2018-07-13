From: Aapo Vienamo <avienamo@nvidia.com>
Subject: Re: REGRESSION: [PATCH] mmc: tegra: Use
 sdhci_pltfm_clk_get_max_clock
Date: Fri, 13 Jul 2018 12:50:05 +0300
Message-ID: <20180713125005.69895f06@dhcp-10-21-25-168>
References: <1528126540-27004-1-git-send-email-avienamo@nvidia.com>
        <CAPDyKFoip8gFssftJKzVHD9PAk+j=Z1CTo=0uY9cGASzW8VRJg@mail.gmail.com>
        <1531446183.5479.14.camel@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531446183.5479.14.camel@toradex.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Stefan Agner <stefan.agner@toradex.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, 13 Jul 2018 01:43:05 +0000
Marcel Ziswiler <marcel.ziswiler@toradex.com> wrote:

> On Mon, 2018-07-02 at 15:16 +0200, Ulf Hansson wrote:
> > On 4 June 2018 at 17:35, Aapo Vienamo <avienamo@nvidia.com> wrote:  
> > > The sdhci get_max_clock callback is set to
> > > sdhci_pltfm_clk_get_max_clock
> > > and tegra_sdhci_get_max_clock is removed. It appears that the
> > > shdci-tegra specific callback was originally introduced due to the
> > > requirement that the host clock has to be twice the bus clock on
> > > DDR50
> > > mode. As far as I can tell the only effect the removal has on DDR50
> > > mode
> > > is in cases where the parent clock is unable to supply the
> > > requested
> > > clock rate, causing the DDR50 mode to run at a lower frequency.
> > > Currently the DDR50 mode isn't enabled on any of the SoCs and would
> > > also
> > > require configuring the SDHCI clock divider register to function
> > > properly.
> > > 
> > > The problem with tegra_sdhci_get_max_clock is that it divides the
> > > clock
> > > rate by two and thus artificially limits the maximum frequency of
> > > faster
> > > signaling modes which don't have the host-bus frequency ratio
> > > requirement
> > > of DDR50 such as SDR104 and HS200. Furthermore, the call to
> > > clk_round_rate() may return an error which isn't handled by
> > > tegra_sdhci_get_max_clock.
> > > 
> > > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>  
> > 
> > Thanks, applied for next!
> > 
> > Kind regards
> > Uffe
> >   
> > > ---
> > >  drivers/mmc/host/sdhci-tegra.c | 15 ++-------------
> > >  1 file changed, 2 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/mmc/host/sdhci-tegra.c
> > > b/drivers/mmc/host/sdhci-tegra.c
> > > index 970d38f6..c8745b5 100644
> > > --- a/drivers/mmc/host/sdhci-tegra.c
> > > +++ b/drivers/mmc/host/sdhci-tegra.c
> > > @@ -234,17 +234,6 @@ static void
> > > tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
> > >         sdhci_set_uhs_signaling(host, timing);
> > >  }
> > > 
> > > -static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host
> > > *host)
> > > -{
> > > -       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > > -
> > > -       /*
> > > -        * DDR modes require the host to run at double the card
> > > frequency, so
> > > -        * the maximum rate we can support is half of the module
> > > input clock.
> > > -        */
> > > -       return clk_round_rate(pltfm_host->clk, UINT_MAX) / 2;
> > > -}
> > > -
> > >  static void tegra_sdhci_set_tap(struct sdhci_host *host, unsigned
> > > int tap)
> > >  {
> > >         u32 reg;
> > > @@ -309,7 +298,7 @@ static const struct sdhci_ops tegra_sdhci_ops =
> > > {
> > >         .platform_execute_tuning = tegra_sdhci_execute_tuning,
> > >         .set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
> > >         .voltage_switch = tegra_sdhci_voltage_switch,
> > > -       .get_max_clock = tegra_sdhci_get_max_clock,
> > > +       .get_max_clock = sdhci_pltfm_clk_get_max_clock,
> > >  };
> > > 
> > >  static const struct sdhci_pltfm_data sdhci_tegra20_pdata = {
> > > @@ -357,7 +346,7 @@ static const struct sdhci_ops
> > > tegra114_sdhci_ops = {
> > >         .platform_execute_tuning = tegra_sdhci_execute_tuning,
> > >         .set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
> > >         .voltage_switch = tegra_sdhci_voltage_switch,
> > > -       .get_max_clock = tegra_sdhci_get_max_clock,
> > > +       .get_max_clock = sdhci_pltfm_clk_get_max_clock,
> > >  };
> > > 
> > >  static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
> > > --
> > > 2.7.4  
> 
> Hm, for us this definitely breaks stuff. While using Stefan's patch set
> [1] we may not only run eMMC at DDR52 even SD cards run stable at
> SDR104. With this patch however the clock gets crippled to 45.33 resp.
> 48 MHz always. This is observed both on Apalis/Colibri T30 as well as
> Apalis TK1.

Well, strictly speaking this isn't a regression as DDR52/50 modes were
not enable at the time when the patch was applied. However, these issues
should be addressed properly none the less.

The patch was written in preparation of implementing support for higher
speed modes like HS200 and HS400, where limiting the max_clock like that
isn't an option. Some other solution than reverting the patch has to be
found.

> Current next-20180712 just with Stefan's 3 patches:
> 
> root@apalis-t30:~# cat /sys/kernel/debug/mmc1/ios 
> clock:          48000000 Hz
> actual clock:   45333333 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    8 (mmc DDR52)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
> root@apalis-t30:~# hdparm -t /dev/mmcblk1
> 
> /dev/mmcblk1:
>  Timing buffered disk reads: 218 MB in  3.03 seconds =  71.95 MB/sec
> 
> root@apalis-t30:~# cat /sys/kernel/debug/mmc2/ios 
> clock:          48000000 Hz
> actual clock:   48000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      2 (4 bits)
> timing spec:    6 (sd uhs SDR104)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
> root@apalis-t30:~# hdparm -t /dev/mmcblk2
> 
> /dev/mmcblk2:
>  Timing buffered disk reads:  66 MB in  3.06 seconds =  21.60 MB/sec
> 
> And with this patch reverted it works as expected again:
> 
> root@apalis-t30:~# cat /sys/kernel/debug/mmc1/ios 
> clock:          52000000 Hz
> actual clock:   51000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    8 (mmc DDR52)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
> root@apalis-t30:~# hdparm -t /dev/mmcblk1
> 
> /dev/mmcblk1:
>  Timing buffered disk reads: 240 MB in  3.02 seconds =  79.50 MB/sec
> 
> root@apalis-t30:~# cat /sys/kernel/debug/mmc2/ios 
> clock:          204000000 Hz
> actual clock:   204000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      2 (4 bits)
> timing spec:    6 (sd uhs SDR104)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
> root@apalis-t30:~# hdparm -t /dev/mmcblk2
> 
> /dev/mmcblk2:
>  Timing buffered disk reads: 258 MB in  3.01 seconds =  85.58 MB/sec
> 
> [1] https://lore.kernel.org/lkml/20180712073904.4705-1-stefan@agner.ch

The fact that you're getting totally different clocks, especially on
SDR104, doesn't make much sense. I'll try to reproduce this and track
down what's going on.

 -Aapo
