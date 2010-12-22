From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 15/23]  Alternative mmc structure to support pxa168, pxa910, mmp2 family SD
Date: Wed, 22 Dec 2010 15:10:36 +0100
Message-ID: <201012221510.36878.arnd@arndb.de>
References: <22DA8CC3-8CB2-4EEE-AAD8-8599BD589CCE@marvell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:58432 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513Ab0LVOKv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 09:10:51 -0500
In-Reply-To: <22DA8CC3-8CB2-4EEE-AAD8-8599BD589CCE@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>

On Wednesday 22 December 2010 08:09:58 Philip Rakity wrote:
> The PXA168, PXA910, and MMP2 are not the same SOC.  The family
> of embedded processors have slightly different internal blocks
> for SD, I2C, etc.  Sometimes it is important to know which SOC
> is being used due to differences in the silicon.  Sometimes it
> is important to know evaluation boards should be selected based
> on the SOC on the board.

This looks like you're moving in the wrong direction.

If the chips are just slightly different, you'd certainly
want to make sure that you can detect the difference at runtime,
and be able to use the same kernel on all of the variants.

Instead, you promote each of the SOCs to a top-level family
in this patch, which makes it impossible to build a kernel
for more than one of them at a time.

	Arnd
