From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 2/4] mmc: core: Add mmc_regulator_set_vqmmc()
Date: Tue, 7 Apr 2015 13:05:43 -0700
Message-ID: <CAD=FV=WpDE_iEFWFw094WBfBH2TgRi+1OGk3E3qQ3t1EfyrnJA@mail.gmail.com>
References: <1426112117-18220-1-git-send-email-dianders@chromium.org>
	<1426112117-18220-2-git-send-email-dianders@chromium.org>
	<CAPDyKFq_WMJfqNGuxwN7xPmhv2X6-+G1zXpdD6zYDkDe7-Jo2A@mail.gmail.com>
	<CAD=FV=U-YnT5jF5MFC==hANXGPqVpV3iLMPu85TrQ4dNDsWeCA@mail.gmail.com>
	<CAPDyKFpG=q88QEkuAgoLqkZU40Kx7dB7PmnXHqEt0EtbYvR_Cg@mail.gmail.com>
	<CAD=FV=X=1=AnXCGgWWkJDcHLO-MfVqsSB2aJxi3WOgWJhD_ggA@mail.gmail.com>
	<CAPDyKFrkznbW7k_=BDo99jJhWzDbUgbeU+MXWB_E_UWXh=56Eg@mail.gmail.com>
	<20150319113646.GQ2869@sirena.org.uk>
	<CAPDyKFroe9N3j9oMWKknH5huv7j8fkrBr5UKjjp190hkqNsNRg@mail.gmail.com>
	<20150320112828.GF2869@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150320112828.GF2869@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Alexandru Stan <amstan@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Addy Ke <addy.ke@rock-chips.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <chris@printf.net>, Johan Rudholm <johan.rudholm@axis.com>, Adrian Hunter <adrian.hunter@intel.com>, Tim Kryger <tim.kryger@gmail.com>, Andrew Gabbasov <andrew_gabbasov@mentor.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, Mar 20, 2015 at 4:28 AM, Mark Brown <broonie@kernel.org> wrote:
> As previously discussed the problem is that there can be a *lot* of
> voltages on a modern regulator with fine grained voltage steps and
> tolerances are also used for things like cpufreq where we care about
> performance.  We need something that doesn't require a linear scan of
> possible values.

Finally getting back to this (sorry for the delay!).  I tried
modifying my patches to keep using the simple implementation of
regulator_set_voltage_tol() but to take two tolerances (lower and
upper).  ...but when I thought about it I decided it wasn't enough.  I
think that doing a proper implementation of
regulator_set_voltage_tol() is going to be a requirement for getting
the MMC core changes posted.

Specifically, I think the right implementation for the MMC core's 3.3V
signaling is something like this:

  /*
   * Bus operating conditions say that card should accept input
   * between (0.625 * VDD) and (VDD + 0.3), so we'll use those
   * as tolerances.
   */
  return mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
       vmmc_voltage, vmmc_voltage * 375 / 1000, 300000);

Ulf says he has a board where vmmc is 3.4V and the max vqmmc is 2.9V.
If we think about that board, we'll end up calling
regulator_set_voltage_tol() with a lower/upper tolerance of 1.275V and
.3V.

Extending the current simple implementation of
regulator_set_voltage_tol() to take an upper and lower, that will
translate to first trying to set the voltage to 3.4V - 3.7V, which
will fail.  We'll then try to set the voltage to 2.125V - 3.7V.
Presumably that will end up picking 2.125V, which is really non-ideal
compared to 2.9V and it seems likely to cause some cards to start
failing.

Mark: I know you said you were considering writing a better
regulator_set_voltage_tol() yourself, but I don't know if you've
already started work on it.

I'm expecting to maybe have time to take a crack at it in a few weeks
if you haven't already done it by then.

Thanks!

-Doug
