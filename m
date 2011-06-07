From: Arnd Hannemann <arnd@arndnet.de>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Tue, 07 Jun 2011 16:34:43 +0200
Message-ID: <4DEE3703.2070600@arndnet.de>
References: <AANLkTim+Ez8FonyZDu42u4NX-KKV0YS_J-Ya-zT-Gf9q@mail.gmail.com> <AANLkTimqFBBsDCCDNOq22fuqjw7pezizZ9At+1ucGZ-j@mail.gmail.com> <AANLkTi=RP0i5cWO4AogGJx-sQ+17YKuiptQWi0ypYVnA@mail.gmail.com> <AANLkTiktD13-UC8=gwWhp9oR9_vGcM98VpRQ9i0CQg_-@mail.gmail.com> <AANLkTi=8Xd1xTfFvAJkicR_89JOu4P2uwyoMHvXCBKv8@mail.gmail.com> <AANLkTi=cPURFAitedD=mjkNiD_=ZCjakkMN6z7ecqv6k@mail.gmail.com> <BANLkTikpciJnTudOeSLM_O7AAD4GGkbbOw@mail.gmail.com> <BANLkTikQC+u5yyU+YBAZ5JpFDRFHrHNOoA@mail.gmail.com> <BANLkTi=kqnnGf3ezS=cSXCcHpmK3JxwXtg@mail.gmail.com> <BANLkTi=o6Hgb=icinjmZqVx09dx+cp-enw@mail.gmail.com> <BANLkTimuLrCd3oHeWOC73scuQ6ydvuwpvw@mail.gmail.com> <BANLkTimmSu33PTDn9ybOSbAfObPe4C-rZA@mail.gmail.com> <477F20668A386D41ADCC57781B1F704307FD0BF3B1@SC-VEXCH1.marvell.com> <BANLkTi=nz8c9P2qi9FWE+QU
 0XzSFddUAhA@mail.gmail.com> <477F20668A386D41ADCC57781B1F704307FD0BF3BE@SC-VEXCH1.marvell.com> <BANLkTi=qR7bbsnzsCpV=b2C4Ha5Hdb94gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from slowhand.arndnet.de ([88.198.19.76]:32776 "EHLO mail.unitix.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753399Ab1FGOzZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Jun 2011 10:55:25 -0400
In-Reply-To: <BANLkTi=qR7bbsnzsCpV=b2C4Ha5Hdb94gQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Bing Zhao <bzhao@marvell.com>, zhangfei gao <zhangfei.gao@gmail.com>, Daniel Drake <dsd@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mike Rapoport <mike@compulab.co.il>, Zhangfei Gao <zgao6@marvell.com>

Hi Ohad,

Am 04.06.2011 00:52, schrieb Ohad Ben-Cohen:
> (cc'ing Arnd Hannermann)
> 
> On Sat, Jun 4, 2011 at 1:28 AM, Bing Zhao <bzhao@marvell.com> wrote:
>> "CMD5 Arg=0" refers to the very first CMD5 sent from host during initialization sequence.
>> This is required because our state machine always expects two CMD5 from host (5, 5, 3, 7, ...).
> 
> Great, thanks for confirming this !
> 
> Arnd, you have reported SDIO runtime pm issues with the b43 in the
> past. If you're still interested and have some free cycles, you might
> want to check out Daniel's patch and see if that fixes the issues you
> had too. With Daniel's patch we're now following the spec more
> strictly, and the change is particularly relevant for removable SDIO
> cards like the one you were using.

Sorry, I don't have the hardware anymore so I'm not able to check this.

Best regards
Arnd
