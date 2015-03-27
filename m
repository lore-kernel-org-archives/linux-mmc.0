From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 1/4] mmc: dw_mmc: Don't try to enable the CD until
 we're sure we're not deferring
Date: Fri, 27 Mar 2015 08:46:57 -0700
Message-ID: <CAD=FV=XFjTGkzwgySAFKUtpgNLZEe_ovAR+CnjLB6k8U_GMc6g@mail.gmail.com>
References: <1426112117-18220-1-git-send-email-dianders@chromium.org>
	<5514F0C5.7080509@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5514F0C5.7080509@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Seungwon Jeon <tgih.jun@samsung.com>, Mark Brown <broonie@kernel.org>, Alexandru Stan <amstan@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Addy Ke <addy.ke@rock-chips.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Jaehoon,

On Thu, Mar 26, 2015 at 10:55 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi, Doug.
>
> This patch is not related with [patch 2/4~4/4].
> "[PATCH v4 2/4] mmc: core: Add mmc_regulator_set_vqmmc()" is discussing..
> So i think if you're ok, i will pick this one [PATCH v4 1/4]. how about?

Please take it and send it to Ulf as soon as you can.  It is only
related in that the later patches in this series suddenly make the
rk3288-evb start deferring and that causes a crash without this patch.
