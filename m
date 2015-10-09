From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 4/8] mmc: dw_mmc: Use mmc_regulator_set_vqmmc in start_signal_voltage_switch
Date: Fri, 9 Oct 2015 13:12:10 -0700
Message-ID: <CAD=FV=XfoRoj610zXvBPxAwSO7O_eYGxsAidnEnXx5mK1ANGrg@mail.gmail.com>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de>
	<1443622064-14362-5-git-send-email-heiko@sntech.de>
	<CAMAWPa9o=bQJPK+tJ38=5jngTFcOsAi=s9RcETbPN=3SsyQ8gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:33609 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbbJIUML (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Oct 2015 16:12:11 -0400
Received: by ykft14 with SMTP id t14so89020071ykf.0
        for <linux-mmc@vger.kernel.org>; Fri, 09 Oct 2015 13:12:10 -0700 (PDT)
In-Reply-To: <CAMAWPa9o=bQJPK+tJ38=5jngTFcOsAi=s9RcETbPN=3SsyQ8gA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Alexandru Stan <amstan@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, linux-clk@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tyler Baker <tyler.baker@linaro.org>, Olof Johansson <olof@lixom.net>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>

Kevin,

On Fri, Oct 9, 2015 at 12:06 PM, Kevin Hilman <khilman@kernel.org> wrote:
> On Wed, Sep 30, 2015 at 4:07 PM, Heiko Stuebner <heiko@sntech.de> wrote:
>> From: Douglas Anderson <dianders@chromium.org>
>>
>> We've introduced a new helper in the MMC core:
>> mmc_regulator_set_vqmmc().  Let's use this in dw_mmc.  Using this new
>> helper has some advantages:
>>
>> 1. We get the mmc_regulator_set_vqmmc() behavior of trying to match
>>    VQMMC and VMMC when the signal voltage is 3.3V.  This ensures max
>>    compatibility.
>>
>> 2. We get rid of a few more warnings when probing unsupported
>>    voltages.
>>
>> 3. We get rid of some non-dw_mmc specific code in dw_mmc.
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> kernelci.org found a new failure in linux-next on
> exynos5800-peach-pi[1] and it was bisected down to this patch, which
> has hit linux-next in the form of commit fba2e23128d0 (mmc: dw_mmc:
> Use mmc_regulator_set_vqmmc in start_signal_voltage_switch).  Based on
> a quick glance at the boot log[2], it looks to be a bad pointer
> dereference in regulator_get_voltage().
>
> I confirmed that reverting this patch on top of next-20151009 gets my
> peach-pi booting again.
>
> Note that the boot failure is only on exynos_defconfig, not multi_v7_defconfig.

Right.  See <http://www.spinics.net/lists/arm-kernel/msg450802.html>
for discussion.  Ulf responded to the cover letter rather than the
individual patch.

-Doug
