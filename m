From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V2 2/2] sdhci: Support for SD/MMC Dual Data Rate
Date: Sun, 9 Jan 2011 23:28:12 +0000
Message-ID: <20110109232812.GA26728@void.printf.net>
References: <35CD48DB-A420-4319-968D-400D45EE9C0D@marvell.com> <AANLkTi=ERwn3W8tvt3NNS3Xiq93mhy7TV7vAT9dwjvaq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48280 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934Ab1AIX2O (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 9 Jan 2011 18:28:14 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=ERwn3W8tvt3NNS3Xiq93mhy7TV7vAT9dwjvaq@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>

Hi Philip, Zhangfei,

We've got two patches from Marvell for SD/DDR now.  Any agreement on
which of them to merge?

On Mon, Jan 03, 2011 at 10:39:46PM -0500, zhangfei gao wrote:
> > + =A0 =A0 =A0 /* Change sigalling voltage and wait for it to be sta=
ble */
> > + =A0 =A0 =A0 if (host->ops->set_signaling_voltage)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->set_signaling_voltage(host=
, 18);
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(5);
>=20
> In fact, have considered this method before, mdelay(5) in
> spin_lock_irqsave is terrible, since timer can not update system time=
,
> and android must die.

Philip, is there a reason not to use msleep() here instead?

Thanks,

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
