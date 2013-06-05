From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 07/10] pinctrl: add pinctrl driver for Rockchip SoCs
Date: Wed, 05 Jun 2013 11:18:49 -0600
Message-ID: <51AF72F9.3060307@wwwdotorg.org>
References: <201306030055.15413.heiko@sntech.de> <201306030059.47611.heiko@sntech.de> <CACRpkdbBr7s1NoTQewVOotorHJHLL8Z6-_gAx5GC0x6uNUX0gw@mail.gmail.com> <201306041405.13320.heiko@sntech.de> <CACRpkdZty-TszfBTOab4_PUi8dy5DYim=wNERv=pyqC3HNuT4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:50685 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756190Ab3FERSz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Jun 2013 13:18:55 -0400
In-Reply-To: <CACRpkdZty-TszfBTOab4_PUi8dy5DYim=wNERv=pyqC3HNuT4w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Turquette <mturquette@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On 06/05/2013 01:01 AM, Linus Walleij wrote:
> On Tue, Jun 4, 2013 at 2:05 PM, Heiko St=FCbner <heiko@sntech.de> wro=
te:
=2E..
>> The only problem is the pull stuff mentioned above that is either pu=
ll up or
>> down without the driver having knowledge about it. And generic_pinco=
nf only
>> knows about them separately right now.
>=20
> Create a separate patch adding PIN_CONFIG_BIAS_PULL_AUTO
> to include/linux/pinctrl/pinconf-generic.h, don't forget the
> kerneldoc, and patching drivers/pinctrl/pinconf-generic.c.

"AUTO" sounds really rather generic. Based on just the word "AUTO", I
have no idea if it's a HW- or SW-supplied default, or what the algorith=
m
is for determining the automatically selected value. Perhaps
s/AUTO/PIN_DEFAULT/ or something like that?

While the concept is simple enough, it's unusual enough that such a
patch would hopefully have a comment containing a full explanation of
exactly what this option means.
