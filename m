From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 3/8] sdhci: Use work structs instead of tasklets
Date: Mon, 21 Oct 2013 12:44:20 +0100
Message-ID: <86li1mq25n.fsf@void.printf.net>
References: <1381940458-12628-1-git-send-email-jeremie.samuel.ext@parrot.com>
	<1381940458-12628-4-git-send-email-jeremie.samuel.ext@parrot.com>
	<874n8b9ywb.fsf@octavius.laptop.org> <5264E78B.1020209@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40689 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753205Ab3JULoY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 21 Oct 2013 07:44:24 -0400
In-Reply-To: <5264E78B.1020209@parrot.com> (Jeremie Samuel's message of "Mon,
	21 Oct 2013 10:36:27 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Cc: linux-mmc@vger.kernel.org, =?utf-8?Q?Gr=C3=A9gor?= Boirie <gregor.boirie@parrot.com>, Matthieu Castet <matthieu.castet@parrot.com>, Anton Vorontsov <avorontsov@mvista.com>

Hi Jeremie,

On Mon, Oct 21 2013, Jeremie Samuel wrote:
> Do you have a way for me to compile the driver for all the
> architectures impacted by the patch? So I could send a patch which
> compile for all these architectures.

If you can get an ARM cross-compiler going, it would look something
like this:

$ mkdir obj.dove obj.imx obj.s3c obj.spear obj.tegra

$ cp arch/arm/configs/dove_defconfig obj.dove
$ cp arch/arm/configs/imx_v6_v7_defconfig obj.imx
$ cp arch/arm/configs/s3c6400_defconfig obj.s3c
$ cp arch/arm/configs/spear3xx_defconfig obj.spear
$ cp arch/arm/configs/tegra_defconfig obj.tegra

$ ARCH=arm CROSS_COMPILE=arm-linux-gnu- make -j12 O=obj.dove
$ ARCH=arm CROSS_COMPILE=arm-linux-gnu- make -j12 O=obj.imx
$ ARCH=arm CROSS_COMPILE=arm-linux-gnu- make -j12 O=obj.s3c
$ ARCH=arm CROSS_COMPILE=arm-linux-gnu- make -j12 O=obj.spear
$ ARCH=arm CROSS_COMPILE=arm-linux-gnu- make -j12 O=obj.tegra

There's also sdhci-sirf, but it has its own architecture.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
