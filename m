From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] MMC: fix a race between card-detect rescan and clock-gate
 work instances
Date: Tue, 19 Apr 2011 02:53:38 +0200
Message-ID: <BANLkTin708=LsiF4m8mbZ_s_X4T34c3SNg@mail.gmail.com>
References: <Pine.LNX.4.64.1104152006110.18593@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1104152006110.18593@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

2011/4/15 Guennadi Liakhovetski <g.liakhovetski@gmx.de>:

> Currently there is a race in the MMC core between a card-detect
> rescan work and the clock-gating work, scheduled from a command
> completion. Fix it by removing the dedicated clock-gating mutex and
> using the MMC standard locking mechanism instead.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks a lot Guennadi!
Linus Walleij
