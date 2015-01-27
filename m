From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: core: use card pointer as the first parameter of execute_tuning()
Date: Tue, 27 Jan 2015 16:18:06 +0100
Message-ID: <CAPDyKFqjG=yxDcwnk4jbXMZ05hMkWR2x37uVpRNd_11-eB4G7w@mail.gmail.com>
References: <1422271175-19445-1-git-send-email-addy.ke@rock-chips.com>
	<1422271175-19445-2-git-send-email-addy.ke@rock-chips.com>
	<CAPDyKFp=5epMggHu0+u_LU7ETujcoeP2xOpB7iD6JF2bs8BnEA@mail.gmail.com>
	<CAD=FV=X9x0gW5TyLi4ERm8nxixQB__Y=5bRAtOax-_w+T33rCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:58678 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835AbbA0PSI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Jan 2015 10:18:08 -0500
Received: by mail-qa0-f48.google.com with SMTP id v8so11744313qal.7
        for <linux-mmc@vger.kernel.org>; Tue, 27 Jan 2015 07:18:07 -0800 (PST)
In-Reply-To: <CAD=FV=X9x0gW5TyLi4ERm8nxixQB__Y=5bRAtOax-_w+T33rCg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Addy Ke <addy.ke@rock-chips.com>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Dinh Nguyen <dinguyen@altera.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Olof Johansson <olof@lixom.net>, Sonny Rao <sonnyrao@chromium.org>, Alexandru Stan <amstan@chromium.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.or>

On 26 January 2015 at 18:45, Doug Anderson <dianders@chromium.org> wrote:
> Ulf,
>
> On Mon, Jan 26, 2015 at 7:15 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 26 January 2015 at 12:19, Addy Ke <addy.ke@rock-chips.com> wrote:
>>> We need to take the card pointer in execute_tuning() for mmc_send_status(),
>>
>> mmc_send_status() is an mmc core function, not intended for host's to call.
>>
>>> but mmc->card is NULL in tuning state. So we need change the first parameter
>>> of execute_tuning() to card pointer(struct mmc_card * card).
>>
>> So, why do we need this?
>
> I asked Addy to post upstream against mmc_send_tuning(), but I guess
> he didn't (he posted against Alex's NAKed patch instead).
>
> ...when I talked to him about it, Addy was asserting that when tuning
> fails it is important (at least on dw_mmc on rk3288) that we wait for
> the card to stop being busy and that the way to detect was using
> mmc_send_status().

So, could that be due to the internal logic of the error handling in
dw_mmc driver? Or you think this is a generic issue?

According to the specifications (eMMC and SD) both states that the
tuning command has an R1 response. So, there shouldn't be any busy
signalling involved - at least according to spec.

>
> That would mean that against upstream you'd need to change
> mmc_send_tuning() to take in the card as well (or move the "host->card
> = card" assignment to before UHS init, which seems less desirable?)
>
> What do you think about that?  Is there a better solution?

Why do we need to change mmc_send_tuning()? I thought the issue was
that mmc_send_status(), which currently takes "card" as a parameter.

Kind regards
Uffe
