From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Mon, 20 Jan 2014 20:12:46 +0100
Message-ID: <53209494.QWyQq2MDnI@wuerfel>
References: <1390190215-22700-1-git-send-email-olof@lixom.net> <201401201958.57997.arnd@arndb.de> <CAOesGMgMnvFAFiO_K4U5n08Tj+ZPWh656D=vgaQOyYbVCyvSDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54665 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbaATTNE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jan 2014 14:13:04 -0500
In-Reply-To: <CAOesGMgMnvFAFiO_K4U5n08Tj+ZPWh656D=vgaQOyYbVCyvSDg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, chris@printf.net, Rob Herring <robh+dt@kernel.org>, ijc+devicetree@hellion.org.ok, Kumar Gala <galak@codeaurora.org>

On Monday 20 January 2014 11:04:26 Olof Johansson wrote:
> 
> I'd expect most usage of this to be through gpios, since we're talking
> about external independent modules here. I would prefer not to bring
> in the reset controller stuff here -- it just adds another layer of
> abstraction that seems unnecessary.
> 
> I would prefer if the reset framework was contained to only be the
> on-chip SoC IP block resets, etc, as originally intended.

Ok, fair enough.

	Arnd
