From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Sat, 06 Nov 2010 21:48:48 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1011062145470.18581@xanadu.home>
References: <AANLkTim+Ez8FonyZDu42u4NX-KKV0YS_J-Ya-zT-Gf9q@mail.gmail.com>
 <AANLkTinEes6Er6-WW_t8esjazrLWZ0Z7jvYJDSZL9PNG@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:14031 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400Ab0KGBss (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 6 Nov 2010 21:48:48 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz24.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LBH00A8KRP3LS00@vl-mo-mrz24.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Sat, 06 Nov 2010 21:48:39 -0400 (EDT)
In-reply-to: <AANLkTi=GjQUOBBWe96ubtxN+ndQLcOFjebrDkM_1hSSb@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Sat, 6 Nov 2010, Daniel Drake wrote:

> On 1 November 2010 08:27, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> >> On such boards, the right thing to do would be to disable runtime PM altogether.
> >
> > The patch below (/attached) should trivially fix the problem - can you
> > please check it out ?
> 
> Thanks.
> It solves the problem.
> 
> But, what you point out is quite interesting.
> We currently have a (not-yet-upstream) rfkill driver for the XO-1.5,
> which we also put in place for power saving reasons. It operates by
> calling mmc_stop_host().

Couldn't you implement this any other way?  This seems to be a really 
bad strategy for this IMHO.


Nicolas
