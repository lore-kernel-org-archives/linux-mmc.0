From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Remove D3 delays for Intel BYT-related
 host controllers
Date: Mon, 9 Oct 2017 11:56:43 +0300
Message-ID: <ada41e9b-6fb3-82ab-e458-af4942adba2d@intel.com>
References: <1507294259-20438-1-git-send-email-adrian.hunter@intel.com>
 <20171006162048.GC25517@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171006162048.GC25517@bhelgaas-glaptop.roam.corp.google.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-mmc@vger.kernel.org

On 06/10/17 19:20, Bjorn Helgaas wrote:
> On Fri, Oct 06, 2017 at 03:50:59PM +0300, Adrian Hunter wrote:
>> The default D3 cold delay of 100 ms can cause pauses when streaming audio
>> from eMMC.
>>
>> Intel BYT-related host controllers do not need PCI D3 delays. Although the
>> delays can be set to zero via an ACPI _DSM, unfortunately that is not being
>> used in all cases. So just set the delays to zero in the driver.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/mmc/host/sdhci-pci-core.c | 17 +++++++++++++----
>>  1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>> index 5f3f7b51299f..14ef99b6e5b7 100644
>> --- a/drivers/mmc/host/sdhci-pci-core.c
>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>> @@ -592,9 +592,18 @@ static void byt_read_dsm(struct sdhci_pci_slot *slot)
>>  	slot->chip->rpm_retune = intel_host->d3_retune;
>>  }
>>  
>> -static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
>> +static void byt_common_setup(struct sdhci_pci_slot *slot)
>>  {
>>  	byt_read_dsm(slot);
>> +
>> +	/* PCI D3 delays are not needed */
>> +	slot->chip->pdev->d3_delay = 0;
>> +	slot->chip->pdev->d3cold_delay = 0;
> 
> The fact that it doesn't need D3 delays sounds like a property of the
> device itself, regardless of which (if any) driver claims it.
> 
> Can this be done as a quirk instead, maybe something in
> arch/x86/pci/fixup.c?  Maybe quirk_remove_d3_delay() could be used
> directly, or something like pci_d3_delay_fixup()?

A quirk would work, but that would mean setting the quirk for each device
(28 so far) and then, when we have new ids, adding them there and to the
driver, so it is more convenient just to do it in the driver.  Certainly,
this is the only driver we have for these Intel SDHCI PCI host controllers.
