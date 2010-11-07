From: Daniel Drake <dsd@laptop.org>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Sun, 7 Nov 2010 10:19:15 +0000
Message-ID: <AANLkTikjisWUDAa1dj9M1s1d_g_OpgekGz26AMXw+z5V@mail.gmail.com>
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
	<alpine.LFD.2.00.1011062145470.18581@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48462 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358Ab0KGKTQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Nov 2010 05:19:16 -0500
Received: by yxk8 with SMTP id 8so2884979yxk.19
        for <linux-mmc@vger.kernel.org>; Sun, 07 Nov 2010 02:19:16 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1011062145470.18581@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On 7 November 2010 01:48, Nicolas Pitre <nico@fluxnic.net> wrote:
> Couldn't you implement this any other way? =A0This seems to be a real=
ly
> bad strategy for this IMHO.

What's so bad about it?
Any suggestions?

Daniel
