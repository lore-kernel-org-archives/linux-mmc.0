From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] mmc: sdhci-acpi: set non-removable in ACPI table
Date: Fri, 11 Dec 2015 23:53:38 +0100
Message-ID: <2610121.hCKXuUzvHo@vostro.rjw.lan>
References: <1449150480-1173-1-git-send-email-pelcan@codeaurora.org> <5669E72C.4090701@codeaurora.org> <566A868E.8080808@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <566A868E.8080808@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Philip Elcan <pelcan@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>, Jon Masters <jcm@redhat.org>, Mark Langsdorf <mlangsdo@redhat.com>, harba@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On Friday, December 11, 2015 10:17:18 AM Adrian Hunter wrote:
> On 10/12/15 22:57, Philip Elcan wrote:
> > 
> > On 12/07/2015 03:30 AM, Adrian Hunter wrote:
> >> On 04/12/15 17:40, Philip Elcan wrote:
> >>> On 12/03/2015 09:14 AM, Adrian Hunter wrote:
> >>>> On 03/12/15 15:48, Philip Elcan wrote:
> >>>>> This allows setting an SDHC controller as non-removable
> >>>>> by using the _RMV method in the ACPI table. It doesn't
> >>>> Is that _RMV on the host controller?  Shouldn't it be on the card i.e. child
> >>>> device node?
> >>> Yes, this is on the host controller. The ACPI table only describes the
> >>> host controller, not the child nodes.
> >>>
> >> If you look at Intel devices, the _RMV is on the child e.g.
> >>
> >>         Device (SDHA)
> >>         {
> >>             Name (_HID, "80860F14")  // _HID: Hardware ID
> >>             Name (_CID, "PNP0D40")  // _CID: Compatible ID
> >>             Name (_DDN, "Intel(R) eMMC Controller - 80860F14")  // _DDN: DOS Device Name
> >> 	    ...
> >>             Device (EMMD)
> >>             {
> >> 		...
> >>                 Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
> >>                 {
> >>                     Return (Zero)
> >>                 }
> >>             }
> >>         }
> >>
> >> I am not an ACPI expert but that seems like the correct place for it.
> > My understanding is that in ACPI you don't generally create child devices on buses that are discoverable.
> 
> I've cc'ed Rafael and the linux-acpi mailing list.  Maybe someone there can
> comment.

The context here is a bit unclear to me.

Quite frankly, I don't see now _RMV above is useful for anything.  As per the
spec, _RMV is only necessary for devices that *can* be removed from the system
and where there's no eject mechanism controlled by software.  For those
devices _RMV is intended to indicate that it is safe to remove the device
at the time _RMV is evaluated.  Devices that can never be removed don't
need _RMV at all.

Thanks,
Rafael
