From: Alex Lemberg <Alex.Lemberg@sandisk.com>
Subject: RE: [RFC 0/6] mmc: Field Firmware Update
Date: Mon, 28 Dec 2015 14:12:05 +0000
Message-ID: <BLUPR02MB2773299A3F882A172DF0E3694FB0@BLUPR02MB277.namprd02.prod.outlook.com>
References: <1447426572-11756-1-git-send-email-holgerschurig@gmail.com>
 <SN1PR02MB13891415516DE9FA4756140783070@SN1PR02MB1389.namprd02.prod.outlook.com>
 <CAOpc7mHbM8EYYNRKR+pKnzc0wf1DR1ojX-iFuDWDYyquC3EVZg@mail.gmail.com>
 <CAPDyKFp2WEVF4yi=Upzx+58SY15u=Fp4=tr3_hh7AS3T2yz4qQ@mail.gmail.com>
 <87r3ierjae.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0065.outbound.protection.outlook.com ([65.55.169.65]:62496
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751288AbbL1PpS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Dec 2015 10:45:18 -0500
In-Reply-To: <87r3ierjae.fsf@gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Holger Schurig <holgerschurig@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Avi Shchislowski <Avi.Shchislowski@sandisk.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Ball <chris@printf.net>, Baolin Wang <baolin.wang@linaro.org>

Hi Ulf,

We succeeded to run FFU via new mmc multi-command ioctl without any code modification, 
but only by using Single Sector commands (CMD24).

>From running the FFU and from code review, we see two minor issues in this way of running FFU:
1. There is no support for Multiple Block write commands (CMD25) in existing IOCTL implementation - 
seems like there is no polling for the card status on data transfer completion.
(The kernel FFU implementation supports FFU using Multiple Block Write commands).
2. As you probably remember, there are two ways to install the new FW in the end of FFU process - 
In case MODE_OPERATION_CODES field is not supported by the device, the host sets to NORMAL state 
and initiates a CMD0/HW_Reset/Power cycle to install the new firmware.
This sequence cannot be done via multi-command ioctl, and requires manual reset of the device/platform.
(The kernel FFU implementation supports both FW install methods).

For running FFU via new mmc multi-command ioctl, we have modified mmc-utils and add new functionality for FFU.
Please let us know if you want us to submit the patch for mmc-utils FFU functionality via multi-command ioctl.

Best regards,
Alex

> -----Original Message-----
> From: Holger Schurig [mailto:holgerschurig@gmail.com]
> Sent: Tuesday, December 22, 2015 10:15 AM
> To: Ulf Hansson
> Cc: Avi Shchislowski; linux-mmc@vger.kernel.org; linux-
> kernel@vger.kernel.org; Alex Lemberg; Chris Ball; Baolin Wang
> Subject: Re: [RFC 0/6] mmc: Field Firmware Update
> 
> 
> > Sorry for the delay.
> 
> No problem, I was busy with many other projects as well.
> 
> > My advise right now is to try this out via the mmc ioctl in userspace,
> > yes. Although, if you encounter any issues with that approach that it
> > might not be reliable, I am open to look into the in-kernel solution
> > again.
> 
> I managed to update my Kingston eMMCs with a slighly modified patch to
> what I submitted. I however didn't bother to submit this, as I saw no chance
> of getting it applied.
> 
> Also I once asked in the mailing list if there is some user-space example of
> how to use the multi-block feature that is supposed to enable this, but I
> haven't gotten an answer.
> 
> > Regarding mmc-utils as where I recommend you to implement this, I have
> > been thinking of moving this tool into the tools directory in the
> > kernel.
> 
> Sounds good to me.
> 
> 
> 
> Remotely related:
> 
> Do you know that some google people made their own version of mmc-utils
> for ChromeOS? And the don't seem to give much effort in unification of
> them?  As if the world wouldn't know how hard it can be to re-unite things
> again, Google should know from their custom kernels they use on Android ...
> Sigh.
> 
> 
> So you can
> 
> * git clone git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc-utils.git
> * git clone
> https://chromium.googlesource.com/chromiumos/third_party/mmc-utils
> 
> currently.
> 

