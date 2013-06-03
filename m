From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 09/10] arm: add debug uarts for rockchip rk29xx and rk3xxx series
Date: Mon, 03 Jun 2013 04:08:37 +0200
Message-ID: <19033743.NUXvdvXthR@wuerfel>
References: <201306030055.15413.heiko@sntech.de> <201306030101.04370.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:64312 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755363Ab3FCCIq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 2 Jun 2013 22:08:46 -0400
In-Reply-To: <201306030101.04370.heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Mike Turquette <mturquette@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Jaehoon Chung <jh80.chung@samsung.com>, Olof Johansson <olof@lixom.net>, John Stultz <john.stultz@linaro.org>, Grant Likely <grant.likely@linaro.org>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>, devicetree-discuss@lists.ozlabs.org

On Monday 03 June 2013 01:01:03 Heiko St=FCbner wrote:
> +#if defined(CONFIG_DEBUG_RK29_UART0)
> +#define ROCKCHIP_UART_DEBUG_PHYS_BASE 0x20060000
> +#define ROCKCHIP_UART_DEBUG_VIRT_BASE 0xfe060000

0xfed60000 maybe? looks like a typo.

	Arnd

