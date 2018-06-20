From: Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Subject: Re: [PATCH 1/1] mmc: sdhci-pci: fix eMMC controller issue on Intel
 Baytrail SoCs
Date: Wed, 20 Jun 2018 15:15:10 +0200
Message-ID: <20180620131509.dhshihzxhfebracx@linutronix.de>
References: <20180619063119.3955-1-kurt@linutronix.de>
 <20180619063119.3955-2-kurt@linutronix.de>
 <293c2771-ea9b-4f0c-bd31-f8844de12dc4@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <293c2771-ea9b-4f0c-bd31-f8844de12dc4@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
List-Id: linux-mmc@vger.kernel.org

Hi,

thanks for your response.

On Tue, Jun 19, 2018 at 10:03:01AM +0300, Adrian Hunter wrote:
> On 19/06/18 09:31, Kurt Kanzenbach wrote:
> > Sometimes the eMMC controller doesn't respond anymore on Intel Baytrail
> > SoCs. The resulting error looks like:
> >
> > |mmc1: Reset 0x1 never completed.
> > |sdhci: =========== REGISTER DUMP (mmc1)===========
> > |sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
> > |sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
> > |sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
> > |sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
> > |sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
> > |sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
> > |sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
> > |sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
> > |sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
> > |sdhci: Caps:     0xffffffff | Caps_1:   0xffffffff
> > |sdhci: Cmd:      0x0000ffff | Max curr: 0xffffffff
> > |sdhci: Host ctl2: 0x0000ffff
> > |sdhci: ADMA Err: 0xffffffff | ADMA Ptr: 0xffffffff
> >
> > The behavior was observed on an Intel Atom E3825 performing lots of reboots. The
>
> So you are saying this only happens at boot time?  And only when
> re-booting?

well, exactly. This issue was only observed when rebooting, not on cold
boots.

> Can you send all the kernel messages?  Can you send an acpidump?

The kernel log is straightforward. The system is booting and starting a
few applications. Afterwards the issue happens. The rootfilesystem is
located on the eMMC.

The error message above is from the Linux v4.9 boot log.

On v4.17 the same issue happens, but the error messages are different:

|mmc1: Timeout waiting for hardware interrupt.
|mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
|mmc1: sdhci: Sys addr:  0x00000002 | Version:  0x00001002
|mmc1: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
|mmc1: sdhci: Argument:  0x00040fd4 | Trn mode: 0x0000003b
|mmc1: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000035
|mmc1: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
|mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000207
|mmc1: sdhci: Timeout:   0x00000000 | Int stat: 0x00000003
|mmc1: sdhci: Int enab:  0x02ff000b | Sig enab: 0x02ff000b
|mmc1: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000001
|mmc1: sdhci: Caps:      0x446cc801 | Caps_1:   0x00000005
|mmc1: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
|mmc1: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
|mmc1: sdhci: Resp[2]:   0x320f5913 | Resp[3]:  0x00000900
|mmc1: sdhci: Host ctl2: 0x0000000c
|mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x34ee5208
|mmc1: sdhci: ============================================
|[...]

Both issues disappear when disabling runtime pm.

Anyway I'll prepare an acpidump for you.

>
> > issue seems to occur if runtime power management is used. Found by utilizing
> > ftrace.
> >
> > The erratum VLI10 for the Intel E3825 states, that the eMMC controller
> > incorrectly announces that it supports suspend/resume. However, that shouldn't
> > be used, as the controller may incorrectly transfer data between memory and the
> > SD device.
>
> That erratum is not related to this problem.  The suspend/resume that is
> documented is an internal SDHCI feature, not the kernel's suspend/resume.
> The SDHCI Suspend/Resume Mechanism is not supported in the driver, so it is
> not being used anyway.

Thanks for the clarification.

Do you have any idea why this issue might happen?

Thanks, Kurt

>
> >
> > Therefore, disallowing runtime pm resolves the issue. Tested on the E3825.
> >
> > Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> > ---
> >  drivers/mmc/host/sdhci-pci-core.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> > index 77dd3521daae..df89381944cd 100644
> > --- a/drivers/mmc/host/sdhci-pci-core.c
> > +++ b/drivers/mmc/host/sdhci-pci-core.c
> > @@ -870,6 +870,21 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_emmc = {
> >  	.priv_size	= sizeof(struct intel_host),
> >  };
> >
> > +/*
> > + * See Erratum VLI10 from Errata List for Intel Atom E3825, Link:
> > + * https://www.intel.ca/content/dam/www/public/us/en/documents/specification-updates/atom-e3800-family-spec-update.pdf
> > + */
> > +static const struct sdhci_pci_fixes sdhci_intel_byt_emmc_no_runtime_pm = {
> > +	.allow_runtime_pm = false,
> > +	.probe_slot	= byt_emmc_probe_slot,
> > +	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> > +	.quirks2	= SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> > +			  SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 |
> > +			  SDHCI_QUIRK2_STOP_WITH_TC,
> > +	.ops		= &sdhci_intel_byt_ops,
> > +	.priv_size	= sizeof(struct intel_host),
> > +};
> > +
> >  static const struct sdhci_pci_fixes sdhci_intel_glk_emmc = {
> >  	.allow_runtime_pm	= true,
> >  	.probe_slot		= glk_emmc_probe_slot,
> > @@ -1470,7 +1485,7 @@ static const struct pci_device_id pci_ids[] = {
> >  	SDHCI_PCI_SUBDEVICE(INTEL, BYT_SDIO, NI, 7884, ni_byt_sdio),
> >  	SDHCI_PCI_DEVICE(INTEL, BYT_SDIO,  intel_byt_sdio),
> >  	SDHCI_PCI_DEVICE(INTEL, BYT_SD,    intel_byt_sd),
> > -	SDHCI_PCI_DEVICE(INTEL, BYT_EMMC2, intel_byt_emmc),
> > +	SDHCI_PCI_DEVICE(INTEL, BYT_EMMC2, intel_byt_emmc_no_runtime_pm),
> >  	SDHCI_PCI_DEVICE(INTEL, BSW_EMMC,  intel_byt_emmc),
> >  	SDHCI_PCI_DEVICE(INTEL, BSW_SDIO,  intel_byt_sdio),
> >  	SDHCI_PCI_DEVICE(INTEL, BSW_SD,    intel_byt_sd),
> >
>
