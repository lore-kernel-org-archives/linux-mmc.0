From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 0/3] mmc: mmci: Support ap_sleep in cpuidle for ux500
Date: Mon, 10 Jun 2013 22:43:15 +0200
Message-ID: <CAPDyKFrtwGgnKi_E9Bu4W836KabjfE-rB1JPKg+CNcgRtqRXwQ@mail.gmail.com>
References: <1369302307-28540-1-git-send-email-ulf.hansson@stericsson.com>
	<C832F8F5D375BD43BFA11E82E0FE9FE0115A936A54@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f41.google.com ([209.85.212.41]:60927 "EHLO
	mail-vb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812Ab3FJUnQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jun 2013 16:43:16 -0400
Received: by mail-vb0-f41.google.com with SMTP id p13so3368367vbe.14
        for <linux-mmc@vger.kernel.org>; Mon, 10 Jun 2013 13:43:15 -0700 (PDT)
In-Reply-To: <C832F8F5D375BD43BFA11E82E0FE9FE0115A936A54@EXDCVYMBSTM005.EQ1STM.local>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Ulf HANSSON <ulf.hansson@stericsson.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Rickard ANDERSSON <rickard.andersson@stericsson.com>

On 27 May 2013 13:40, Rickard ANDERSSON
<rickard.andersson@stericsson.com> wrote:
> Acked-by: Rickard Andersson <rickard.andersson@stericsson.com>
>
> -----Original Message-----
> From: Ulf HANSSON
> Sent: den 23 maj 2013 11:45
> To: linux-arm-kernel@lists.infradead.org; Russell King
> Cc: linux-mmc@vger.kernel.org; Chris Ball; Daniel Lezcano; Linus Walleij; Rickard ANDERSSON; Ulf Hansson
> Subject: [PATCH V2 0/3] mmc: mmci: Support ap_sleep in cpuidle for ux500
>
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> To be able to enter ap_sleep state in cpuidle were the APE power domain regulator will be cut, a register save and restore mechanism needs to be implemented. This patchset adapts to these restrictions.
>
> Ulf Hansson (3):
>   mmc: mmci: Use optional sleep pinctrl state
>   mmc: mmci: Adapt to register write restrictions
>   mmc: mmci: Save and restore register context
>
>  drivers/mmc/host/mmci.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/mmci.h |    1 +
>  2 files changed, 76 insertions(+)
>
> --
> 1.7.10
>

Hi Russell,

Just wanted to send a ping on this patch set. As you likely are aware
of, I have uploaded the patches in your patch tracker a while ago.

Kind regards
Ulf Hansson
