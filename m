From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH v3 1/2] mmc: sdio add regulator vsdio
Date: Fri, 16 Sep 2011 16:38:21 +0100
Message-ID: <CAMLZHHTpU94xmddhu4JuCoO9NBUKr3ByeWxFBdpQKRUPvXa+uQ@mail.gmail.com>
References: <1314253575-2602-1-git-send-email-zhangfei.gao@marvell.com>
	<1314253575-2602-2-git-send-email-zhangfei.gao@marvell.com>
	<CAMPhdO9r8wyyU9uW7NTyOR2e2kOJG0rqgUow3krg9GpiZmab_g@mail.gmail.com>
	<CAMj5Bkh99bkQPX01h_WLnyOP_whdZx=WS-wfG1DB2b32STcTeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61356 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811Ab1IPPiV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Sep 2011 11:38:21 -0400
Received: by yxm8 with SMTP id 8so2990573yxm.19
        for <linux-mmc@vger.kernel.org>; Fri, 16 Sep 2011 08:38:21 -0700 (PDT)
In-Reply-To: <CAMj5Bkh99bkQPX01h_WLnyOP_whdZx=WS-wfG1DB2b32STcTeA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Bing Zhao <bzhao@marvell.com>

On Thu, Sep 1, 2011 at 2:37 AM, zhangfei gao <zhangfei.gao@gmail.com> wrote:
> Daniel once suggested reusing vmmc, however we found CD pin requires
> vmmc to be alwayes on.
> If vmmc is dynamically power off, CD pin will be low, which indicating
> card is inserted by mistake.
> For example when no card inserted, CD pin will high -> host fail to
> detect sd card -> vmmc disabled in set_ios -> host thought card
> inserted -> irq happen -> host redetect card ->

Sorry that I haven't been able to follow up on why that doesn't work,
and what the real fix would be (if it's not this one). Every time I
see people discussing terms like CD, RESETn and PDn, I simply get lost
(and such discussion seems to originate only from Marvell).

Are these generic SD/MMC terms that I simply don't understand, or are
we talking Marvell specific terminology that I'm not alone in lacking
understanding of?

Thanks,
Daniel
