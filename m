From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v1 1/3]mmc: implemented runtime pm for mmc host
Date: Sun, 23 Jan 2011 22:39:37 +0200
Message-ID: <AANLkTimSZxUue0jcjoD7GjwDxOwdYVSiHEE4eHcGgG8W@mail.gmail.com>
References: <20110114082310.GB27523@intel.com> <8250E4885F9967469CAC3FB5CBA2CE69934E7AA2FE@irsmsx501.ger.corp.intel.com>
 <5D8008F58939784290FAB48F54975198351D4FA654@shsmsx502.ccr.corp.intel.com>
 <8250E4885F9967469CAC3FB5CBA2CE69934E7AAB20@irsmsx501.ger.corp.intel.com>
 <5D8008F58939784290FAB48F5497519835247E72AD@shsmsx502.ccr.corp.intel.com>
 <8250E4885F9967469CAC3FB5CBA2CE69934E7AACCC@irsmsx501.ger.corp.intel.com>
 <20110120050803.GA5732@void.printf.net> <AANLkTi=oOzU0fb+yGkKDkjviGWO8fq=k68+Syp+dWn5B@mail.gmail.com>
 <alpine.LFD.2.00.1101222358370.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33198 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab1AWUj5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 23 Jan 2011 15:39:57 -0500
Received: by iyj18 with SMTP id 18so3357014iyj.19
        for <linux-mmc@vger.kernel.org>; Sun, 23 Jan 2011 12:39:57 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1101222358370.8580@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Chris Ball <cjb@laptop.org>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "Tardy, Pierre" <pierre.tardy@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.ml.walleij@gmail.com>, "Gao, Yunpeng" <yunpeng.gao@intel.com>

On Sun, Jan 23, 2011 at 7:20 AM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> First case: =A0you want to stop the clock _to_ the _card_ when not ta=
lking
> to it. =A0That has nothing to do with power saving performed within t=
he
> host controller. =A0This is for reducing power consumption by the _ca=
rd_
> (and possibly by the clock generator). =A0The runtime PM stuff has no
> business here as the decision to gate the clock on the card require
> MMC/SD protocol knowledge.

But why can't it be implemented using the runtime PM framework ?

It's just plumbing; the decision and knowledge stays at the MMC core.

It's possible to do it without making any compromises of use cases and
requirements. And if something is missing in the runtime PM framework,
it can be changed. It just needs someone who cares.
