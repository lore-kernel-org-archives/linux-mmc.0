From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND PATCH v7 1/2] mmc: OCTEON: Add DT bindings for OCTEON MMC controller
Date: Tue, 19 Apr 2016 22:56:38 +0200
Message-ID: <5592706.5avKM3tjT7@wuerfel>
References: <1459438013-25088-1-git-send-email-matt.redfearn@imgtec.com> <CAPDyKFqM3VxYE+KtC++=5=Bjket0mCnLAuN3_436O_=TSMzAHA@mail.gmail.com> <57169429.10601@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:58046 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138AbcDSU5J (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2016 16:57:09 -0400
In-Reply-To: <57169429.10601@caviumnetworks.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Matt Redfearn <Matt.Redfearn@imgtec.com>, David Daney <david.daney@cavium.com>, linux-mmc <linux-mmc@vger.kernel.org>, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>, Rob Herring <robh+dt@kernel.org>, Ralf Baechle <ralf@linux-mips.org>

On Tuesday 19 April 2016 13:25:13 David Daney wrote:
> 
> There are several options.
> 
>    1) Invent new MMC device tree bindings that are different from what 
> we currently have, but that convey the same information.
> 
>    1a) Change the OCTEON MMC driver to use only these new bindings, and 
> write some sort of device tree fix up code that runs in early boot to 
> rewrite the device tree MMC properties.   This results in the code 
> supporting the OCTEON MMC devices being split between the driver and 
> system early boot code.  The cost is an increase in system complexity to 
> generate the device tree nodes with new bindings.
> 
>    1b) Change the OCTEON MMC driver to use either these new bindings or 
> legacy bindings.  In this case all OCTEON MMC code is localized to a 
> single driver file.  There is a small increase in complexity to carry 
> code to decode both new and legacy device tree bindings.
> 
>    2) Use existing OCTEON MMC device tree bindings, as they are 
> sufficient to achieve a working driver.  Since the code is all specific 
> to the OCTEON MMC driver, any ugliness is contained lexicographically 
> near to the features being implemented.  Any feedback related to the 
> architecture and style of the driver code would be addressed.
> 
> The current state is #2.  My interpretation of your desires is #1a.
> 
> I am fine with introducing a new device tree binding.  But, I don't 
> think the kernel as a whole nor this specific OCTEON MMC driver will be 
> improved by adding more device tree synthesis code in early boot.  Any 
> thing that is there should be limited to supporting very old (pre OCTEON 
> MMC) firmware that doesn't supply a device tree.  So I would strongly 
> support either approach #1b or #2.

My interpretation of the v7 patch is that it is much closer to 1b than
to 2. I think that is a reasonable approach. The fact that it does not
change the compatible strings of the child nodes seems ok to me too:
We can document the binding as requiring "mmc-slot" for the generic
mmc binding. This driver just doesn't look at the compatible string
for the child nodes, so it also doesn't have to change them.

I would also recommend documenting the properties that the firmware
implements in the binding document, simply listing them as "deprecated"
(or whichever word you want to use for describing them). However, I would
ask that you only allow the old-style properties for the compatible
strings that are used in the shipped DT blobs but require the use
of an updated compatible string for the new binding because the two
are not really compatible.

Given how rare the multi-slot controllers are (this being the first
known example), I think it would be good to keep that concept out of
the mmc subsystem and only do the minimum necessary documentation
for the generic binding -- conceptually we can simply treat a
cavium,octeon-6130-mmc device node as special kind of bus, and each
of its subnodes as the actual controller (this is what the driver does
anyway).

	Arnd
