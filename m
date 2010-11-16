From: Daniel Drake <dsd@laptop.org>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Tue, 16 Nov 2010 14:29:01 +0000
Message-ID: <AANLkTimRFC81ZiLuiUmhvXOpUddBjhVBezJEB8_BDyuu@mail.gmail.com>
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
	<AANLkTinzvte389GNHtD2N0wO9mYsysCG9+Z1AFVZRn0E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51158 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933096Ab0KPO3D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Nov 2010 09:29:03 -0500
Received: by yxf34 with SMTP id 34so321950yxf.19
        for <linux-mmc@vger.kernel.org>; Tue, 16 Nov 2010 06:29:01 -0800 (PST)
In-Reply-To: <AANLkTinzvte389GNHtD2N0wO9mYsysCG9+Z1AFVZRn0E@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Arnd Hannemann <arnd@arndnet.de>

On 16 November 2010 13:22, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Just to update the list, the problem with the XO-1.5 was because the
> sd8686 has an external reset gpio line which is currently being
> manipulated manually by an out-of-tree kernel patch:
>
> http://dev.laptop.org/git/olpc-2.6/commit/?h=olpc-2.6.35&id=e9bee721fb0cc303286d1fe5df4930ce79b0b1e0
>
> ... which makes me wonder whether we really want to take that
> MMC_CAP_RUNTIME_PM road. I'm not sure anymore.

OLPC is not the only user of the sd8686.
Every other user will face the same problem.

Other users may not have the luxury of having a GPIO hooked up to the
reset line.
It's not like Marvell made this limitation very widely known.

Daniel
