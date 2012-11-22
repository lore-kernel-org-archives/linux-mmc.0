From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/3] Add SDHCI ACPI driver
Date: Thu, 22 Nov 2012 22:24:33 +0100
Message-ID: <3578053.jWYihc5IJI@vostro.rjw.lan>
References: <1353573830-13006-1-git-send-email-adrian.hunter@intel.com> <87k3tdagim.fsf@octavius.laptop.org> <50AE3AB2.2070307@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50AE3AB2.2070307@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <cjb@laptop.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-mmc@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thursday, November 22, 2012 04:46:10 PM Adrian Hunter wrote:
> On 22/11/12 15:55, Chris Ball wrote:
> > Hi,
> > 
> > On Thu, Nov 22 2012, Adrian Hunter wrote:
> >> Here is SDHCI ACPI driver.  It is dependent on new ACPI Platform support
> >> so I suggest Rafael takes the patches with Chris' Ack.
> >>
> >> Please note that I would prefer this to be queued for 3.8
> > 
> > Looks fine:
> > 
> > Acked-by: Chris Ball <cjb@laptop.org>
> 
> Thank you!
> 
> > 
> > I have some dumb questions, though -- what kind of platforms ship with
> > these devices?  Do they ever have the controller on PCI too, and what
> > happens with sdhci-pci vs. sdhci-acpi in that case?
> 
> Since the arrival of ACPI5, platform devices can be configured using ACPI
> tables.  PCI can also be used, but the firmware ensures that the same
> device is not enumerated via both ACPI and PCI.
> 
> Rafael can you take these patches?

Well, I'd prefer pnpacpi/core.c to actually use acpi_platform_device_ids[]
directly in addition to excluded_id_list[], so that duplicate entries don't
have to be added to the both of them.

Also, I wonder if you really don't want to use ACPI PM and if you don't,
then why?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
