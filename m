From: Linus WALLEIJ <linus.walleij@stericsson.com>
Subject: RE: [PATCH 1/7] DMAENGINE: add generic PrimeCell interface to COH
 901 	318 v6
Date: Wed, 12 May 2010 09:39:23 +0200
Message-ID: <CEE6BB42CAD6E947908279175AF8470A025A6DE803@EXDCVYMBSTM006.EQ1STM.local>
References: <1272848076-28315-1-git-send-email-linus.walleij@stericsson.com>
	 <AANLkTinAVhnpjgVTtbZYYKb1t_DInVwTKkkJRzcO97RX@mail.gmail.com>
 <AANLkTim7Tp8lCwMbQwW5QiQ49j7idFFUWdU3x8azIlok@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:34574 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751810Ab0ELHqh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 12 May 2010 03:46:37 -0400
In-Reply-To: <AANLkTim7Tp8lCwMbQwW5QiQ49j7idFFUWdU3x8azIlok@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

[Dan]

> >> +void dma_set_ambaconfig(struct dma_chan *chan,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct amba_dma_chan=
nel_config *config)
> >
> > What happens when two primecell dma devices are present on one soc?
> > Can that happen? =A0In that case we'll have conflicting providers o=
f
> > dma_set_ambaconfig().
> >
>=20
> ...the ->device_control() method is already approaching an ioctl()
> let's just add the argument parameter to complete the capability,
> i.e.:
>=20
> int (*device_control)(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
> unsigned long arg);

So the unsigned long arg is to match an ioctl? Okidoki...

If it was only for in-kernel use a void* would be preferred
I believe since assuming unsigned long to be =3D=3D bus width
is ... well, disturbing, since we'll be casting this into
a struct pointer.

So this should also be used for the AMBA configuration stuff
then, so I have to make first a patch to convert all the
device_control functions and then a patch on top of that to
implement the AMBA call as a device_control() thingie?

(Should work out...)

Just a bit of work, so will take some more hours :-)

I will just have to make a proof-of-concept for the AMBA config
interface for Russell first, then I'll be on the ioctl-like API.

Yours,
Linus Walleij
