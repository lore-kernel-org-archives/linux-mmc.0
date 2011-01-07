From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 15/23] Alternative mmc structure to support pxa168, pxa910, mmp2 family SD
Date: Fri, 7 Jan 2011 18:51:54 +0100
Message-ID: <201101071851.54872.arnd@arndb.de>
References: <22DA8CC3-8CB2-4EEE-AAD8-8599BD589CCE@marvell.com> <201101062029.45604.arnd@arndb.de> <ABCC071A-5598-48AA-9545-2712FA0BB624@marvell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:64896 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755069Ab1AGRvq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Jan 2011 12:51:46 -0500
In-Reply-To: <ABCC071A-5598-48AA-9545-2712FA0BB624@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <markb@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Friday 07 January 2011, Philip Rakity wrote:
> Thanks for the suggestion.  Let me see if I can implement this.  
> 
> A couple of points first
> 
> a) current implementation once PXA168/910 is selected will no longer show MMP2 boards so it is also broken.  Play around and you will see the issues

I didn't see it on the version I'm looking at now, but if it's inconsistent or
allows you to select combinationst that cannot be built, then it should be fixed.

> My proposed patch did the following
> a) ARCH_MMP is set when PXA168, PXA910 or MMP2 are selected (from arch/arm)
> b) Board selection uses the PXA168/PXA910/MMP2 to show correct board.

Yes, that is what I thought, but it is inconsistent with how other platforms do this.
Usually, the top-level selection chooses one source directory, and anything specific
to that platform is handled by that Kconfig.

> If I understand what you are suggesting is the following
> a) leave ARCH_MMP is system selection alone -- 
> b) move speciific CPU selection to where board selection is now (cpu/arch/mach-mmp)

Right.

> c) what do with development boards ?  select all of them for the CPU Type ?  
>
> Point me to a Kconfig that does what you are suggesting as an example and I can try out the suggestion.

Just put it below the CPU selection.

OMAP does something like this -- you first select either OMAP1 or OMAP2/3/4, then
the families in the latter case, and finally the boards.

You can do the same by first giving the choice between ARMv6 and PXA168/910, and
then showing the boards below the CPU. There are multiple ways of doing this
that lead to the same result.

	Arnd
