From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] mmc: mmci: Use optional sleep pinctrl state
Date: Mon, 13 May 2013 19:48:48 +0200
Message-ID: <CACRpkdarH5FbegyN17n+--hoCgHqzEupUA0pjkXG3juCA9aW5w@mail.gmail.com>
References: <1368452837-31458-1-git-send-email-ulf.hansson@stericsson.com>
	<1368452837-31458-2-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:42696 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab3EMRst (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2013 13:48:49 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so13035855ief.12
        for <linux-mmc@vger.kernel.org>; Mon, 13 May 2013 10:48:48 -0700 (PDT)
In-Reply-To: <1368452837-31458-2-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rickard Andersson <rickard.andersson@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>

On Mon, May 13, 2013 at 3:47 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> By optionally putting the pins into sleep state in the .runtime_suspend
> callback we can accomplish two things. One is to minimize current leakage
> from pins and thus save power, second we can prevent the IP from driving
> pins output in an uncontrolled manner, which may happen if the power domain
> drops the domain regulator.
>
> When returning from idle, entering .runtime_resume callback, the pins
> are restored to default state.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Looks straight-forward from a pinctrl point of view.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
