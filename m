From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 7/9] mmc: core: Re-factor code for sending CID
Date: Fri, 9 Jun 2017 15:32:27 +0200
Message-ID: <CACRpkdZsi67jN3BqM+SCju1Lns6AnDUFXU3vhhUxzcdrX2EcwA@mail.gmail.com>
References: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org> <1496928465-25004-8-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:34262 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbdFINc3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2017 09:32:29 -0400
Received: by mail-io0-f182.google.com with SMTP id i7so33054810ioe.1
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jun 2017 06:32:29 -0700 (PDT)
In-Reply-To: <1496928465-25004-8-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

On Thu, Jun 8, 2017 at 3:27 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Instead of having the caller to check for SPI mode, let's leave that to
> internals of mmc_send_cid(). In this way the code gets cleaner and it
> becomes clear what is specific to SPI and non-SPI mode.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
