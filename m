From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [patch 2/2] mmc: add support of sdhci-pxa driver
Date: Mon, 27 Sep 2010 09:36:01 +0800
Message-ID: <AANLkTino3YoTfRXii5kGdyX7jtkAtvd1jbsGtWanMn3F@mail.gmail.com>
References: <AANLkTi=XBbW=R4HQYp5fLVE5eUXHNtzGh1Qf+XyBUSCH@mail.gmail.com>
	<AANLkTim4aJok6=HcopkObi3WrUatiZgK-KZTfhoHwgF7@mail.gmail.com>
	<AANLkTimk2_KcmSAV-UZ3JY1JFD657SnfyPFgP_zE5bbP@mail.gmail.com>
	<20100926155905.GB19772@void.printf.net>
	<AANLkTimwsk5SXQRt45vUhzhHabrG4wvw5JcBZAZ1Aq4j@mail.gmail.com>
	<20100926174837.GA21788@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61011 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933Ab0I0BgD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Sep 2010 21:36:03 -0400
Received: by wyb28 with SMTP id 28so3423731wyb.19
        for <linux-mmc@vger.kernel.org>; Sun, 26 Sep 2010 18:36:02 -0700 (PDT)
In-Reply-To: <20100926174837.GA21788@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Eric Miao <eric.y.miao@gmail.com>, zhangfei gao <zhangfei.gao@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>, Saeed Bishara <saeed@marvell.com>

On Mon, Sep 27, 2010 at 1:48 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi Haojian,
>
> On Mon, Sep 27, 2010 at 12:09:17AM +0800, Haojian Zhuang wrote:
>> If the name is sdhci-mmp2, it's a big confusion that people will thi=
nk
>> mmp(ttc/aspen) is using another IP.
>>
>> sdhci-pxa is the best name.
>
> Okay. =A0What should Saeed's driver be called?
>
> Thanks,
>
sdhci-dove / sdhci-mv or any other is acceptable. What's your opinion, =
saeed?

Thanks
Haojian
