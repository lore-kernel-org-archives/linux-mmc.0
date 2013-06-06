From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 4/8] mmc: dw_mmc-pltfm: add Rockchip variant
Date: Thu, 6 Jun 2013 23:35:07 +0300
Message-ID: <CAHp75VdTYuXBu0Xu_BKZiBW9afjYprMBtBhSnNYjws-7b6hYmw@mail.gmail.com>
References: <201306062107.58875.heiko@sntech.de>
	<201306062111.06694.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:62858 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754926Ab3FFUfI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Jun 2013 16:35:08 -0400
In-Reply-To: <201306062111.06694.heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Linus Walleij <linus.walleij@linaro.org>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On Thu, Jun 6, 2013 at 10:11 PM, Heiko St=C3=BCbner <heiko@sntech.de> w=
rote:
> Cortex-A9 SoCs from Rockchip use a slightly modified variant of dw_mm=
c
> controllers that seems to require the SDMMC_CMD_USE_HOLD_REG bit to
> always be set.
>
> There also seem to be no other modifications (additional register etc=
)
> present, so to keep the footprint low, add this small variant to the
> pltfm driver.

My comments against v1 of this patch are still valid.

--
With Best Regards,
Andy Shevchenko
