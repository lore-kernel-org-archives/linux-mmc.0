From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH 1/2] MMC Agressive clocking framework v7
Date: Wed, 3 Nov 2010 15:30:16 +0100
Message-ID: <AANLkTikoyqd0JEJYTpKNs+UGmu4t4L7n-9s4QRk7pFbu@mail.gmail.com>
References: <1288541169-16054-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTims3RhKmPxxxL_T32DN96kSrEE415FE1320fbNO@mail.gmail.com>
	<4CD1612F.10507@stericsson.com>
	<20101103134450.0c88e4ed@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40272 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121Ab0KCOaR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Nov 2010 10:30:17 -0400
Received: by gxk23 with SMTP id 23so509946gxk.19
        for <linux-mmc@vger.kernel.org>; Wed, 03 Nov 2010 07:30:16 -0700 (PDT)
In-Reply-To: <20101103134450.0c88e4ed@lxorguk.ukuu.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ghorai Sukumar <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>, Kyungmin Park <kmpark@infradead.org>, "arm-kernel@lists.infradead.org" <arm-kernel@lists.infradead.org>

2010/11/3 Alan Cox <alan@lxorguk.ukuu.org.uk>:

>> Doesn't it require a struct device* to be used?
>
> Yes but the sdhci port can be a device even if its wired via a controller
> which is its parent. The device layer is designed that way

Yeah wait I got it all backwards, of course I should be able to hook
some dev_pm_ops to the struct device * in MMC's host->class_dev
that mmc_add_host() creates, can't be too hard.

I'll give it a spin, this will probably hook nicely into runtime PM.

Yours,
Linus Walleij
