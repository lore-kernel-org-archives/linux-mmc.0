From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: n900: Mark eMMC slot with no-sdio and no-sd
 flags
Date: Tue, 27 Dec 2016 09:57:47 -0800
Message-ID: <20161227175747.GX4920@atomide.com>
References: <1481750984-11239-1-git-send-email-pali.rohar@gmail.com>
 <20161214213445.GD28424@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:53720 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932642AbcL0R5w (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 27 Dec 2016 12:57:52 -0500
Content-Disposition: inline
In-Reply-To: <20161214213445.GD28424@amd>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Aaro Koskinen <aaro.koskinen@iki.fi>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [161214 13:34]:
> On Wed 2016-12-14 22:29:44, Pali Rohár wrote:
> > Trying to initialize eMMC slot as SDIO or SD cause failure in n900 port of
> > qemu. eMMC itself is not detected and is not working.
> > 
> > Real Nokia N900 harware does not have this problem. As eMMC is really not
> > SDIO or SD based such change is harmless and will fix support for qemu.
> > 
> > Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

Applying into omap-for-v4.10/fixes thanks.

Tony
