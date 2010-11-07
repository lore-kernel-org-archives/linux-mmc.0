From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Sun, 7 Nov 2010 15:17:55 +0200
Message-ID: <AANLkTim=qK+b51nOaFs3kWYCAwGiZ9XAVx6Z-aAebu2V@mail.gmail.com>
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
 <AANLkTi=EaZbdnJzJWGH2fUadvNkUhdQgTU1rAoS5wMAs@mail.gmail.com>
 <AANLkTi=GjQUOBBWe96ubtxN+ndQLcOFjebrDkM_1hSSb@mail.gmail.com>
 <AANLkTinXyW-iymJUeXGODLLBOevTwyUOcROg-B1wwJcA@mail.gmail.com> <AANLkTimcoDvfVLxF6c3c78yeBOoNGsuTm1ZaSujM0A4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46212 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471Ab0KGNSQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Nov 2010 08:18:16 -0500
Received: by iwn41 with SMTP id 41so2867192iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 07 Nov 2010 05:18:16 -0800 (PST)
In-Reply-To: <AANLkTimcoDvfVLxF6c3c78yeBOoNGsuTm1ZaSujM0A4b@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Sun, Nov 7, 2010 at 12:51 PM, Daniel Drake <dsd@laptop.org> wrote:
> If you take the interface down, the card is still powered up in some
> way.

With SDIO runtime pm support, it shouldn't be.

> When I asked the hardware guy he said it was entirely controlled by
> the normal SD power pin, but a full card reset will be needed after
> cycling the power.

We need to understand why the wlan card on the XO-1.5 does not go
through full power off/on cycle, despite software calling
mmc_power_off/on.

If this is solved, I don't think you will still need that rfkill driver.
