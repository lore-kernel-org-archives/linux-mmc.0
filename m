From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 2/3] mmc: sdhci-acpi: Add fix_up_power_blacklist module
 option
Date: Wed, 12 Apr 2017 16:07:32 +0300
Message-ID: <b198d491-f3e7-3567-299c-33996b64a5fc@intel.com>
References: <20170405130007.5826-1-hdegoede@redhat.com>
 <20170405130007.5826-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50316 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752677AbdDLNNM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 12 Apr 2017 09:13:12 -0400
In-Reply-To: <20170405130007.5826-2-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Takashi Iwai <tiwai@suse.de>, linux-mmc@vger.kernel.org

On 05/04/17 16:00, Hans de Goede wrote:
> Commit e5bbf30733f9 ("mmc: sdhci-acpi: Ensure connected devices are
> powered when probing") introduced unconditional calling of
> acpi_device_fix_up_power() on the mmc controller and its children.
> 
> This broke wifi on some systems because acpi_device_fix_up_power()
> was called even for disabled children sometimes leaving gpio-s in
> a state where wifi would not work, this was fixed in
> commit e1d070c3793a ("mmc: sdhci-acpi: Only powered up enabled acpi
> child devices").
> 
> Unfortunately on some devices calling acpi_device_fix_up_power()
> still causes issues. Specifically on the GPDwin mini clam-shell PC
> which has a pcie wifi module, it causes the wifi module to get
> turned off. This is a BIOS bug and I've tried to get the manufacturer
> to fix this but sofar they have not responded (and even if they do
> then we cannot assume all users will update their BIOS).
> 
> This commit adds a new sdhci_acpi.fix_up_power_blacklist module option
> which can be set to an ACPI hid:uid pair, e.g. "80860F14:2" to disable
> the calling of acpi_device_fix_up_power() for the sdhci host matching
> the hid:uid pair, fixing the wifi not working on this machine.

Sorry for the slow reply :-(.  I would much prefer to blacklist the whole
device i.e. if the firmware is broken then the device is broken.

