From: Marc Dietrich <marvin24@gmx.de>
Subject: Re: emmc power select failure
Date: Sat, 19 May 2012 17:38:50 +0200
Message-ID: <5020225.pSQj6FTFv6@ax5200p>
References: <1721770.czJDhHnFDk@ax5200p> <CANYdXnpBgpgOFv_rSg+tGTE_vppbV6XO66h5eyr9X2LUFk4T_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:36231 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753183Ab2ETLZu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 May 2012 07:25:50 -0400
In-Reply-To: <CANYdXnpBgpgOFv_rSg+tGTE_vppbV6XO66h5eyr9X2LUFk4T_A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: linux-mmc@vger.kernel.org

Hi Shashidhar,

ok, now that the bus width switch error became fatal in recent kernels, the 
problem started to became painful...

I added some debug printks to the mmc_switch function in mmc_ops.c:

[    1.433253] sdhci: Secure Digital Host Controller Interface driver
[    1.442993] sdhci: Copyright(c) Pierre Ossman
[    1.450802] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.460363] mmc0: Invalid maximum block size, assuming 512 bytes
[    1.469905] mmc0: no vmmc regulator found
[    1.477523] Registered led device: mmc0::
[    1.524716] mmc0: SDHCI controller on sdhci-tegra.0 [sdhci-tegra.0] using 
ADMA
[    1.535694] mmc1: Invalid maximum block size, assuming 512 bytes
[    1.546965] mmc1: no vmmc regulator found
[    1.557964] Registered led device: mmc1::
[    1.603176] mmc1: SDHCI controller on sdhci-tegra.3 [sdhci-tegra.3] using 
ADMA
[    1.863003] mmc0: new high speed SDHC card at address aaaa
[    1.888671] mmcblk0: mmc0:aaaa SD16G 14.8 GiB 
[    1.918111]  mmcblk0: p1
[    2.022258] mmc1 switching: index: 175 value: 1 set: 1 timeout: 0
[    2.039804] mmc1 return status is: 0x00000900
[    2.046419] mmc1 switching: index: 185 value: 1 set: 1 timeout: 0
[    2.069361] mmc1 return status is: 0x00000900
[    2.075991] mmc1: exec mmc_switch with val 3 and time 0
[    2.088771] mmc1 switching: index: 187 value: 3 set: 1 timeout: 0
[    2.097515] mmc1 return status is: 0x00000980
[    2.104200] mmc1: power class selection for ext_csd_bus_width 2 failed
[    2.113093] mmc1: error -74 whilst initialising MMC card
[    2.275468] mmc1 switching: index: 175 value: 1 set: 1 timeout: 0
[    2.293980] mmc1 return status is: 0x00000900
[    2.300754] mmc1 switching: index: 185 value: 1 set: 1 timeout: 0
[    2.310502] mmc1 return status is: 0x00000900
[    2.317268] mmc1: exec mmc_switch with val 3 and time 0
[    2.324874] mmc1 switching: index: 187 value: 3 set: 1 timeout: 0
[    2.333719] mmc1 return status is: 0x00000980
[    2.340434] mmc1: power class selection for ext_csd_bus_width 2 failed
[    2.349381] mmc1: error -74 whilst initialising MMC card
[    2.485465] mmc1 switching: index: 175 value: 1 set: 1 timeout: 0
[    2.495166] mmc1 return status is: 0x00000900
[    2.501866] mmc1 switching: index: 185 value: 1 set: 1 timeout: 0
[    2.511521] mmc1 return status is: 0x00000900
[    2.518173] mmc1: exec mmc_switch with val 3 and time 0
[    2.525707] mmc1 switching: index: 187 value: 3 set: 1 timeout: 0
[    2.543724] mmc1 return status is: 0x00000980
[    2.550504] mmc1: power class selection for ext_csd_bus_width 2 failed
[    2.559483] mmc1: error -74 whilst initialising MMC card
[    2.695482] mmc1 switching: index: 175 value: 1 set: 1 timeout: 0
[    2.705240] mmc1 return status is: 0x00000900
[    2.711978] mmc1 switching: index: 185 value: 1 set: 1 timeout: 0
[    2.721699] mmc1 return status is: 0x00000900
[    2.728424] mmc1: exec mmc_switch with val 3 and time 0
[    2.736031] mmc1 switching: index: 187 value: 3 set: 1 timeout: 0
[    2.744870] mmc1 return status is: 0x00000980
[    2.751604] mmc1: power class selection for ext_csd_bus_width 2 failed
[    2.760558] mmc1: error -74 whilst initialising MMC card

Anything I can do to resolve this?

Marc

On Monday 16 April 2012 15:25:55 Shashidhar Hiremath wrote:
> Hi,
>   is the 8bit bus width supported by the hardware ?
> 
> On Fri, Apr 13, 2012 at 11:29 PM, Marc Dietrich <marvin24@gmx.de> wrote:
> > Hi,
> > 
> > I'm running linux-next on a tegra-sdhci host which has a Toshiba
> > THGBM2G6D2FBAI9 eMMC connected. During boot I get a "mmc1: power class
> > selection to bus width 8 failed" warning.
> > 
> > /sys/kernel/debug/mmc1# cat ios
> > clock:          48000000 Hz
> > actual clock:   48000000 Hz
> > vdd:            20 (3.2 ~ 3.3 V)
> > bus mode:       2 (push-pull)
> > chip select:    0 (don't care)
> > power mode:     2 (on)
> > bus width:      3 (8 bits)
> > timing spec:    1 (mmc high-speed)

