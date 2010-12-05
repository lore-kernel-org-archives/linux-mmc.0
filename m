From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 1/1]sdhci-pxa: support tune_timming for various cards
Date: Sun, 5 Dec 2010 03:30:36 +0000
Message-ID: <20101205033035.GC24000@void.printf.net>
References: <AANLkTi=h1p98z542H=EzFaqnHmEDkQDPZ5QmCQGo4Cik@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49922 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752396Ab0LEDai (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 4 Dec 2010 22:30:38 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=h1p98z542H=EzFaqnHmEDkQDPZ5QmCQGo4Cik@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>

Hi Zhangfei,

On Thu, Nov 11, 2010 at 08:19:12AM -0500, zhangfei gao wrote:
> Hi, Chirs & Eric
>=20
> Thanks for review, here is updated version.
> 1. After clk_gating is enabled, set_clock will transfer clock=3D0, so
> clk_disable will be called, currently set_clock will never transfer
> clock=3D0.
> Later tune_timing only occurs once clock is started, currently it wil=
l
> happen when clock is changed.

There are still some review comments that haven't been replied to yet:

* Eric asked whether you really need to tune on every clock change, or
  if once at initialization time would be enough.

* I asked why we shouldn't just inline tune_timing() at its callsite,
  since it's a void function that's only called from one place.

* Philip points out that SD_CLOCK_AND_BURST_SIZE_SETUP is an MMP2-only
  register and should be marked as such, and I agree.  Even *if*
  sdhci-pxa wasn't going to support non-MMP2 SoCs=B9, you should still
  mark hardware-specific registers with the hardware they're used on.

Speaking generally, please always reply to review comments -- even if
it's just to explain why you considered a suggested change and aren't
going to make it.

Thanks,

- Chris.

=B9: (.. which doesn't seem to be the case, since you've since posted a
   patchset that generalizes the driver.)
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
