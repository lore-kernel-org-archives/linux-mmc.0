From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 4/6] mmc: sdhci_pltfm: pass more data on custom
 init-call
Date: Thu, 30 Sep 2010 13:42:02 +0400
Message-ID: <20100930094202.GA581@oksana.dev.rtsoft.ru>
References: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
 <1285790884-3516-5-git-send-email-w.sang@pengutronix.de>
 <19620.19198.88841.623775@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36993 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955Ab0I3JmI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Sep 2010 05:42:08 -0400
Received: by eyb6 with SMTP id 6so632278eyb.19
        for <linux-mmc@vger.kernel.org>; Thu, 30 Sep 2010 02:42:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <19620.19198.88841.623775@ipc1.ka-ro>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org, Zhu Richard-R65037 <r65037@freescale.com>, zhangfei gao <zhangfei.gao@gmail.com>, Philip Rakity <prakity@marvell.com>, linux-arm-kernel@lists.infradead.org

On Thu, Sep 30, 2010 at 10:31:58AM +0200, Lothar Wa=C3=9Fmann wrote:
> > The custom init call may need more data to perform its job, so we p=
ass
> > it a pointer to pdata, too. Also, always use the platform_id specif=
ic
> > data even if platform_data is present. Doing that, platform_data ca=
n
> > additionally be parsed by init() for board-specific information (vi=
a
> > sdhci->mmc->parent).
> >=20
> Why not a pointer to the platform_device itself? Then the callback
> function would have even more information (e.g. platform_device ID)
> and could easily get at the platform_data too.

dev->platform_data may not be there. There are two ways to pass
the "platform data" to the sdhci-pltfm driver:

a) via dev->platform_data
b) via platform_device_id->driver_data

Technically, we can do something like this in the probe():

if (!pdev->dev.platform_data)
	pdev->dev.platform_data =3D platform_device_id->driver_data;

pdata->init(dev);

Note, in this case we must also NULLify platform_data it at remove(),
as platform_device_release() will try to free statically allocated
memory.

Thanks,

--=20
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
