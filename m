From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH] mmc: sdhci: remove mdelay in eMMC tuning
Date: Wed, 14 May 2014 02:22:43 +0100
Message-ID: <86wqdprw64.fsf@void.printf.net>
References: <1399427558-8478-1-git-send-email-nsanders@chromium.org>
	<CAPDyKFpsm_M2oY3OuVHZ-MCNezT6xwo-HPwfo1pxfrw5ySKfOg@mail.gmail.com>
	<CANEJEGt1-BYD2kaHJisQ=YBj6k4CJU5-7_bjW+M5TZ_yuMY_TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41951 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383AbaENBWq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 13 May 2014 21:22:46 -0400
In-Reply-To: <CANEJEGt1-BYD2kaHJisQ=YBj6k4CJU5-7_bjW+M5TZ_yuMY_TQ@mail.gmail.com>
	(Grant Grundler's message of "Tue, 13 May 2014 18:13:30 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Nick Sanders <nsanders@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Chang-Eun Choi-SSI <cu.choi@ssi.samsung.com>

Hi,

On Wed, May 14 2014, Grant Grundler wrote:
>>> The delay is left in place for SD Cards, which use
>>> MMC_SEND_TUNING_BLOCK rather than MMC_SEND_TUNING_BLOCK_HS200.
>>> I'm not able to find evidence that this is required for SD in the
>>> specs I have access to, however this delay has been present from
>>> initial checkin for SD so I have preserved the original behavior for
>>> compatibility.
>>>
>>> This has been verified to fix observed glitching on local audio
>>> playback and recording on apps with inbuilt assumptions on storage
>>> latency.
>>>
>>> Signed-off-by: Nick Sanders <nsanders@chromium.org>
>>> Reviewed-by: Grant Grundler <grundler@chromium.org>
>>> Reviewed-by: Doug Anderson <dianders@chromium.org>
>>
>> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Ulf,
> Is your ACK enough to get this to land upstream or does cjb need to
> respond it's been accepted?
>
> It doesn't appear to have landed in mmc-next branch yet:
>     http://git.kernel.org/cgit/linux/kernel/git/cjb/mmc.git/log/?h=mmc-next
>
> apologies if it appears I am being impatient...but it's been almost a week now.

Sorry about that.  Looks fine, pushed to mmc-next with Ulf's ACK now.

- Chris.
-- 
Chris Ball   <http://printf.net/>
