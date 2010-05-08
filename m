From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH v8 2/2] omap hsmmc: adaptation of sdma descriptor 	autoloading feature
Date: Fri, 7 May 2010 19:43:07 -0500
Message-ID: <002c01caee47$6d210650$544ff780@am.dhcp.ti.com>
References: <w2y618f0c911004291035qfec16290re9e236ae1e13a970@mail.gmail.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C52D16D2@dbde02.ent.ti.com> <v2i618f0c911005050919m600f069ex34ba1175315cde5a@mail.gmail.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C5387398@dbde02.ent.ti.com> <v2n7f9d1ffb1005060202r91efbe3habb936f75227ffa6@mail.gmail.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C5387482@dbde02.ent.ti.com> <004501caed38$03e7b9f0$544ff780@am.dhcp.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C538792A@dbde02.ent.ti.com> <000601caee06$b2c8a9b0$544ff780@am.dhcp.ti.com> <4BE4694F.3060901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35756 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab0EHAnc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 May 2010 20:43:32 -0400
In-Reply-To: <4BE4694F.3060901@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Nishanth Menon' <nm@ti.com>
Cc: "'Shilimkar, Santosh'" <santosh.shilimkar@ti.com>, 'kishore kadiyala' <kishorek.kadiyala@gmail.com>, "'S, Venkatraman'" <svenkatr@ti.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, 'Adrian Hunter' <adrian.hunter@nokia.com>, "'Kadiyala, Kishore'" <kishore.kadiyala@ti.com>, 'Tony Lindgren' <tony@atomide.com>

<snip>

> >>>>
> >>> omap_mmc_platform_data is MMC specific platform data. Why add a SDMA
> >>> specific feature capability into it? Even though you add it there, you
> >> will
> >>> still need to have a cpu check before that can be set in a common
> code.
> >>>
> >> CPU checks are allowed to be in the platform files. That is where such
> >> machine/SOC specific differentiation should be done and not in the
> device
> >> drivers.
> >> That way device drivers remains clean and portable.
> >>
> >> I want to stop this thread here since neither the patch author nor the
> >> file
> >> maintainer thinks that cpu checks in the device drivers is bad idea.
> >>
> >> Please decide within yourself and move on.
> >>
> >
> > I am not saying that it is wrong. My point here is that adding this
> > particular flag into MMC platform data to differentiate a SDMA specific
> > feature which got introduced post certain SOC may not be needed. But you
> can
> > always post your comments on the list which will be looked at by a wider
> > audience and finally the right patch will go in.
> Please see [1] for SOC specific feature handling. any reasons we can't
> handle it by adding a new feature?
> 
> [1]
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-
> 2.6.git;a=blob;f=arch/arm/plat-omap/include/plat/cpu.h#l439
> 

Yes that makes correct sense. Note that these features will exist on omap4
also so handle in a common way. Surely this will be better than adding a
flag which does not belong to MMC platform data.

Regards,
Madhu

> --
> Regards,
> Nishanth Menon

