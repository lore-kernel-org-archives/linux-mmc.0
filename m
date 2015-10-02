From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: core: Remove MMC_CLKGATE
Date: Fri, 2 Oct 2015 02:23:56 -0700
Message-ID: <CACRpkdbKO7qs20BXd2jp7yKcnqe6aa-QUhqY25VXj0XhtsHA2g@mail.gmail.com>
References: <1443776171-7127-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36815 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbbJBJX5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Oct 2015 05:23:57 -0400
Received: by oibi136 with SMTP id i136so54999896oib.3
        for <linux-mmc@vger.kernel.org>; Fri, 02 Oct 2015 02:23:56 -0700 (PDT)
In-Reply-To: <1443776171-7127-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Fri, Oct 2, 2015 at 1:56 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> MMC_CLKGATE was once invented to save power by gating the bus clock at
> request inactivity. At that time it served its purpose. The modern way to
> deal with power saving for these scenarios, is by using runtime PM.
>
> Nowadays, several host drivers have deployed runtime PM, but for those
> that haven't and which still cares power saving at request inactivity,
> it's certainly time to deploy runtime PM as it has been around for several
> years now.
>
> To simplify code to mmc core and thus decrease maintenance efforts, this
> patch removes all code related to MMC_CLKGATE.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Runtime PM is the generic solution to the specific problem, good feat.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
