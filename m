From: Pavel Machek <pavel@denx.de>
Subject: Re: [GIT PULL 1/2] SOCFPGA updates for 3.18
Date: Wed, 10 Sep 2014 13:00:57 +0200
Message-ID: <20140910110057.GA9354@amd>
References: <1409847105-27241-1-git-send-email-dinguyen@opensource.altera.com>
 <20140909141756.GA30100@amd>
 <4134101.OOENTRabu1@wuerfel>
 <20140909210232.GA539@amd>
 <CAPDyKFr35646zQUDUnv9LYy9jtY7r343hev9FrhxOfjVMb6MJw@mail.gmail.com>
 <20140910083337.GA5178@amd>
 <CAPDyKFoXiNOHQ3W=U08jU2PG-fz4F_7wuW-KNEoDfcQzrLKmVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52088 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbaIJLBA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Sep 2014 07:01:00 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFoXiNOHQ3W=U08jU2PG-fz4F_7wuW-KNEoDfcQzrLKmVA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, marex@denx.de, dinguyen@opensource.altera.com, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>, "arm@kernel.org" <arm@kernel.org>, dinh.linux@gmail.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>

Hi!

> >> 2) On the host level, the support for handle multiple slots in DT for
> >> dw-mmc has been broken. While dw-mmc parsed the DT nodes for slots, it
> >> screwed up configurations. Thus the support for slots have never
> >> worked as expected from DT point of view.
> >
> > Well, DT is supposed to describe the hardware. From your description,
> > it seems that linux does not support two slots on one controller and
> > DT parsing code basically ignores the slots. (Logical, if it can't
> > support two slots).
> >
> > So now we are breaking DT description due to Linux limitations. Which
> >
> > a) makes it hard for any other os not having same limitation
> >
> > b) makes it hard for people to fix the limitation
> >
> > c) does not really solve anything
> 
> Yes it does, the problem in 2) gets fixed.
> 
> >
> > d) breaks backward compatibility with old dts
> 
> According to 2), it has never worked - so we don't break anything.

Umm? u-SD worked for me in 3.14, 3.15 and 3.16 with the device tree,
and with single-slot described in the device tree. Now I have to
change dtb-s to keep working configuration, which is something device
tree should never ever do.

Is it so hard to just fix the multiple slot parsing?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
