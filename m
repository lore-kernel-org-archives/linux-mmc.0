From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 5/7] clk: add basic Rockchip rk3066a clock support
Date: Wed, 12 Jun 2013 16:02:34 -0700
Message-ID: <20130612230234.GB9016@quad.lixom.net>
References: <201306111328.52679.heiko@sntech.de>
 <201306111331.31517.heiko@sntech.de>
 <20130611200610.8816.68285@quantum>
 <201306130045.41723.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33902 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756919Ab3FLXCb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jun 2013 19:02:31 -0400
Received: by mail-pd0-f171.google.com with SMTP id y14so7772853pdi.16
        for <linux-mmc@vger.kernel.org>; Wed, 12 Jun 2013 16:02:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201306130045.41723.heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Mike Turquette <mturquette@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Linus Walleij <linus.walleij@linaro.org>, devicetree-discuss@lists.ozlabs.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andy Shevchenko <andy.shevchenko@gmail.com>

On Thu, Jun 13, 2013 at 12:45:41AM +0200, Heiko St=FCbner wrote:
> Part of me simply wants to wait for this - but rockchip stuff might b=
e to late=20
> for 3.11 anyway, as we're near rc6.

=46or a new platform like this, it's useful to get some of the drivers =
to land
even if the main platform code isn't. Where things tend to get messy is=
 when we
have to add a lot of code late in the cycle that has a lot of external
dependencies, since everybody then has to scramble about getting things=
 sorted
out.

It's not too late for 3.11 yet, and in particular it'd be nice to see t=
hings
like clock and pinctrl stuff go in even if some other stuff misses the =
train.


-Olof
