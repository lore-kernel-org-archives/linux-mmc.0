From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH v8 2/2] omap hsmmc: adaptation of sdma descriptor
	autoloading feature
Date: Thu, 6 May 2010 14:32:22 +0530
Message-ID: <v2n7f9d1ffb1005060202r91efbe3habb936f75227ffa6@mail.gmail.com>
References: <w2y618f0c911004291035qfec16290re9e236ae1e13a970@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C52D16D2@dbde02.ent.ti.com>
	 <v2i618f0c911005050919m600f069ex34ba1175315cde5a@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C5387398@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5387398@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "S, Venkatraman" <svenkatr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

<<snip>>

>> I am not clear about the method. The board files export the
>> omap_mmc_platform_data.
>> Does it imply that all board files have to change and export
>> the capability so that it can be queried ?
> No. You don't have to modify the board files. This would need
> change in devices.c which common for all omap boards.
>
> I don't have a strong opinion on this point but just put forth an
> alternate way to avoid such SOC specific check in drivers.
> You can take call on this

Agree. How about adding a flag in hsmmc.h & omap_mmc_platform_data,
that would take care of SDMA & SDMA_DLAOD in the driver instead  going
with SOC check .
