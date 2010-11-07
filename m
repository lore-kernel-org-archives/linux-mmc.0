From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Sun, 07 Nov 2010 10:12:47 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1011071010540.18581@xanadu.home>
References: <AANLkTim+Ez8FonyZDu42u4NX-KKV0YS_J-Ya-zT-Gf9q@mail.gmail.com>
 <AANLkTinJ2K2cz9PSdyNoNGUS8GWfLpqRBH2C3XjO5vjO@mail.gmail.com>
 <AANLkTi=VAU=9Q+Ga7yQyu3aL7gV0vbzymQ-2uJAg1jf8@mail.gmail.com>
 <AANLkTi=QT6_zyddRz=3f6GDx-RVoiROOumhegm8pFuHU@mail.gmail.com>
 <AANLkTimfp0pPqpO03-R4yBsADQ27RLQ_PxLTfBAMfPGk@mail.gmail.com>
 <AANLkTi=gFmq47Xq+CxnU18aHyhcaF78WrWYDhga4Xf2X@mail.gmail.com>
 <AANLkTimqFBBsDCCDNOq22fuqjw7pezizZ9At+1ucGZ-j@mail.gmail.com>
 <AANLkTi=RP0i5cWO4AogGJx-sQ+17YKuiptQWi0ypYVnA@mail.gmail.com>
 <AANLkTiktD13-UC8=gwWhp9oR9_vGcM98VpRQ9i0CQg_-@mail.gmail.com>
 <AANLkTi=8Xd1xTfFvAJkicR_89JOu4P2uwyoMHvXCBKv8@mail.gmail.com>
 <AANLkTi=cPURFAitedD=mjkNiD_=ZCjakkMN6z7ecqv6k@mail.gmail.com>
 <AANLkTi=EaZbdnJzJWGH2fUadvNkUhdQgTU1rAoS5wMAs@mail.gmail.com>
 <AANLkTi=GjQUOBBWe96ubtxN+ndQLcOFjebrDkM_1hSSb@mail.gmail.com>
 <alpine.LFD.2.00.1011062145470.18581@xanadu.home>
 <AANLkTikjisWUDAa1dj9M1s1d_g_OpgekGz26AMXw+z5V@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_2nLnfDblKp4PjSBzRw8oUw)"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:49350 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab0KGPMs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Nov 2010 10:12:48 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz25.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LBI00KHGSWX59F0@vl-mh-mrz25.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Sun, 07 Nov 2010 10:12:33 -0500 (EST)
In-reply-to: <AANLkTikjisWUDAa1dj9M1s1d_g_OpgekGz26AMXw+z5V@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_2nLnfDblKp4PjSBzRw8oUw)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Sun, 7 Nov 2010, Daniel Drake wrote:

> On 7 November 2010 01:48, Nicolas Pitre <nico@fluxnic.net> wrote:
> > Couldn't you implement this any other way?  This seems to be a really
> > bad strategy for this IMHO.
> 
> What's so bad about it?
> Any suggestions?

If you want rfkill functionality, then maybe that would be a good idea 
to implement it _within_ the libertas driver instead of hacking 
something around it in an unrelated fashion.


Nicolas

--Boundary_(ID_2nLnfDblKp4PjSBzRw8oUw)--
