From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] mmc:sdhci:add support to request/free pins for
 controllers sharing hardware bus
Date: Tue, 26 Apr 2011 15:27:28 +0800
Message-ID: <BANLkTineayh539zJx6GfxnpgCJwJdxYy0Q@mail.gmail.com>
References: <5EB3BFCD089AD643B9BB63439F5FD5E9A127@SHAASIEXM01.ASIA.ROOT.PRI>
 <BANLkTinj4pnDG=cCJY3JGYGXOYoVPHtA9A@mail.gmail.com> <m3d3k9u0yy.fsf@pullcord.laptop.org>
 <BANLkTimXXirF6zqx9h9DMRSpx+o8_vb=3w@mail.gmail.com> <20110426065851.GA14534@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:36878 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757500Ab1DZH1s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2011 03:27:48 -0400
Received: by qyk7 with SMTP id 7so1056488qyk.19
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2011 00:27:48 -0700 (PDT)
In-Reply-To: <20110426065851.GA14534@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Binghua.Duan@csr.com, andreiw@motorola.com, prakity@marvell.com

Hi Wolfram,

2011/4/26 Wolfram Sang <w.sang@pengutronix.de>:
>> > * Where is the patch that implements the get_shared_pins() hook in
>> > =C2=A0your driver?
>> We send the common level patch ahead to get the upstream agreement s=
o
>> that we can maintain our bottom level sdhci codes better. We will se=
nd
>> the special driver patch after some time.
>
> Hmm, why should be there a functionality if there is no user for it? =
A
> reference user helps people understand how it is intended to be used.

completely right. Of course this patch is based on real applications
and SoCs. We are using ARASAN sd controller IP, it can be configurated
to use shared pins mode in SoC design. And it looks like it is a
common requirement to save chip footprint by sharing data bus between
multi-controllers.

Just because Our SoCs are still on the way to opensource and mainline.
Even our arch/arm/mach-xxx hasn't been merged yet. Our target is
syncing our codes with mainline. So as a modification to sdhci common
level, we just get upstream's opinion for local maintaining earlier.

Anyway, this patch may be applied later after our others are ready. Or
it can be now so that other SoC companies can use this feature.

>
> Regards,
>
> =C2=A0 Wolfram
>
> --
> Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Wolfram Sang =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> Industrial Linux Solutions =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | http://www.pengutronix.de/ =C2=A0|
>
