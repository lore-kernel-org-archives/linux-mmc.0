From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH] s3cmci: port DMA code to dmaengine API
Date: Tue, 20 May 2014 13:22:35 +0300
Message-ID: <CA+E=qVch0K+raN4dkPK6XzXqOQc4t433UyCJ2Qnc2uymgTq7cA@mail.gmail.com>
References: <1400522593-6366-1-git-send-email-anarsoul@gmail.com>
 <7633675.1cAc12AFAY@wuerfel> <CA+E=qVeG8bXowBvdhKpVSYSL08n6ZUVG2LkjhPwjBnbv+egNLw@mail.gmail.com>
 <4667090.Oyf6jd3Lyk@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:49332 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbaETKWz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 May 2014 06:22:55 -0400
Received: by mail-ob0-f176.google.com with SMTP id wo20so249053obc.21
        for <linux-mmc@vger.kernel.org>; Tue, 20 May 2014 03:22:55 -0700 (PDT)
In-Reply-To: <4667090.Oyf6jd3Lyk@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <chris@printf.net>, Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, arm-linux <linux-arm-kernel@lists.infradead.org>

Hi Arnd,

On Mon, May 19, 2014 at 10:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> For this driver, you don't have to go that far, as long as it's
> ensure that the pointer to the filter function is available to
> the driver, i.e. you can't have a built-in s3mci driver when the
> dmaengine driver is a loadable module.

OK, so I guess I need to add explicit dependency on
CONFIG_S3C24XX_DMAC for s3cmci driver.

Btw, I didn't understand if it's acceptable to pass DMA channel number
through DMA resource for non-DT case or not?

Regards
Vasily
