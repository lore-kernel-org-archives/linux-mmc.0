From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: core: Ensure clocks are always enabled before host interaction
Date: Mon, 30 Jan 2012 20:33:35 +0100
Message-ID: <CACRpkdZOAEDTCoU=6=ukgEPj_1Qau8eRxxOx1H4p=310omvFXA@mail.gmail.com>
References: <1323678104-28854-1-git-send-email-sthumma@codeaurora.org>
	<CACRpkdbZS7TxKSpKR0DV4TC4dOzO_q83U1bd0HonKC2GBDBOgA@mail.gmail.com>
	<4F1E2933.8030708@codeaurora.org>
	<CAFEEs1=SoPvTSoBFybVLVC8ZHi8fuUNy0ZLAjXn2jYV0T5Lv3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38893 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab2A3Tdg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2012 14:33:36 -0500
Received: by ggnb1 with SMTP id b1so2023844ggn.19
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2012 11:33:35 -0800 (PST)
In-Reply-To: <CAFEEs1=SoPvTSoBFybVLVC8ZHi8fuUNy0ZLAjXn2jYV0T5Lv3g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>
Cc: Sujit Reddy Thumma <sthumma@codeaurora.org>, Per Forlin <per.friden@stericsson.com>, linux-mmc@vger.kernel.org, cjb@laptop.org

On Mon, Jan 30, 2012 at 1:48 PM, Per Forlin <per.lkml@gmail.com> wrote:

> It makes sense to ensure clocking in pre-req() and post-req()
> implemented by this patch.
> My only concern from a throughput point of view is if the clocking
> adds an overhead, but AFAIK the clocking doesn't add an overhead (that
> would increase the prepare time).

Shouldn't be a concern here since there is already a hysteresis
window across these calls, so the clock never get disabled on
back-to-back transfers AFAICT.

> Acked-by: Per Forlin <per.forlin@stericsson.com>

Thanks,
Linus Walleij
