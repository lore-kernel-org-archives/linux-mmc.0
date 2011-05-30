From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Mon, 30 May 2011 14:16:07 +0300
Message-ID: <BANLkTimmSu33PTDn9ybOSbAfObPe4C-rZA@mail.gmail.com>
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
 <BANLkTikpciJnTudOeSLM_O7AAD4GGkbbOw@mail.gmail.com> <BANLkTikQC+u5yyU+YBAZ5JpFDRFHrHNOoA@mail.gmail.com>
 <BANLkTi=kqnnGf3ezS=cSXCcHpmK3JxwXtg@mail.gmail.com> <BANLkTi=o6Hgb=icinjmZqVx09dx+cp-enw@mail.gmail.com>
 <BANLkTimuLrCd3oHeWOC73scuQ6ydvuwpvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52676 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697Ab1E3LQ2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 May 2011 07:16:28 -0400
Received: by wya21 with SMTP id 21so2551919wya.19
        for <linux-mmc@vger.kernel.org>; Mon, 30 May 2011 04:16:27 -0700 (PDT)
In-Reply-To: <BANLkTimuLrCd3oHeWOC73scuQ6ydvuwpvw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Daniel Drake <dsd@laptop.org>, linux-mmc@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>, Zhangfei Gao <zhangfei.gao@marvell.com>, Bing Zhao <bzhao@marvell.com>

Hi Zhangfei, Bing,

On Mon, May 30, 2011 at 2:04 PM, zhangfei gao <zhangfei.gao@gmail.com> wrote:
> sd8686 requires two pins to control power, PDn and RESETn.
> To enable sd8686, PDn and RESETn should both set high.
> To disable sd8686, PDn should be set low.

If we power down the sd8686, and power it up again, without toggling
the reset pin at all (e.g. keep it always high), will the card work ?

Thanks,
Ohad.
