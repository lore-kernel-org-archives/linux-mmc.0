From: =?ISO-8859-1?Q?Emilio_L=F3pez?= <emilio@elopez.com.ar>
Subject: Re: [PATCH 02/14] clk: sunxi: factors: Implement clock min and max
 frequencies
Date: Thu, 17 Jul 2014 13:09:35 -0300
Message-ID: <53C7F53F.9000902@elopez.com.ar>
References: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com> <1405588134-2396-3-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from yotta.elopez.com.ar ([31.220.24.173]:41000 "EHLO
	yotta.elopez.com.ar" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804AbaGQQJz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Jul 2014 12:09:55 -0400
In-Reply-To: <1405588134-2396-3-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>, Hans de Goede <hdegoede@redhat.com>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Hi Maxime,

El 17/07/14 06:08, Maxime Ripard escribi=F3:
> In the A13, the out of reset frequency for the PLL6 is too high to be=
 actually
> working.
>
> Hence, we need to be able to lower down its frequency whenever we nee=
d to use
> the clock to some acceptable frequency.
>
> This patch adds two new properties in the clock-nodes, clk-min-freque=
ncy and
> clk-max-frequency, to specify acceptable boundaries for proper clock
> operations.

This paragraph looks out of place

>
> It also adds supports in the sunxi factor clocks driver to use these
> boundaries, enforce them at prepare time to make sure that the driver=
s will
> have a decent frequency, even though it never called set_rate, but al=
so make
> sure we never cross these boundaries.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
(...)
>
> @@ -123,6 +147,9 @@ static int clk_factors_set_rate(struct clk_hw *hw=
, unsigned long rate,
>
>   	factors->get_factors((u32 *)&rate, (u32)parent_rate, &n, &k, &m, &=
p);
>
> +	if ((rate > factors->max_rate) || (rate < factors->min_rate))
> +		return -EINVAL;

Printing an error message here may come in handy in the future, what do=
=20
you think?

Thanks for working on this!

Emilio
