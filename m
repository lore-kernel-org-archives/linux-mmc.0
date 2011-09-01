From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v3 1/2] mmc: sdio add regulator vsdio
Date: Thu, 1 Sep 2011 09:37:53 +0800
Message-ID: <CAMj5Bkh99bkQPX01h_WLnyOP_whdZx=WS-wfG1DB2b32STcTeA@mail.gmail.com>
References: <1314253575-2602-1-git-send-email-zhangfei.gao@marvell.com>
	<1314253575-2602-2-git-send-email-zhangfei.gao@marvell.com>
	<CAMPhdO9r8wyyU9uW7NTyOR2e2kOJG0rqgUow3krg9GpiZmab_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60316 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756900Ab1IABhz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Aug 2011 21:37:55 -0400
Received: by eyx24 with SMTP id 24so1325447eyx.19
        for <linux-mmc@vger.kernel.org>; Wed, 31 Aug 2011 18:37:54 -0700 (PDT)
In-Reply-To: <CAMPhdO9r8wyyU9uW7NTyOR2e2kOJG0rqgUow3krg9GpiZmab_g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>, Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>, Daniel Drake <dsd@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Bing Zhao <bzhao@marvell.com>

On Wed, Aug 31, 2011 at 10:06 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> Zhangfei,
>
> My understanding is that the card in the slot would be either MMC _or_
> SDIO and why do we need another regulator for the power on/off?
>
Hi, Eric

vsdio is used for dynamically power control to sdio, for example
application dynamically disable/enable wifi.
Then mmc_start/stop_host and mmc_power_up/down could directly power
on/off sdio via mmc_set_ios.
This also workable with runtime PM, which already introduced into mmc by Ohad.

vmmc is used to statically provided power to sd or vmmc.

Daniel once suggested reusing vmmc, however we found CD pin requires
vmmc to be alwayes on.
If vmmc is dynamically power off, CD pin will be low, which indicating
card is inserted by mistake.
For example when no card inserted, CD pin will high -> host fail to
detect sd card -> vmmc disabled in set_ios -> host thought card
inserted -> irq happen -> host redetect card ->

If there is concern of vsdio in sdhci.c, how about moving vsdio to
specific driver via call back.

Thanks
