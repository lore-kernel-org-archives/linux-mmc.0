From: Holger Schurig <holgerschurig@gmail.com>
Subject: Re: [RFC 0/6] mmc: Field Firmware Update
Date: Tue, 22 Dec 2015 09:15:21 +0100
Message-ID: <87r3ierjae.fsf@gmail.com>
References: <1447426572-11756-1-git-send-email-holgerschurig@gmail.com> <SN1PR02MB13891415516DE9FA4756140783070@SN1PR02MB1389.namprd02.prod.outlook.com> <CAOpc7mHbM8EYYNRKR+pKnzc0wf1DR1ojX-iFuDWDYyquC3EVZg@mail.gmail.com> <CAPDyKFp2WEVF4yi=Upzx+58SY15u=Fp4=tr3_hh7AS3T2yz4qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35156 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbbLVIPZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Dec 2015 03:15:25 -0500
In-reply-to: <CAPDyKFp2WEVF4yi=Upzx+58SY15u=Fp4=tr3_hh7AS3T2yz4qQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Avi Shchislowski <Avi.Shchislowski@sandisk.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>, Chris Ball <chris@printf.net>, Baolin Wang <baolin.wang@linaro.org>


> Sorry for the delay.

No problem, I was busy with many other projects as well.

> My advise right now is to try this out via the mmc ioctl in userspace,
> yes. Although, if you encounter any issues with that approach that it
> might not be reliable, I am open to look into the in-kernel solution
> again.

I managed to update my Kingston eMMCs with a slighly modified patch to
what I submitted. I however didn't bother to submit this, as I saw no
chance of getting it applied.

Also I once asked in the mailing list if there is some user-space
example of how to use the multi-block feature that is supposed to enable
this, but I haven't gotten an answer.

> Regarding mmc-utils as where I recommend you to implement this, I have
> been thinking of moving this tool into the tools directory in the
> kernel.

Sounds good to me.



Remotely related:

Do you know that some google people made their own version of mmc-utils
for ChromeOS? And the don't seem to give much effort in unification of
them?  As if the world wouldn't know how hard it can be to re-unite
things again, Google should know from their custom kernels they use on
Android ...  Sigh.


So you can

* git clone git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc-utils.git
* git clone https://chromium.googlesource.com/chromiumos/third_party/mmc-utils

currently.


