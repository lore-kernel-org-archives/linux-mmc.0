From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: Problem when using SDIO interrupts on Nexus One
Date: Wed, 13 Apr 2011 15:37:40 +0530
Message-ID: <000001cbf9c2$a134e100$e39ea300$@org>
References: <BANLkTin2cVt7236-Ds+3Wg0SsCuSSSZGsg@mail.gmail.com> <001b01cbf841$1f354aa0$5d9fdfe0$@org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:9418 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757164Ab1DMKHo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2011 06:07:44 -0400
In-Reply-To: <001b01cbf841$1f354aa0$5d9fdfe0$@org>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Johan' <kungjohan@gmail.com>, linux-mmc@vger.kernel.org
Cc: bryanh@codeaurora.org

Hi Johan,

Did you get a chance to test my patch?

Regards,
Subhash

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Subhash Jadavani
> Sent: Monday, April 11, 2011 5:38 PM
> To: 'Johan'; linux-mmc@vger.kernel.org
> Cc: bryanh@codeaurora.org
> Subject: RE: Problem when using SDIO interrupts on Nexus One
> 
> Hi Johan,
> 
> > -----Original Message-----
> > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > owner@vger.kernel.org] On Behalf Of Johan
> > Sent: Friday, April 08, 2011 12:53 AM
> > To: linux-mmc@vger.kernel.org
> > Subject: Problem when using SDIO interrupts on Nexus One
> >
> > I have a Nexus One Android phone and I am trying to use a SDIO device
> > connected to the memory slot available on the phone. This device uses
> > SDIO interrupts on SD_D1 to signal interrupts to the host.
> >
> > I am using a 2.6-32 kernel from the android-msm-2.6.32 branch
> > available from git://android.git.kernel.org/kernel/msm.git and has
> > built the kernel with the mahimahi_defconfig.
> >
> > I have modified drivers/mmc/host/msm_sdcc.c so that SDIO interrupts
> is
> > used -> msmsdcc_sdioirq = 1;
> >
> > My device is working quite well with SDIO interrupts but sometime I
> > can miss a interrupt and will get this interrupt when I try to send a
> > command to my device. I can see this behaviour if my device tries to
> > signal a interrupt 1 second of the last command sent to the device.
> > The SDIO interrupt line goes low and the host does not signal the
> > interrupt at once. My assumption is that this is due to some kind of
> > power management of the SDIO controller. I will get this interrupt
> > when I activate the SDIO controller by sending a command to my
> device.
> >  I have verified this with a logic analyzer attached to the bus and
> > can attach a screen shot if anyone wants to see this.
> >
> > So my question is if anyone know how to get reliable SDIO interrupts
> > on this host, Qualcomm MSM? It seems like Qualcomm does not provide
> > documentation for this host.
> 
> I had a look at the msm_sdcc.c and it looks like all the SDCC
> interrupts are masked when driver goes into Suspend. So when you say
> interrupts are getting missed it might be the case that system is in
> suspend state.
> 
> To fix this, you can keep the SDIO interrupts enabled while going into
> suspend. I have made a patch (attached with this mail) with this
> change.
> Please give a try and let me know if it works for you or not.
> 
> Regards,
> Subhash
> 
> >
> > Best Regards
> > Johan
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html

