From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH 15/23]  Alternative mmc structure to support pxa168,
 pxa910, mmp2 family SD
Date: Wed, 22 Dec 2010 14:58:14 -0800
Message-ID: <037EAE31-B07C-4134-B810-A5A1E83517B8@marvell.com>
References: <22DA8CC3-8CB2-4EEE-AAD8-8599BD589CCE@marvell.com>
 <201012221510.36878.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:54752 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751689Ab0LVXAu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Dec 2010 18:00:50 -0500
In-Reply-To: <201012221510.36878.arnd@arndb.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>


On Dec 22, 2010, at 6:10 AM, Arnd Bergmann wrote:

> On Wednesday 22 December 2010 08:09:58 Philip Rakity wrote:
>> The PXA168, PXA910, and MMP2 are not the same SOC.  The family
>> of embedded processors have slightly different internal blocks
>> for SD, I2C, etc.  Sometimes it is important to know which SOC
>> is being used due to differences in the silicon.  Sometimes it
>> is important to know evaluation boards should be selected based
>> on the SOC on the board.
> 
> This looks like you're moving in the wrong direction.
> 
> If the chips are just slightly different, you'd certainly
> want to make sure that you can detect the difference at runtime,
> and be able to use the same kernel on all of the variants.

MMP2 used PJ4 core --- PXA168/PXA910 use PJ1 so rather different architecture.

PXA168/PXA910 have slightly different internal peripherals with different quirks.
Certainly possible to tell this apart at runtime but not all peripherals are the same
and startup files ARE different.


> 
> Instead, you promote each of the SOCs to a top-level family
> in this patch, which makes it impossible to build a kernel
> for more than one of them at a time.

That was the intent to handle the case of development board selection.
it is meaningless to select MMP2 development board with say PXA168 SoC.

Open to other way to handle this problem.  Suggestions welcome.

> 
> 	Arnd

