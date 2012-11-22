From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/3] Add SDHCI ACPI driver
Date: Thu, 22 Nov 2012 16:46:10 +0200
Message-ID: <50AE3AB2.2070307@intel.com>
References: <1353573830-13006-1-git-send-email-adrian.hunter@intel.com> <87k3tdagim.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k3tdagim.fsf@octavius.laptop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-mmc@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 22/11/12 15:55, Chris Ball wrote:
> Hi,
> 
> On Thu, Nov 22 2012, Adrian Hunter wrote:
>> Here is SDHCI ACPI driver.  It is dependent on new ACPI Platform support
>> so I suggest Rafael takes the patches with Chris' Ack.
>>
>> Please note that I would prefer this to be queued for 3.8
> 
> Looks fine:
> 
> Acked-by: Chris Ball <cjb@laptop.org>

Thank you!

> 
> I have some dumb questions, though -- what kind of platforms ship with
> these devices?  Do they ever have the controller on PCI too, and what
> happens with sdhci-pci vs. sdhci-acpi in that case?

Since the arrival of ACPI5, platform devices can be configured using ACPI
tables.  PCI can also be used, but the firmware ensures that the same
device is not enumerated via both ACPI and PCI.

Rafael can you take these patches?
