From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V3 1/4] mmc: mmci: Adapt to new pinctrl handling
Date: Wed, 4 Sep 2013 07:42:16 +0200
Message-ID: <CACRpkdbPLPWO4PjDRzPE-FneSYPMtNtbVOSyzNxsmhC7ni6=tA@mail.gmail.com>
References: <1378200576-13413-1-git-send-email-ulf.hansson@linaro.org>
	<1378200576-13413-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:44408 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761388Ab3IDFmR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Sep 2013 01:42:17 -0400
Received: by mail-ob0-f178.google.com with SMTP id ef5so6978837obb.9
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2013 22:42:16 -0700 (PDT)
In-Reply-To: <1378200576-13413-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Tue, Sep 3, 2013 at 11:29 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> There is no need for every driver to fetch a pinctrl handle and to
> select the default state. Instead this is handled by the device driver
> core, thus we can remove this piece of code from mmci.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
