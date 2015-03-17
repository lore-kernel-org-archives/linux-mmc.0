From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 2/4] mmc: core: Add mmc_regulator_set_vqmmc()
Date: Tue, 17 Mar 2015 12:28:34 +0100
Message-ID: <CAPDyKFqGYqNCbGGzw7orXLT+pkxK5LMUDTYWju405tqynPMyCQ@mail.gmail.com>
References: <1426112117-18220-1-git-send-email-dianders@chromium.org>
	<1426112117-18220-2-git-send-email-dianders@chromium.org>
	<CAPDyKFq_WMJfqNGuxwN7xPmhv2X6-+G1zXpdD6zYDkDe7-Jo2A@mail.gmail.com>
	<CAD=FV=U-YnT5jF5MFC==hANXGPqVpV3iLMPu85TrQ4dNDsWeCA@mail.gmail.com>
	<CAPDyKFpG=q88QEkuAgoLqkZU40Kx7dB7PmnXHqEt0EtbYvR_Cg@mail.gmail.com>
	<20150317103829.GA28806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:33488 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbbCQL2f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Mar 2015 07:28:35 -0400
Received: by qgfa8 with SMTP id a8so4699047qgf.0
        for <linux-mmc@vger.kernel.org>; Tue, 17 Mar 2015 04:28:34 -0700 (PDT)
In-Reply-To: <20150317103829.GA28806@sirena.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Alexandru Stan <amstan@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Addy Ke <addy.ke@rock-chips.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <chris@printf.net>, Johan Rudholm <johan.rudholm@axis.com>, Adrian Hunter <adrian.hunter@intel.com>, Tim Kryger <tim.kryger@gmail.com>, Andrew Gabbasov <andrew_gabbasov@mentor.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kerne>

On 17 March 2015 at 11:38, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Mar 17, 2015 at 11:23:33AM +0100, Ulf Hansson wrote:
>> On 16 March 2015 at 16:12, Doug Anderson <dianders@chromium.org> wrote:
>
>> > * Try to set the voltage to exactly 1,200,000 uV (1.2V).
>> > * If you can't get 1.2V exactly, a tolerance ("tol") of 100,000 uV
>> > (.1V) is OK.
>> > * In other words, 1.1V - 1.3V are OK, but aim for 1.2V
>
>> So what happens in the case when 1.3V and 1.1V, but not 1.2V. Which
>> value will be used? Is that algorithm defined by the regulator core or
>> does it depend per regulator implementation?
>
> It's done in the core.  It first tries to hit the target voltage to the
> maximum (picking the lowest voltage in that range) then tries to pick
> the lowest voltage to the target, though that's an implementation detail
> and we really should be trying to get as close as possible to the
> target.  We don't do that yet because it can be expensive to work out so
> we do the current thing which is cheap and mostly good enough.

Okay, so that seems to work well for our 1.1V->1.3V case.

Thanks!

Kind regards
Uffe
