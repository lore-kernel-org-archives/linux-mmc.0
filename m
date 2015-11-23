From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: Re: dw_mmc: HLE errors
Date: Mon, 23 Nov 2015 12:29:30 -0500
Message-ID: <56534CFA.7070403@linaro.org>
References: <56531E3B.6060601@linaro.org>
 <CAD=FV=Xuzgy2FLD4okzM0=fq752Agfu3DsxAGX1AaBhVYfYNYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:33067 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbbKWR3d (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2015 12:29:33 -0500
Received: by vkfr145 with SMTP id r145so42598229vkf.0
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2015 09:29:33 -0800 (PST)
In-Reply-To: <CAD=FV=Xuzgy2FLD4okzM0=fq752Agfu3DsxAGX1AaBhVYfYNYg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 11/23/2015 11:57 AM, Doug Anderson wrote:
> Jorge,
>
> On Mon, Nov 23, 2015 at 6:10 AM, Jorge Ramirez-Ortiz
> <jorge.ramirez-ortiz@linaro.org> wrote:
>> Doug/Jaehoon,
>>
>> Were there any follow ups to this thread [1] from March 30, 2015?
>> We are seeing HLE errors on 3.18 and we are trying to determine if a solution
>> was ever delivered.
>> On inspection, I can't find anything specific in recent kernels that address
>> this particular issue (was the actual root cause identified?)
>>
>> I put together a possible work-around that avoids the HLE storm from occurring
>> for this specific SoC [2].
>> However we'd rather not merge this -or any other similar fix- if there is a
>> generic solution already that we can pick up from mainline.
> Nothing landed that I'm aware of.  Are you on SDIO, SD or eMMC?
> Trying to do UHS?

SD even without UHS (yet, that is coming now)

>
> I know that this patch mattered for me for UHS:
>
>   7c5209c315ea mmc: core: Increase delay for voltage to stabilize from
> 3.3V to 1.8V
>
>
> Also important for UHS (for at least some folks) were patches like:
>
>   9c85f37a2984 mmc: core: Add mmc_regulator_set_vqmmc()
>
> ...that attempted to get voltages more proper...

ack

>
>
> In the ChromeOS tree we did just land treating HLE errors as data and
> cmd errors <https://patchwork.kernel.org/patch/5978711/>.  It's not
> wonderful but it's better than letting an interrupt go off forever...

Yes I did try this patch on 3.18 but it didn't seem to be enough for us.
Even though it would prevent the interrupt storm from flooding the kernel, once
the event triggered and the interrupt was handled no more card
insertions/ejections would be detected.

ok, thanks for the info!



