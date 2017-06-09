From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 9/9] mmc: core: Clarify code for sending CSD
Date: Fri, 9 Jun 2017 15:33:18 +0200
Message-ID: <CACRpkdZ+CeZHdvLXiBCSQ2zOA4SQwx7VQeJwtRdrjUOez4c29w@mail.gmail.com>
References: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org> <1496928465-25004-10-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:38858 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbdFINdU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2017 09:33:20 -0400
Received: by mail-it0-f41.google.com with SMTP id r63so31871567itc.1
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jun 2017 06:33:19 -0700 (PDT)
In-Reply-To: <1496928465-25004-10-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

On Thu, Jun 8, 2017 at 3:27 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> To make the code more consistent and to increase readability, add an
> mmc_spi_send_csd() function, which gets called from mmc_send_csd() in case
> of SPI mode.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
