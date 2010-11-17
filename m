From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Wed, 17 Nov 2010 09:29:16 +0200
Message-ID: <AANLkTi=RGBp57wQT-gb0B2oSRnvxMhb92ZL-TAc6WAqB@mail.gmail.com>
References: <AANLkTim+Ez8FonyZDu42u4NX-KKV0YS_J-Ya-zT-Gf9q@mail.gmail.com>
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
 <AANLkTi=EaZbdnJzJWGH2fUadvNkUhdQgTU1rAoS5wMAs@mail.gmail.com>
 <AANLkTinzvte389GNHtD2N0wO9mYsysCG9+Z1AFVZRn0E@mail.gmail.com>
 <AANLkTimRFC81ZiLuiUmhvXOpUddBjhVBezJEB8_BDyuu@mail.gmail.com>
 <AANLkTinAP0J3RncxJZciKVD9TKdfZLLvDsGn3NpnF0Dz@mail.gmail.com> <4CE37A54.20509@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64558 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933423Ab0KQH3o (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Nov 2010 02:29:44 -0500
Received: by iwn35 with SMTP id 35so1790868iwn.19
        for <linux-mmc@vger.kernel.org>; Tue, 16 Nov 2010 23:29:44 -0800 (PST)
In-Reply-To: <4CE37A54.20509@compulab.co.il>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Daniel Drake <dsd@laptop.org>, Arnd Hannemann <arnd@arndnet.de>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, libertas-dev@lists.infradead.org

On Wed, Nov 17, 2010 at 8:46 AM, Mike Rapoport <mike@compulab.co.il> wrote:
> On our platforms we just keep it powered on after boot with the reset line held
> high. (e.g. arch/arm/mach-pxa/cm-x300.c, arch/arm/mach-omap/board-cm-t35.c).
> We don't bother much for power savings, though.

Thanks, Mike !

This paves the road for MMC_CAP_POWER_OFF_CARD.

SDIO core will enable runtime PM for the card only if that cap is set.
As a result, the card will be powered down after boot, and will only
be powered up again when a driver is loaded (and then it's up to the
driver whether power will be kept or not).
