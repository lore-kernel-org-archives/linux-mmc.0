From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [EXT] Re: [PATCH] mmc: sdhci-xenon: add gpio hard reset support
Date: Wed, 16 Aug 2017 10:44:29 +0800
Message-ID: <20170816104429.00c35ca9@xhacker>
References: <1502749156-22798-1-git-send-email-zjwu@marvell.com>
        <3696b751-68cc-6c11-bb7d-af7d6e6a5681@rock-chips.com>
        <59937848.2040901@marvell.com>
        <b56fc3b4-4fff-0881-2233-8f26a6c8407a@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:55410 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752956AbdHPCtc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Aug 2017 22:49:32 -0400
In-Reply-To: <b56fc3b4-4fff-0881-2233-8f26a6c8407a@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Zhoujie Wu <zjwu@marvell.com>, hannah@marvell.com
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, adrian.hunter@intel.com, zmxu@marvell.com, nadavh@marvell.com, xigu@marvell.com, dingwei@marvell.com, kostap@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, gregory.clement@free-electrons.com, thomas.petazzoni@free-electrons.com

On Wed, 16 Aug 2017 08:32:09 +0800 Shawn Lin wrote:

> Hi
> 
> On 2017/8/16 6:40, Zhoujie Wu wrote:
> > Hi Shawn,  
> 
> >> ----------------------------------------------------------------------
> >> Hi
> >>
> >> On 2017/8/15 6:19, Zhoujie Wu wrote:  
> >>> On some platforms, like armada3700,  SD card need to
> >>> do hard reset by gpio toggling to make it work properly
> >>> after warm reset the board.  
> >>
> >> I don't get this that SD card need to do hard reset...
> >>
> >> I assume what you talk about is either for eMMC or a power-cycle
> >> for SD card.  
> > 
> > The subject of the patch confused you. What I want is a power-cycle for 
> > the SD card. The gpio is  used to enable/disable the vdd power supply 
> > for sd card.
> > Actually on a3700, when warm reset the board, their is no power-cycle 
> > for SD card, which will lead sd card can't response correct ocr and 
> > never set S18A unless a power-cycle.
> > This is the purpose I submit this patch.
> >   
> 
> Well, if that is the case, I suggest you to use regulator-gpio.

Oh yes! If the gpio is for power, why not make use of regulator? then
except the dts, we don't need do anything.
