From: "Hunter, Adrian" <adrian.hunter@intel.com>
Subject: RE: [PATCH] mmc: sdhci-pci: Remove D3 delays for Intel BYT-related
 host controllers
Date: Mon, 9 Oct 2017 20:01:06 +0000
Message-ID: <363DA0ED52042842948283D2FC38E4649BF3590E@IRSMSX106.ger.corp.intel.com>
References: <1507294259-20438-1-git-send-email-adrian.hunter@intel.com>
 <20171006162048.GC25517@bhelgaas-glaptop.roam.corp.google.com>
 <ada41e9b-6fb3-82ab-e458-af4942adba2d@intel.com>
 <20171009134154.GJ25517@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171009134154.GJ25517@bhelgaas-glaptop.roam.corp.google.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Cox <alan@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Monday, October 9, 2017 4:42 PM
> To: Hunter, Adrian <adrian.hunter@intel.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>; linux-mmc <linux-
> mmc@vger.kernel.org>; linux-pci <linux-pci@vger.kernel.org>; Bjorn Helgaas
> <bhelgaas@google.com>; linux-acpi <linux-acpi@vger.kernel.org>; Rafael J.
> Wysocki <rjw@rjwysocki.net>; Alan Cox <alan@linux.intel.com>
> Subject: Re: [PATCH] mmc: sdhci-pci: Remove D3 delays for Intel BYT-related
> host controllers
> 
> [+cc Alan]
> 
> On Mon, Oct 09, 2017 at 11:56:43AM +0300, Adrian Hunter wrote:
> > On 06/10/17 19:20, Bjorn Helgaas wrote:
> > > On Fri, Oct 06, 2017 at 03:50:59PM +0300, Adrian Hunter wrote:
> > >> The default D3 cold delay of 100 ms can cause pauses when streaming
> > >> audio from eMMC.
> > >>
> > >> Intel BYT-related host controllers do not need PCI D3 delays.
> > >> Although the delays can be set to zero via an ACPI _DSM,
> > >> unfortunately that is not being used in all cases. So just set the delays to
> zero in the driver.
> > >>
> > >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > >> ---
> > >>  drivers/mmc/host/sdhci-pci-core.c | 17 +++++++++++++----
> > >>  1 file changed, 13 insertions(+), 4 deletions(-)
> > >>
> > >> diff --git a/drivers/mmc/host/sdhci-pci-core.c
> > >> b/drivers/mmc/host/sdhci-pci-core.c
> > >> index 5f3f7b51299f..14ef99b6e5b7 100644
> > >> --- a/drivers/mmc/host/sdhci-pci-core.c
> > >> +++ b/drivers/mmc/host/sdhci-pci-core.c
> > >> @@ -592,9 +592,18 @@ static void byt_read_dsm(struct sdhci_pci_slot
> *slot)
> > >>  	slot->chip->rpm_retune = intel_host->d3_retune;  }
> > >>
> > >> -static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
> > >> +static void byt_common_setup(struct sdhci_pci_slot *slot)
> > >>  {
> > >>  	byt_read_dsm(slot);
> > >> +
> > >> +	/* PCI D3 delays are not needed */
> > >> +	slot->chip->pdev->d3_delay = 0;
> > >> +	slot->chip->pdev->d3cold_delay = 0;
> > >
> > > The fact that it doesn't need D3 delays sounds like a property of
> > > the device itself, regardless of which (if any) driver claims it.
> > >
> > > Can this be done as a quirk instead, maybe something in
> > > arch/x86/pci/fixup.c?  Maybe quirk_remove_d3_delay() could be used
> > > directly, or something like pci_d3_delay_fixup()?
> >
> > A quirk would work, but that would mean setting the quirk for each
> > device
> > (28 so far) and then, when we have new ids, adding them there and to
> > the driver, so it is more convenient just to do it in the driver.
> > Certainly, this is the only driver we have for these Intel SDHCI PCI host
> controllers.
> 
> pci_d3_delay_fixup() has code that mitigates the problem of adding new IDs.
> Maybe that quirk should simply be moved to arch/x86/pci/fixup.c?

pci_d3_delay_fixup() is not setting zero.  quirk_remove_d3_delay() and creating
a quirk_remove_d3cold_delay() would work.

> If we put this in the driver, won't we have the unnecessary delays on
> systems where the driver isn't in use?

The issue is unacceptable I/O latency (streaming audio through the device
was the example) which means you have to have a driver.

