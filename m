From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v4 0/3] mmc: dw_mmc: Add support for Rockchip variant
Date: Thu, 27 Jun 2013 11:56:06 -0400
Message-ID: <87ppv7mtt5.fsf@octavius.laptop.org>
References: <201306131055.49595.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52942 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753982Ab3F0P4R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Jun 2013 11:56:17 -0400
In-Reply-To: <201306131055.49595.heiko@sntech.de> ("Heiko \=\?utf-8\?Q\?St\?\=
 \=\?utf-8\?Q\?\=C3\=BCbner\=22's\?\= message
	of "Thu, 13 Jun 2013 10:55:48 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-mmc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Shevchenko <andy.shevchenko@gmail.com>

Hi Heiko,

On Thu, Jun 13 2013, Heiko St=C3=BCbner wrote:
> The driver support for the mmc host is not needed for the core SoC su=
pport
> and in the same way the mmc support does not need the SoC code to fun=
ction.
> Therefore it can be submitted (and hopefully merged) on its own.
>
>
> Changes since v3:
> - submit mmc driver standalone
> - add dt binding documentation

Thanks, all three patches pushed to mmc-next for 3.11.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
