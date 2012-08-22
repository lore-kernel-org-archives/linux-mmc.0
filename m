From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/2] mmc: core: Add a capability for disabling mmc cards
Date: Wed, 22 Aug 2012 08:44:03 -0700
Message-ID: <CAD=FV=UZM9b6++DkgemZA7qpAZgFN+NyyLjRecgSdjcEsu0YYA@mail.gmail.com>
References: <1345608318-15347-1-git-send-email-dianders@chromium.org>
	<50346181.3010406@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:54351 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654Ab2HVPoE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Aug 2012 11:44:04 -0400
Received: by qaas11 with SMTP id s11so4581847qaa.19
        for <linux-mmc@vger.kernel.org>; Wed, 22 Aug 2012 08:44:04 -0700 (PDT)
In-Reply-To: <50346181.3010406@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, Olof Johansson <olof@lixom.net>, Alim Akhtar <alim.akhtar@samsung.com>, Thomas P Abraham <thomas.ab@samsung.com>, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>, James Hogan <james.hogan@imgtec.com>, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>

Jaehoon,

On Tue, Aug 21, 2012 at 9:35 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>
> Hi Doug,
>
> I didn't know what purpose is.
> Why need to add the MMC_CAP2_NO_MMC?
> If card is SD or SDIO, mmc_attach_mmc(host) should not be entered.
> Could you explain to me in more detail?

Thanks for your feedback.  In this case I have a card that is an MMC
card so mmc_attach_sdio() and mmc_attach_sd() will fail.  If I let
mmc_attach_mmc() run it will actually find the MMC card.  However, on
this platform it is not valid to recognize MMC cards.

-Doug
