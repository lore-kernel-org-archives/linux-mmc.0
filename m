From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [[PATCH 1/4] arm: mach-mmp: Fix Kconfig to allow correct PXA Selections
Date: Mon, 14 Feb 2011 15:03:53 +0100
Message-ID: <201102141503.53189.arnd@arndb.de>
References: <CEFFF7FE-F2F8-47EB-948A-C79301FEB82A@marvell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:59186 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755087Ab1BNOD6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Feb 2011 09:03:58 -0500
In-Reply-To: <CEFFF7FE-F2F8-47EB-948A-C79301FEB82A@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>, Chris Ball <cjb@laptop.org>

On Monday 14 February 2011, Philip Rakity wrote:
> The following items are fixed:
> 
> a) inconsistent behavior when board is selected and if
> menu item is reselected board has disappeard
> 
> b) Ability to select options that will not build
>         MMP2 and say PXA168
> 
> The behavior maps what is done by the mach-omap
> (thanks to Anrd Bergmann for his help and suggestions)
> 
> Mach-MMP is (as now) the sytem type.  Once selected
> the user can then select the SoC on the board and
> only the boards that support that SoC are shown.
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
