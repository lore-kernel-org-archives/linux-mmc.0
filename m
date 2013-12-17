From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCHv6 2/5] clk: socfpga: Add a clock type for the SD/MMC driver
Date: Tue, 17 Dec 2013 10:17:26 +0800
Message-ID: <CAGb2v67dud7XQSOy4eABX3SZX9pRkm366dodke5-AzdcGuje5A@mail.gmail.com>
References: <1386880245-10192-1-git-send-email-dinguyen@altera.com>
 <1386880245-10192-3-git-send-email-dinguyen@altera.com> <201312142233.27143.arnd@arndb.de>
 <52AD1185.6090501@linaro.org> <20131215045116.23538.4@quantum> <52AF68DB.7090105@elopez.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:45566 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190Ab3LQCRr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2013 21:17:47 -0500
In-Reply-To: <52AF68DB.7090105@elopez.com.ar>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Emilio_L=F3pez?= <emilio@elopez.com.ar>
Cc: Mike Turquette <mturquette@linaro.org>, zhangfei <zhangfei.gao@linaro.org>, Arnd Bergmann <arnd@arndb.de>, dinguyen@altera.com, mark.rutland@arm.com, devicetree <devicetree@vger.kernel.org>, dinh.linux@gmail.com, heiko@sntech.de, pawel.moll@arm.com, bzhao@marvell.com, tgih.jun@samsung.com, Peter De Schrijver <pdeschrijver@nvidia.com>, linux-mmc@vger.kernel.org, dianders@chromium.org, Rob Herring <rob.herring@calxeda.com>, jh80.chung@samsung.com, alim.akhtar@samsung.com, cjb@laptop.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, ian.campbell@citrix.com, Hans de Goede <hdegoede@redhat.com>, =?ISO-8859-1?Q?David_Lanzend=F6rfer?= <david.lanzendoerfer@o2s.ch>

Hi,

On Tue, Dec 17, 2013 at 4:55 AM, Emilio L=F3pez <emilio@elopez.com.ar> =
wrote:
> I also saw a similar requirement from the gmac people (on cc too), wh=
o
> needed to set the phy type (or something like that) on one of the clo=
ck

The GMAC clock register controls the tx clock source (a mux) and the
interface type, which is most likely a gate to control the direction
of the tx clock.

So I modeled it as a composite clock source for now.
I'm open to other options.

> registers; so I'm thinking maybe a generic "tune something" approach =
that
> lets users configure some clock-dependent, arbitrary aspect of the cl=
ock is
> the way forward. Otherwise, we're going to end up bloating the clock
> framework with a lot of callback pointers that are going to be used i=
n one
> or two clocks out of potentially hundreds on the whole system.

ChenYu
