From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Sat, 11 Jun 2011 12:03:27 +0300
Message-ID: <BANLkTi=BjOrT-Arg+KzYpFbfk6vAO1sKHQ@mail.gmail.com>
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
 <BANLkTimuLrCd3oHeWOC73scuQ6ydvuwpvw@mail.gmail.com> <BANLkTimmSu33PTDn9ybOSbAfObPe4C-rZA@mail.gmail.com>
 <477F20668A386D41ADCC57781B1F704307FD0BF3B1@SC-VEXCH1.marvell.com>
 <BANLkTi=nz8c9P2qi9FWE+QU0XzSFddUAhA@mail.gmail.com> <477F20668A386D41ADCC57781B1F704307FD0BF3BE@SC-VEXCH1.marvell.com>
 <BANLkTi=qR7bbsnzsCpV=b2C4Ha5Hdb94gQ@mail.gmail.com> <BANLkTimZ+Emm6GrTztEaGnjRu92Pam13mQ@mail.gmail.com>
 <BANLkTi=KjP9sUD0+QjDrJro0JXW4A+zOKg@mail.gmail.com> <BANLkTinDe6fOavZZ+1c1OKS7XMf_J5YhaA@mail.gmail.com>
 <BANLkTinyU5x5QFbDs2bqbZ0ebpRhe+aSSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58901 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357Ab1FKJDs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Jun 2011 05:03:48 -0400
Received: by wya21 with SMTP id 21so2307940wya.19
        for <linux-mmc@vger.kernel.org>; Sat, 11 Jun 2011 02:03:47 -0700 (PDT)
In-Reply-To: <BANLkTinyU5x5QFbDs2bqbZ0ebpRhe+aSSw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Bing Zhao <bzhao@marvell.com>, Daniel Drake <dsd@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mike Rapoport <mike@compulab.co.il>, Zhangfei Gao <zgao6@marvell.com>, Benson Chau <bchau@marvell.com>

On Sat, Jun 11, 2011 at 5:33 AM, zhangfei gao <zhangfei.gao@gmail.com> wrote:
> If you power down and up the device, then IO reset is not needed and
> 8686 can process host init sequence correctly.

Thanks, that's what I thought.

Daniel, this ultimately means that whenever sending a reset is
required to re-init the 8686, we can surely say that the chip wasn't
really powered off beforehand, and that something went wrong in the
software, leading us to think the chip is powered off when it is
really not.

But I think we also demonstrated this with the simple
insmod/rmmod/insmod scenario, where every insmod successfully
re-initialized the chip without sending an sdio reset.

Thanks,
Ohad.
