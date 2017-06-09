From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4/9] mmc: core: Move mmc_flush_cache() from core.c to mmc_ops.c
Date: Fri, 9 Jun 2017 15:25:22 +0200
Message-ID: <CACRpkdaaM+2-z6VuXLn2esirFH9b-3BWZDLaBPcS_Rf7p3R02g@mail.gmail.com>
References: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org> <1496928465-25004-5-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:34592 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751535AbdFINZe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2017 09:25:34 -0400
Received: by mail-io0-f173.google.com with SMTP id i7so32966825ioe.1
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jun 2017 06:25:34 -0700 (PDT)
In-Reply-To: <1496928465-25004-5-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

On Thu, Jun 8, 2017 at 3:27 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The mmc_flush_cache() is a eMMC specific function, let's move it to
> mmc_ops.c to make that clear.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
