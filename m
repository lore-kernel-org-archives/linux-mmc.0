From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v1 1/3]mmc: implemented runtime pm for mmc host
Date: Mon, 24 Jan 2011 10:01:07 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101240955330.8580@xanadu.home>
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
Content-Type: multipart/mixed; boundary="Boundary_(ID_GA8hGsVBwAqVti5r/Jfl7w)"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:18557 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033Ab1AXPBI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Jan 2011 10:01:08 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFJ0002D8DJ54B0@VL-MR-MRZ20.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Mon, 24 Jan 2011 10:00:55 -0500 (EST)
In-reply-to: <AANLkTimSZxUue0jcjoD7GjwDxOwdYVSiHEE4eHcGgG8W@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Chris Ball <cjb@laptop.org>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "Tardy, Pierre" <pierre.tardy@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.ml.walleij@gmail.com>, "Gao, Yunpeng" <yunpeng.gao@intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_GA8hGsVBwAqVti5r/Jfl7w)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Sun, 23 Jan 2011, Ohad Ben-Cohen wrote:

> On Sun, Jan 23, 2011 at 7:20 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > First case:  you want to stop the clock _to_ the _card_ when not talking
> > to it.  That has nothing to do with power saving performed within the
> > host controller.  This is for reducing power consumption by the _card_
> > (and possibly by the clock generator).  The runtime PM stuff has no
> > business here as the decision to gate the clock on the card require
> > MMC/SD protocol knowledge.
> 
> But why can't it be implemented using the runtime PM framework ?

Because as I see things now, it'll only make the code more complex for 
no real gain.

> It's just plumbing; the decision and knowledge stays at the MMC core.
> 
> It's possible to do it without making any compromises of use cases and
> requirements. And if something is missing in the runtime PM framework,
> it can be changed. It just needs someone who cares.

I don't feel like modifying a generic infrastructure like the runtime PM 
framework just to accommodate a special case from the MMC subsystem 
which the MMC subsystem already handles well now anyway is necessarily 
productive.  That will only increase complexity on both sides: the 
runtime PM framework _and_ the MMC subsystem.  But hey, that someone who 
cares may prove me wrong.


Nicolas

--Boundary_(ID_GA8hGsVBwAqVti5r/Jfl7w)--
