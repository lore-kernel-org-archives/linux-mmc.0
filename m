From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 08/21] mmc: sdhci-cadence: Include mmc.h
Date: Mon, 9 Jan 2017 16:14:18 +0100
Message-ID: <CACRpkdaq-N0N+45PizEdQ2b11er_nHifqfWRahh_AMrcgvLEFQ@mail.gmail.com>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org> <1483102054-1752-9-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36226 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968189AbdAIPOT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jan 2017 10:14:19 -0500
Received: by mail-qk0-f171.google.com with SMTP id 11so44812852qkl.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jan 2017 07:14:19 -0800 (PST)
In-Reply-To: <1483102054-1752-9-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>

On Fri, Dec 30, 2016 at 1:47 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Don't rely on host.h to include the mmc.h header, but instead include it
> explicitly because the driver depends on it.
>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
