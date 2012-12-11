From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/1] mmc: sdhci-acpi: enable runtime-pm for device HID INT33C6
Date: Tue, 11 Dec 2012 12:51:58 +0100
Message-ID: <45176674.6KLpGCyqyD@vostro.rjw.lan>
References: <1355130644-26065-1-git-send-email-adrian.hunter@intel.com> <1355130644-26065-2-git-send-email-adrian.hunter@intel.com> <87a9tm56r0.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <87a9tm56r0.fsf@octavius.laptop.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-mmc@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Monday, December 10, 2012 09:20:03 AM Chris Ball wrote:
> Hi,
> 
> On Mon, Dec 10 2012, Adrian Hunter wrote:
> > sdhci-acpi supports ACPI devices which have compatibility ID
> > PNP0D40, however it is not possible to know if those devices
> > will all work correctly with runtime-pm, so that must be configured
> > per hardware ID.
> 
> Acked-by: Chris Ball <cjb@laptop.org>

Applied.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
