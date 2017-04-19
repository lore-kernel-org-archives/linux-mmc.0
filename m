From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: Don't allow Runtime PM for SDIO cards
Date: Wed, 19 Apr 2017 10:55:05 -0700
Message-ID: <20170419175504.GA91276@google.com>
References: <20170411225543.987-1-dianders@chromium.org>
 <CAPDyKFoK+zv+dY1+qrWg10kBE9S7enDkxbKQTy=XejsKmq+Z3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFoK+zv+dY1+qrWg10kBE9S7enDkxbKQTy=XejsKmq+Z3A@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, kevin@archlinuxarm.org, Alexandru Stan <amstan@chromium.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, "# 4.0+" <stable@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

I'm a little late as this already landed (and I trusted Doug was
handling this just fine), but anyway:

On Tue, Apr 18, 2017 at 09:15:29PM +0200, Ulf Hansson wrote:
> Thanks, applied for fixes!

Yes, thanks :)

FWIW:

Tested-by: Brian Norris <briannorris@chromium.org>

Also, for some reason the eMMC crashes are now harder to reproduce.
Perhaps I was just (un)lucky the first few times I tested. Maybe it's an
existing issue and hasn't gotten much worse, except for possibly the
additional churn that runtime PM gives it.

But the SDIO/Wifi issues were definitely the primary thing that prompted
my original report, so I'm much happier now.

Brian
