From: Tony Lindgren <tony@atomide.com>
Subject: Re: MMC performance degradation due to too many requests
Date: Mon, 14 May 2018 09:41:15 -0700
Message-ID: <20180514164115.GL98604@atomide.com>
References: <0ea1d2bf-fa0f-4b3d-556a-5dca5afbf2a9@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0ea1d2bf-fa0f-4b3d-556a-5dca5afbf2a9@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-mmc@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [180514 11:31]:
> Hi Everyone,
> 
> I am debugging a performance degradation issue in some SD cards which
> happened around 4.13 kernel on TI's AM335x-evm.
> 
> I compare the time taken for a simple dd command (after dropping
> caches) to run between kernel versions 4.13 and 4.14. I see that there
> is a consistent 15-20% reduction in speed. The amount of decrease
> depends on the card used.

Care to run git bisect between v4.13 and v4.14? Seems like that
should work just fine between that range for boot and performance
testing.

Regards,

Tony
