From: Stephen Warren <swarren@nvidia.com>
Subject: RE: [PATCH 2/3] mmc: Add OF bindings support for mmc host
 controller capabilities
Date: Tue, 11 Oct 2011 09:29:02 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173BE19AAE@HQMAIL01.nvidia.com>
References: <1317809581-28783-1-git-send-email-thomas.abraham@linaro.org>
	<1317809581-28783-3-git-send-email-thomas.abraham@linaro.org>
	<4E8C5BD6.2070709@gmail.com>
	<CAJuYYwS_NeE6OG9X2p2rkjgo4OqO-ijeVwr1sLGkUuLJOxMw2g@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173A2C7245@HQMAIL01.nvidia.com>
 <CAJuYYwSOZsqKObmt4MeaJa+aPmktwLsFocfmpjbJbOYyvmuwLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:15303 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005Ab1JKQbT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Oct 2011 12:31:19 -0400
In-Reply-To: <CAJuYYwSOZsqKObmt4MeaJa+aPmktwLsFocfmpjbJbOYyvmuwLQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Chris Ball <cjb@laptop.org>
Cc: "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Thomas Abraham wrote at Sunday, October 09, 2011 12:58 AM:
> On 5 October 2011 21:25, Stephen Warren <swarren@nvidia.com> wrote:
> > Thomas Abraham wrote at Wednesday, October 05, 2011 8:28 AM:
> >> On 5 October 2011 18:59, Rob Herring <robherring2@gmail.com> wrote:
> >> > On 10/05/2011 05:13 AM, Thomas Abraham wrote:
> >> >> Device nodes representing sd/mmc controllers in a device tree would include
> >> >> mmc host controller capabilities. Add support for parsing of mmc host
> >> >> controller capabilities included in device nodes.
> > ...
> >> >> +- linux,mmc_cap_4_bit_data - host can do 4 bit transfers
> >> >> +- linux,mmc_cap_mmc_highspeed - host can do MMC high-speed timing
> >> >> +- linux,mmc_cap_sd_highspeed - host can do SD high-speed timing
> >> >> +- linux,mmc_cap_needs_poll - host needs polling for card detection
> >> >> +- linux,mmc_cap_8_bit_data - host can do 8 bit transfer
> >> >
> >> > "sdhci,1-bit-only" already exists as a binding. Perhaps add
> >> > "sdhci,4-bit-only". No property then means can do 8-bit.
> >>
> >> Ok. But that would remain just as sdhci host controller capability and
> >> will not be applicable to other types of host controllers.
> >
> > Just as an FYI, NVIDIA's SDHCI controller bindings use property
> > "support-8bit" to indicate 8-bit support. A similar property could be
> > used for 4-bit support too.
> 
> In this case, the binding would be applicable only to nVidia's SDHCI
> controller.

Sure, this is the case right now. And I thought I'd copied this property
name from some other driver, but it looks like I'm mistaken.

> And this binding would select MMC_CAP_8_BIT_DATA in the
> sdhci-tegra driver. There are sdhci drivers that can accept host
> capabilities via platform data.
> 
> The MMC_CAP_XXX macros in linux/mmc/host.h file are usuable across
> host controllers and some of them are supplied as platform data for
> non-device tree platforms.
> 
> So, bindings for MMC_CAP_XXX macros can be defined which any host
> controller supporting device tree could use. Host controllers could
> use the mmc_of_parse_host_caps() helper function (listed in this
> patch) to parse all the bindings for MMC_CAP_XXX  available in the
> device node.
> 
> I would like to retain this patch in this series but if there is a
> definite no, then I will drop it. Please let me know your opinion.

I was simply pointing out that there are already some properties in this
area. It'd be nice if we could unify everything on a single style; either
expanding the existing "sdhci,1-bit-only" style that Rob mentioned, or
expanding the "support-8bit" style that Tegra currently uses, rather than
adding a third way of indicating this. Still, given the early state of
DT on Tegra, I'd be happy migrating Tegra to whatever single unified
approach is chosen, so don't take my comments as nak'ing your patch or
anything like that.

-- 
nvpublic

