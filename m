From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 0/8] mmc: dw_mmc-rockchip: allow tuning using the
 clk-phase api
Date: Fri, 9 Oct 2015 10:19:58 -0700
Message-ID: <CAD=FV=XdVt5Uop5WAUv6vY3=qPksnc9HzR4C9CBWpXJKuteTEQ@mail.gmail.com>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de>
	<CAPDyKFqeo--AiW_zHHrSqoOdFNZ3J_FgJpz2L7Z8gZnNmQZSig@mail.gmail.com>
	<CAPDyKFr6WV-o8Td9eJVkuCgaeNjdLr2GpaC32c3026bFmOJiYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:36638 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609AbbJIRT7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Oct 2015 13:19:59 -0400
Received: by ykba192 with SMTP id a192so80606958ykb.3
        for <linux-mmc@vger.kernel.org>; Fri, 09 Oct 2015 10:19:58 -0700 (PDT)
In-Reply-To: <CAPDyKFr6WV-o8Td9eJVkuCgaeNjdLr2GpaC32c3026bFmOJiYQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-clk@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Alexandru Stan <amstan@chromium.org>

Hi,

On Fri, Oct 9, 2015 at 1:10 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Dough, Heiko,
>
> This patchset seems to be causing a boot regression for exynos5800-peach-pi [1].
>
> Apparently, the vmmc regulator doesn't exist for one of the controller
> but vqmmc is. This leads to the following NULL pointer exception.

Ugh.  Hrm, it didn't used to be possible for vmmc to be NULL.  :-/  It
changed in v3.16:

  4d1f52f mmc: core: Improve support for deferred regulators

...and I didn't notice it (most of my development is done on 3.14).  :(


Is it sensible to have vqmmc without vmmc.  One option would be to
change mmc_regulator_get_supply() to not even bother trying to get
vqmmc if vmmc is not there.

Another option would be to just totally fail mmc_regulator_set_vqmmc()
always if vmmc is an error.  ...or assume that any bogus vmmc (either
vmmc is an error or regulator_get_voltage(vmmc) returns an error) is
3.3V?


I guess the safest is to assume that bogus vmmc means 3.3V...


-Doug
