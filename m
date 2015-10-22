From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v2 1/8] clk: rockchip: Allow more precision for some mmc clock phases
Date: Thu, 22 Oct 2015 15:47:20 +0200
Message-ID: <6921472.VNZp85YW8f@diego>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de> <1443622064-14362-2-git-send-email-heiko@sntech.de> <20151022120326.20687.80247@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20151022120326.20687.80247@quantum>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: ulf.hansson@linaro.org, sboyd@codeaurora.org, tgih.jun@samsung.com, jh80.chung@samsung.com, linux-mmc@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, dianders@chromium.org, amstan@chromium.org
List-Id: linux-mmc@vger.kernel.org

Hi Mike,

Am Donnerstag, 22. Oktober 2015, 05:03:26 schrieb Michael Turquette:
> Quoting Heiko Stuebner (2015-09-30 07:07:37)
> 
> > From: Douglas Anderson <dianders@chromium.org>
> > 
> > Because of the inexact nature of the extra MMC delay elements (it's
> > not possible to keep the phase monotonic and to also make phases (mod
> > 90) > 70), we previously only allowed phases (mod 90) of 22.5, 45,
> > and 67.5.
> > 
> > But it's not the end of the world if the MMC clock phase goes
> > non-monotonic.  At most we'll be 25 degrees off.  It's way better to
> > test more phases to look for bad ones than to be 25 degrees off, because
> > in the case of MMC really the point is to find bad phases and get as far
> > asway from the as possible.  If we get to test extra phases by going
> > slightly non-monotonic then that might be fine.  Worst case we would
> > end up at a phases that's slight differnt than the one we wanted, but
> > at least we'd still be quite far away from the a bad phase.
> > 
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > 
> > Fold in more precise variance-values of 44-77 instead of 40-80.
> > Fold in the actual removal of the monotonic requirement and adapt
> > patch message accordingly.
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> Looks good to me. What tree do you want this to go through?

we got already an Ack from Stephen [in the thread of patch3] for the clock 
patches and they are already in the mmc.tree [0].


Heiko


[0] 
https://git.linaro.org/people/ulf.hansson/mmc.git/commit/6cf04362a13de8cdb59b85b8dec1d53f90307dd1
