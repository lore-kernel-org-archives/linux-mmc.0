From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v3 3/7] mmc: dw_mmc-pltfm: move probe and remove below dt
 match table
Date: Wed, 12 Jun 2013 10:16:15 +0900
Message-ID: <000901ce670a$6f96a2c0$4ec3e840$%jun@samsung.com>
References: <201306111328.52679.heiko@sntech.de>
 <201306111330.28759.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:52815 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235Ab3FLBQS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jun 2013 21:16:18 -0400
In-reply-to: <201306111330.28759.heiko@sntech.de>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?'Heiko_St=C3=BCbner'?= <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, 'Mike Turquette' <mturquette@linaro.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org, 'Grant Likely' <grant.likely@linaro.org>, 'Rob Herring' <rob.herring@calxeda.com>, 'Linus Walleij' <linus.walleij@linaro.org>, devicetree-discuss@lists.ozlabs.org, 'Russell King' <linux@arm.linux.org.uk>, 'Arnd Bergmann' <arnd@arndb.de>, 'Olof Johansson' <olof@lixom.net>, 'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>, 'Andy Shevchenko' <andy.shevchenko@gmail.com>

On 06/11/13 2013 8:30 PM Heiko St=C3=BCbner wrote:
> In a subsquent patch probe will need to do some handling of data from
> the dt match table. So to prevent the need for forward declarations,
> move probe and remove below the match table.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>


