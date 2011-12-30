From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: core: Ensure clocks are always enabled before host interaction
Date: Fri, 30 Dec 2011 03:14:09 +0100
Message-ID: <CACRpkdbZS7TxKSpKR0DV4TC4dOzO_q83U1bd0HonKC2GBDBOgA@mail.gmail.com>
References: <1323678104-28854-1-git-send-email-sthumma@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42066 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754856Ab1L3COK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Dec 2011 21:14:10 -0500
Received: by iaeh11 with SMTP id h11so24530791iae.19
        for <linux-mmc@vger.kernel.org>; Thu, 29 Dec 2011 18:14:09 -0800 (PST)
In-Reply-To: <1323678104-28854-1-git-send-email-sthumma@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>, Per Forlin <per.friden@stericsson.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org

On Mon, Dec 12, 2011 at 9:21 AM, Sujit Reddy Thumma
<sthumma@codeaurora.org> wrote:

> Ensure clocks are always enabled before any interaction with the
> host controller driver. This makes sure that there is no race
> between host execution and the core layer turning off clocks
> in different context with clock gating framework.
>
> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>

I guess Per F=F6rlin may not be available, but would have preferred to
have his view on this as well, since he knows the semantics of
pre/post-req.

However from my PoV it looks nice and clean, and you surely have
done some serious testing on things like SDIO so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
