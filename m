From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 19/21] mmc: core: Move public functions from card.h to
 private headers
Date: Mon, 9 Jan 2017 19:26:05 +0100
Message-ID: <CACRpkdZpZmPhGbm+2=2GBeMmR-GX=uQwQAFWLySWUiLpuCE0FQ@mail.gmail.com>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org> <1483102054-1752-20-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:34532 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422980AbdAIS0G (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jan 2017 13:26:06 -0500
Received: by mail-qt0-f171.google.com with SMTP id l7so94807079qtd.1
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jan 2017 10:26:06 -0800 (PST)
In-Reply-To: <1483102054-1752-20-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

On Fri, Dec 30, 2016 at 1:47 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> A significant amount of functions and other definitions are available
> through the public mmc card.h header file. Let's slim down this public mmc
> interface, as to prevent users from abusing it, by moving some of the
> functions/definitions to private mmc header files.
>
> This change concentrates on moving the functions into private mmc headers,
> following changes may continue with additional clean-ups.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
