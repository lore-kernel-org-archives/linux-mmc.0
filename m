From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V3 1/1]MMC: add support of sdhci-pxa driver
Date: Fri, 22 Oct 2010 12:04:57 +0100
Message-ID: <20101022110457.GA14136@void.printf.net>
References: <AANLkTikivxhU6Lzxe0Xn9r9hOSPLwuySRkTdGif4F_xo@mail.gmail.com> <20101021141302.GA11912@void.printf.net> <20101021145249.GA13095@void.printf.net> <AANLkTik8=HXEG4h2toVf7ut8TGk04HMv1DR_BxoevOC0@mail.gmail.com> <20101022095814.GA13073@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49667 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179Ab0JVLE7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Oct 2010 07:04:59 -0400
Content-Disposition: inline
In-Reply-To: <20101022095814.GA13073@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Wolfram Sang <w.sang@pengutronix.de>, "eric.y.miao" <eric.y.miao@gmail.com>, Matt Fleming <matt@console-pimps.org>

Hi,

On Fri, Oct 22, 2010 at 10:58:14AM +0100, Chris Ball wrote:
[...]
> +#ifdef CONFIG_PM
> +static int sdhci_pxa_suspend(struct platform_device *dev)
> +{
> +	struct sdhci_host *host =3D platform_get_drvdata(to_platform_device=
(dev));
> +
> +	return sdhci_suspend_host(host, state);
> +}
> +
> +static int sdhci_pxa_resume(struct platform_device *dev)
> +{

These prototypes are not correct, leading to:

  CC [M]  drivers/mmc/host/sdhci-pxa.o
drivers/mmc/host/sdhci-pxa.c: In function =E2=80=98sdhci_pxa_suspend=E2=
=80=99:
drivers/mmc/host/sdhci-pxa.c:205: warning: initialization from incompat=
ible pointer type
drivers/mmc/host/sdhci-pxa.c:207: error: =E2=80=98state=E2=80=99 undecl=
ared (first use in this function)
drivers/mmc/host/sdhci-pxa.c:207: error: (Each undeclared identifier is=
 reported only once
drivers/mmc/host/sdhci-pxa.c:207: error: for each function it appears i=
n.)
drivers/mmc/host/sdhci-pxa.c: In function =E2=80=98sdhci_pxa_resume=E2=80=
=99:
drivers/mmc/host/sdhci-pxa.c:212: warning: initialization from incompat=
ible pointer type
drivers/mmc/host/sdhci-pxa.c: At top level:
drivers/mmc/host/sdhci-pxa.c:222: warning: initialization from incompat=
ible pointer type
drivers/mmc/host/sdhci-pxa.c:223: warning: initialization from incompat=
ible pointer type

when compiled with CONFIG_PM=3Dy.

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
