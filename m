From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH v1 1/3]mmc: implemented runtime pm for mmc host
Date: Mon, 24 Jan 2011 18:19:32 +0800
Message-ID: <5D8008F58939784290FAB48F5497519835484362C8@shsmsx502.ccr.corp.intel.com>
References: <20110114082310.GB27523@intel.com>
 <8250E4885F9967469CAC3FB5CBA2CE69934E7AA2FE@irsmsx501.ger.corp.intel.com>
 <5D8008F58939784290FAB48F54975198351D4FA654@shsmsx502.ccr.corp.intel.com>
 <8250E4885F9967469CAC3FB5CBA2CE69934E7AAB20@irsmsx501.ger.corp.intel.com>
 <5D8008F58939784290FAB48F5497519835247E72AD@shsmsx502.ccr.corp.intel.com>
 <8250E4885F9967469CAC3FB5CBA2CE69934E7AACCC@irsmsx501.ger.corp.intel.com>
 <20110120050803.GA5732@void.printf.net>
 <AANLkTi=oOzU0fb+yGkKDkjviGWO8fq=k68+Syp+dWn5B@mail.gmail.com>
 <alpine.LFD.2.00.1101222358370.8580@xanadu.home>
 <AANLkTimSZxUue0jcjoD7GjwDxOwdYVSiHEE4eHcGgG8W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:21036 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197Ab1AXKTt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Jan 2011 05:19:49 -0500
In-Reply-To: <AANLkTimSZxUue0jcjoD7GjwDxOwdYVSiHEE4eHcGgG8W@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Nicolas Pitre <nico@fluxnic.net>
Cc: Chris Ball <cjb@laptop.org>, "Tardy, Pierre" <pierre.tardy@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.ml.walleij@gmail.com>, "Gao, Yunpeng" <yunpeng.gao@intel.com>

> -----Original Message-----
> From: Ohad Ben-Cohen [mailto:ohad@wizery.com]
> Sent: Monday, January 24, 2011 4:40 AM
> To: Nicolas Pitre
> Cc: Chris Ball; Dong, Chuanxiao; Tardy, Pierre; linux-mmc@vger.kernel=
=2Eorg; Linus
> Walleij; Gao, Yunpeng
> Subject: Re: [PATCH v1 1/3]mmc: implemented runtime pm for mmc host
>=20
> On Sun, Jan 23, 2011 at 7:20 AM, Nicolas Pitre <nico@fluxnic.net> wro=
te:
> > First case: =A0you want to stop the clock _to_ the _card_ when not =
talking
> > to it. =A0That has nothing to do with power saving performed within=
 the
> > host controller. =A0This is for reducing power consumption by the _=
card_
> > (and possibly by the clock generator). =A0The runtime PM stuff has =
no
> > business here as the decision to gate the clock on the card require
> > MMC/SD protocol knowledge.
>=20
> But why can't it be implemented using the runtime PM framework ?
>=20
> It's just plumbing; the decision and knowledge stays at the MMC core.
>=20
> It's possible to do it without making any compromises of use cases an=
d
> requirements. And if something is missing in the runtime PM framework=
,
> it can be changed. It just needs someone who cares.
I agree with Ohad.
=46irst I also agree with Nicolas clock gating and runtime pm are diffe=
rent cases, all of us want runtime pm and clock gating for mmc driver. =
So that, I think we can treat the clock gating as a shallow power consu=
ming and runtime pm as a deep power consuming. When there is no new req=
uest after about 8 clock cycles idle, mmc driver can try to do a shallo=
w power consuming - clock gating. And then if in the next a few time, h=
ost controller is still idle, we can try to do a deep power consuming -=
 power off host controller. Is this acceptable?

Second, let us consider about the implementation about clock gating. To=
 my understanding, what MMC driver does in clock gating framework is ju=
st waiting for 8 clock cycles and then trying to gate the clock, no oth=
er special. Linus W, correct me if I am wrong. The runtime pm framework=
 also provide some functions which can let driver wait for some clock c=
ycles and then try to do something. So I think we can use what the runt=
ime pm framework provided to implement the clock gating, no need to mai=
ntain some code in MMC driver doing the same thing which has already be=
en implemented by runtime pm framework.

We can use runtime pm framework to implement clock gating and power man=
agement. The two cases has no dependence with each other. If the host c=
ontroller cannot power off, just not enable the runtime pm in host cont=
roller driver.

Thanks
Chuanxiao
