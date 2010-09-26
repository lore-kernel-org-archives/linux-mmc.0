From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [patch 2/2] mmc: add support of sdhci-pxa driver
Date: Mon, 27 Sep 2010 00:09:17 +0800
Message-ID: <AANLkTimwsk5SXQRt45vUhzhHabrG4wvw5JcBZAZ1Aq4j@mail.gmail.com>
References: <AANLkTi=XBbW=R4HQYp5fLVE5eUXHNtzGh1Qf+XyBUSCH@mail.gmail.com>
	<AANLkTim4aJok6=HcopkObi3WrUatiZgK-KZTfhoHwgF7@mail.gmail.com>
	<AANLkTimk2_KcmSAV-UZ3JY1JFD657SnfyPFgP_zE5bbP@mail.gmail.com>
	<20100926155905.GB19772@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56298 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab0IZQJT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Sep 2010 12:09:19 -0400
Received: by wyb28 with SMTP id 28so3199326wyb.19
        for <linux-mmc@vger.kernel.org>; Sun, 26 Sep 2010 09:09:17 -0700 (PDT)
In-Reply-To: <20100926155905.GB19772@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Eric Miao <eric.y.miao@gmail.com>, zhangfei gao <zhangfei.gao@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>, Saeed Bishara <saeed@marvell.com>

On Sun, Sep 26, 2010 at 11:59 PM, Chris Ball <cjb@laptop.org> wrote:
> On Sun, Sep 26, 2010 at 10:45:02PM +0800, Haojian Zhuang wrote:
>> > I prefer we rename it to something like sdhci-mmp.c and the 'pxa' =
in the
>> > source code to 'mmp' to cause less confusion with pxamci.c?
>>
>> Maybe sdhci-pxa.c is better. pxamci.c isn't compatible with sdhci, s=
o
>> it won't make people confusion.
>
> The confusion can still happen when people are wondering which driver=
 to
> build for their SoC.
>
> It seems that both names are confusing -- sdhci-mmp would confuse thi=
s
> driver with the one submitted by Saeed Bishara for Dove/MMP, and
> sdhci-pxa confuses it with pxamci.c.
>
> Have you considered sdhci-mmp for Saeed's driver, and sdhci-mmp2 for
> this driver? =A0Or, sdhci-dove and sdhci-mmp2? =A0Perhaps a non-exhau=
stive
> distinction is better than an incorrectly generalized one.
>
If the name is sdhci-mmp2, it's a big confusion that people will think
mmp(ttc/aspen) is using another IP.

sdhci-pxa is the best name.

Thanks
Haojian
