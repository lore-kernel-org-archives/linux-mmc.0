From: Chris Ball <cjb@laptop.org>
Subject: Re: [patch 2/2] mmc: add support of sdhci-pxa driver
Date: Wed, 29 Sep 2010 00:36:30 +0100
Message-ID: <20100928233630.GA31525@void.printf.net>
References: <AANLkTi=XBbW=R4HQYp5fLVE5eUXHNtzGh1Qf+XyBUSCH@mail.gmail.com> <AANLkTim4aJok6=HcopkObi3WrUatiZgK-KZTfhoHwgF7@mail.gmail.com> <AANLkTimk2_KcmSAV-UZ3JY1JFD657SnfyPFgP_zE5bbP@mail.gmail.com> <20100926155905.GB19772@void.printf.net> <AANLkTimwsk5SXQRt45vUhzhHabrG4wvw5JcBZAZ1Aq4j@mail.gmail.com> <20100926174837.GA21788@void.printf.net> <AANLkTino3YoTfRXii5kGdyX7jtkAtvd1jbsGtWanMn3F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36021 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890Ab0I1Xgc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Sep 2010 19:36:32 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTino3YoTfRXii5kGdyX7jtkAtvd1jbsGtWanMn3F@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saeed Bishara <saeed@marvell.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, zhangfei gao <zhangfei.gao@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>

On Mon, Sep 27, 2010 at 09:36:01AM +0800, Haojian Zhuang wrote:
> > Okay. =A0What should Saeed's driver be called?
>
> sdhci-dove / sdhci-mv or any other is acceptable. What's your opinion=
, saeed?

sdhci-dove sounds good to me.  Saeed, if you agree, please could you
resend the patch?  (With an "ARCH_DOVE || ARCH_MMP" dependency and a
list of supported SoCs in the Kconfig help text.)

Thanks,

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
