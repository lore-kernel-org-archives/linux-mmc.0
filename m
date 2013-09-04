From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V3 2/4] mmc: mmci: Use optional sleep pinctrl state
Date: Wed, 4 Sep 2013 07:43:01 +0200
Message-ID: <CACRpkdYed8ZrGX+ADR51x+ctes1My2m=hJHV71WSrExZHPbeaA@mail.gmail.com>
References: <1378200576-13413-1-git-send-email-ulf.hansson@linaro.org>
	<1378200576-13413-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:65079 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761321Ab3IDFnD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Sep 2013 01:43:03 -0400
Received: by mail-ob0-f169.google.com with SMTP id es8so7019480obc.28
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2013 22:43:02 -0700 (PDT)
In-Reply-To: <1378200576-13413-3-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Tue, Sep 3, 2013 at 11:29 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

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
> Acked-by: Rickard Andersson <rickard.andersson@stericsson.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
