From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND PATCH v7 1/2] mmc: OCTEON: Add DT bindings for OCTEON MMC controller
Date: Thu, 21 Apr 2016 00:42:20 +0200
Message-ID: <5946469.zzTerM2Sfa@wuerfel>
References: <1459438013-25088-1-git-send-email-matt.redfearn@imgtec.com> <CAPDyKFrZ2FU2iGJG-KK3fLwZpu49uFamZCb7PBt+MaCGfy0Dpw@mail.gmail.com> <57180398.6040507@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:54395 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbcDTWmz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2016 18:42:55 -0400
In-Reply-To: <57180398.6040507@caviumnetworks.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Matt Redfearn <Matt.Redfearn@imgtec.com>, David Daney <david.daney@cavium.com>, linux-mmc <linux-mmc@vger.kernel.org>, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>, Rob Herring <robh+dt@kernel.org>, Ralf Baechle <ralf@linux-mips.org>

On Wednesday 20 April 2016 15:32:56 David Daney wrote:
> >
> > For A):
> > I have suggested a solution that I think can be generic, see my earlier email.
> >
> >  From the DTB point of view, I request you to update the slot
> > compatible string to a generic one. Is that a difficult task to patch
> > the DTB with?
> 
> It depends on the length of the new compatible property.  If it is 
> longer than the old property, then it is much more difficult.
> 
> 
> > If so, let's keep yours as well, but make sure it's documented as deprecated.
> >
> > Regarding the changes needed to the mmc core, as to enable it to know
> > about mmc-slots, this should be quite easy to implement. I even
> > volunteer to can help, if you think it's needed.
> >
> > So to summarize regarding A). I want a generic solution for slot nodes!
> >
> > For B), there are two cases:
> > 1. Legacy bindings that already has a corresponding generic MMC
> > binding. Renaming these properties by patching the DTB is an easy
> > operation.
> 
> It is not so easy to rename things in the DTB.  Any renaming causes the 
> string table to grow, so you have to have to allocate extra space for 
> it.  Currently everything we do with the DTB is done in-place, so you 
> would have to rewrite the early DTB handling code to allocate memory and 
> make a copy of the DTB.

Doesn't libfdt do both of these things for you?

I was expecting that you could just call fdt_setprop() and fdt_set_name(),
but I have not tried this myself.

On ARM, we actually modify the in-kernel devicetree representation
after unflattening, see e.g. arch/arm/mach-mvebu/kirkwood.c
for a file calling of_update_property(), but it seems that octeon
does its fixups at an earlier stagge using libfdt.


	Arnd
