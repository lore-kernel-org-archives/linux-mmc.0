From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] mmc: sdio add regulator vsdio
Date: Fri, 22 Jul 2011 07:50:14 +0100
Message-ID: <CAGq3pz6-MQPpsyEWbDQBnnW4q2rXSKFF9qzRvTLtwmzvG+xJKw@mail.gmail.com>
References: <1311215673-2489-1-git-send-email-zhangfei.gao@marvell.com>
	<1311215673-2489-2-git-send-email-zhangfei.gao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:44050 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288Ab1GVGuP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jul 2011 02:50:15 -0400
Received: by fxd18 with SMTP id 18so4769549fxd.11
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jul 2011 23:50:14 -0700 (PDT)
In-Reply-To: <1311215673-2489-2-git-send-email-zhangfei.gao@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@marvell.com>
Cc: Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Bing Zhao <bzhao@marvell.com>, Frank@marvell.com, Huang@marvell.com, frankh@marvell.com

On 21 July 2011 03:34, Zhangfei Gao <zhangfei.gao@marvell.com> wrote:
> sdio client may be required power on/off dynamically.
> With regulator vsdio, sdio client power on/off could be executed by mmc_power_up/down

I think you can/should do this with vmmc. When the device gets powered
down (e.g. in runtime suspend), the voltage should be cut, so it
should be possible to use the existing regulator.

I also looked at doing this before, when it looked like we would have
to manipulate a GPIO reset line for SD8686. I decided that the current
vmmc implementation in sdhci wasn't quite complete enough, but it
wouldn't be much effort to correct this.

Daniel
