From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v2 4/8] mmc: dw_mmc: Use mmc_regulator_set_vqmmc in start_signal_voltage_switch
Date: Fri, 9 Oct 2015 22:17:49 +0200
Message-ID: <CAMAWPa9rOvwjBRZ7x7xVcEdaTxtWChw1_qXBqk9ziFM-nA=XNw@mail.gmail.com>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de>
	<1443622064-14362-5-git-send-email-heiko@sntech.de>
	<CAMAWPa9o=bQJPK+tJ38=5jngTFcOsAi=s9RcETbPN=3SsyQ8gA@mail.gmail.com>
	<CAD=FV=XfoRoj610zXvBPxAwSO7O_eYGxsAidnEnXx5mK1ANGrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38497 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751229AbbJIURz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 9 Oct 2015 16:17:55 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 59FBF207DA
	for <linux-mmc@vger.kernel.org>; Fri,  9 Oct 2015 20:17:54 +0000 (UTC)
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com [209.85.212.176])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 1A0FD207AF
	for <linux-mmc@vger.kernel.org>; Fri,  9 Oct 2015 20:17:51 +0000 (UTC)
Received: by wicfx3 with SMTP id fx3so81034935wic.0
        for <linux-mmc@vger.kernel.org>; Fri, 09 Oct 2015 13:17:49 -0700 (PDT)
In-Reply-To: <CAD=FV=XfoRoj610zXvBPxAwSO7O_eYGxsAidnEnXx5mK1ANGrg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Kevin Hilman <khilman@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Alexandru Stan <amstan@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, linux-clk@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tyler Baker <tyler.baker@linaro.org>, Olof Johansson <olof@lixom.net>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>

On Fri, Oct 9, 2015 at 10:12 PM, Doug Anderson <dianders@chromium.org> wrote:
> Kevin,
>
> On Fri, Oct 9, 2015 at 12:06 PM, Kevin Hilman <khilman@kernel.org> wrote:
>> On Wed, Sep 30, 2015 at 4:07 PM, Heiko Stuebner <heiko@sntech.de> wrote:
>>> From: Douglas Anderson <dianders@chromium.org>
>>>
>>> We've introduced a new helper in the MMC core:
>>> mmc_regulator_set_vqmmc().  Let's use this in dw_mmc.  Using this new
>>> helper has some advantages:
>>>
>>> 1. We get the mmc_regulator_set_vqmmc() behavior of trying to match
>>>    VQMMC and VMMC when the signal voltage is 3.3V.  This ensures max
>>>    compatibility.
>>>
>>> 2. We get rid of a few more warnings when probing unsupported
>>>    voltages.
>>>
>>> 3. We get rid of some non-dw_mmc specific code in dw_mmc.
>>>
>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>>
>> kernelci.org found a new failure in linux-next on
>> exynos5800-peach-pi[1] and it was bisected down to this patch, which
>> has hit linux-next in the form of commit fba2e23128d0 (mmc: dw_mmc:
>> Use mmc_regulator_set_vqmmc in start_signal_voltage_switch).  Based on
>> a quick glance at the boot log[2], it looks to be a bad pointer
>> dereference in regulator_get_voltage().
>>
>> I confirmed that reverting this patch on top of next-20151009 gets my
>> peach-pi booting again.
>>
>> Note that the boot failure is only on exynos_defconfig, not multi_v7_defconfig.
>
> Right.  See <http://www.spinics.net/lists/arm-kernel/msg450802.html>
> for discussion.  Ulf responded to the cover letter rather than the
> individual patch.

Ah, I hadn't noticed that.  Thanks.

I guess it should be dropped by tomorrow's linux-next then.  I'll keep
an eye on it.

Kevin
