From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/2 v4] mmc: add sdhci-tegra driver for Tegra SoCs
Date: Sat, 1 Jan 2011 22:12:44 -0800
Message-ID: <AANLkTindZo4ERuM4SKs+uBhP0c6i6oF5_G=eDBc5c6Rj@mail.gmail.com>
References: <1293928339-19373-1-git-send-email-olof@lixom.net>
	<1293928653-20001-1-git-send-email-olof@lixom.net>
	<1293928653-20001-2-git-send-email-olof@lixom.net>
	<20110102054354.GA18668@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f194.google.com ([74.125.82.194]:46331 "EHLO
	mail-wy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab1ABGMr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 2 Jan 2011 01:12:47 -0500
In-Reply-To: <20110102054354.GA18668@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Yvonne Yip <y@palm.com>

On Sat, Jan 1, 2011 at 9:43 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Olof,
>
> On Sat, Jan 01, 2011 at 06:37:33PM -0600, Olof Johansson wrote:
>> SDHCI driver for Tegra. This driver plugs in as a new variant of
>> sdhci-pltfm, using the platform data structure passed in to specify =
the
>> GPIOs to use for card detect, write protect and card power enablemen=
t.
>
> I've pushed this patchset to mmc-next for .38 now. =A0Thanks! =A0I re=
moved
> the Change-Id: tags from both commit messages, matching Linus' policy=
:
> http://thread.gmane.org/gmane.linux.kernel/1075380.

Crap, stupid repo -- I forgot to remove them by hand. Sorry about that.

> Also:
>
>> --- /dev/null
>> +++ b/drivers/mmc/host/sdhci-tegra.c
>> @@ -0,0 +1,257 @@
>> +/*
>> + * Copyright (C) 2010 The Chromium OS Authors <chromium-os-dev@chro=
mium.org>
>> + *
>> + * This software is licensed under the terms of the GNU General Pub=
lic
>> + * License version 2, as published by the Free Software Foundation,=
 and
>> + * may be copied, distributed, and modified under those terms.
>
> As discussed on IRC, this is the first time this attribution line's b=
een
> used in mainline, so I'd like to hear more about whether The Chromium=
 OS
> Authors is actually a copyright-holding entity.

Yep, I'll follow up on this.


-Olof
