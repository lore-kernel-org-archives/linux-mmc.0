From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2 0/3] Add SDHCI ACPI driver
Date: Fri, 23 Nov 2012 21:35:22 +0100
Message-ID: <3416042.oXdXWT2CDk@vostro.rjw.lan>
References: <1353670561-22515-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1353670561-22515-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chris Ball <cjb@laptop.org>, mika.westerberg@linux.intel.com, linux-mmc@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Friday, November 23, 2012 01:35:58 PM Adrian Hunter wrote:
> Hi
> 
> Here is SDHCI ACPI driver.
> 
> Changes for v2:
> 
> 	Dropped "PNPACPI: exclude SDHCI devices"
> 	Added "PNPACPI: exclude devices already bound"
> 	Changed dev->acpi_handle to ACPI_HANDLE(dev)
> 	Added Chris' Ack for sdhci-acpi
> 
> 
> Adrian Hunter (2):
>       ACPI: add SDHCI to ACPI platform devices
>       mmc: sdhci-acpi: add SDHCI ACPI driver
> 
> Mika Westerberg (1):
>       PNPACPI: exclude devices already bound

Applied to linux-pm.git/linux-next as v3.8 material.

Next time, however, I'll really prefer it if your changelogs (1) exist and (2)
are more descriptive than the (existing) ones in this series.

I added the changelogs for you (please check in the tree above if they make
sense), but that's not something I should be doing in general I think.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
