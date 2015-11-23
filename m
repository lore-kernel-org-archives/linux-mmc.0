From: Doug Anderson <dianders@chromium.org>
Subject: Re: dw_mmc: HLE errors
Date: Mon, 23 Nov 2015 08:57:32 -0800
Message-ID: <CAD=FV=Xuzgy2FLD4okzM0=fq752Agfu3DsxAGX1AaBhVYfYNYg@mail.gmail.com>
References: <56531E3B.6060601@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:33409 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbbKWQ5e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2015 11:57:34 -0500
Received: by ykdv3 with SMTP id v3so243945710ykd.0
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2015 08:57:33 -0800 (PST)
In-Reply-To: <56531E3B.6060601@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Jorge,

On Mon, Nov 23, 2015 at 6:10 AM, Jorge Ramirez-Ortiz
<jorge.ramirez-ortiz@linaro.org> wrote:
> Doug/Jaehoon,
>
> Were there any follow ups to this thread [1] from March 30, 2015?
> We are seeing HLE errors on 3.18 and we are trying to determine if a solution
> was ever delivered.
> On inspection, I can't find anything specific in recent kernels that address
> this particular issue (was the actual root cause identified?)
>
> I put together a possible work-around that avoids the HLE storm from occurring
> for this specific SoC [2].
> However we'd rather not merge this -or any other similar fix- if there is a
> generic solution already that we can pick up from mainline.

Nothing landed that I'm aware of.  Are you on SDIO, SD or eMMC?
Trying to do UHS?

I know that this patch mattered for me for UHS:

  7c5209c315ea mmc: core: Increase delay for voltage to stabilize from
3.3V to 1.8V


Also important for UHS (for at least some folks) were patches like:

  9c85f37a2984 mmc: core: Add mmc_regulator_set_vqmmc()

...that attempted to get voltages more proper...


In the ChromeOS tree we did just land treating HLE errors as data and
cmd errors <https://patchwork.kernel.org/patch/5978711/>.  It's not
wonderful but it's better than letting an interrupt go off forever...


-Doug
