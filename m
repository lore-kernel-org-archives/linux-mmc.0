From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch 1/1] sdhci-base-clock-freqency-change-in-spec-3.0
Date: Sun, 19 Sep 2010 09:56:05 +0800
Message-ID: <AANLkTikYT_G8u0PwR=YSpEnU1WPc8E4sZiKGvNF3rsxk@mail.gmail.com>
References: <AANLkTims_z+X_bOK2v3AekBZWg1LsSecRCUeAi5HGseW@mail.gmail.com>
	<20100914131853.GC17079@void.printf.net>
	<20100914134539.GE2629@pengutronix.de>
	<AANLkTi=7gXkF+JpOfM+KaWxHPDzT=0SL5oSXDw0hTmJm@mail.gmail.com>
	<20100915101019.GC5985@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58192 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754794Ab0ISB4G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Sep 2010 21:56:06 -0400
Received: by iwn5 with SMTP id 5so3138780iwn.19
        for <linux-mmc@vger.kernel.org>; Sat, 18 Sep 2010 18:56:05 -0700 (PDT)
In-Reply-To: <20100915101019.GC5985@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Matt Fleming <matt@console-pimps.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>

On Wed, Sep 15, 2010 at 6:10 PM, Wolfram Sang <w.sang@pengutronix.de> w=
rote:
> On Wed, Sep 15, 2010 at 11:35:18AM +0800, zhangfei gao wrote:
>
>> > Is the 8-bit support really according to the standard? I wonder be=
cause
>> > the bit currently used by sdhci.c is marked as "reserved/new assig=
nment
>> > now allowed" in the simplified v2.0 spec.
>>
>> Attached capacity in sdh 3.0.
>> 6-bit base clock frequece is support in 1.0 and 2.0, support 10M to =
63M.
>> 8-bit is supported in 3.0, and support 10M to 255M.
>
> I meant 8-bit bus width. Which bit in which register selects this?

The 8-bit bus width usually used in embeded mmc, like Micron emmc and
sandisk emmc, bit[5] of host controller (0x28h) is added in sdh spec
3.0, and the patch is already in the latest kernel.

>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| Wolfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://w=
ww.pengutronix.de/ =A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAkyQm4sACgkQD27XaX1/VRuafACgxxhhat+eHjTEFspi+Nwn3/K8
> gVsAnRuhxy2C452n57jxhDDYdNdtZrP6
> =3DH7hA
> -----END PGP SIGNATURE-----
>
>
