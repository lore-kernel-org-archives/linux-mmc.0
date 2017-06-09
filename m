From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 6/9] mmc: core: Remove redundant code in mmc_send_cid()
Date: Fri, 9 Jun 2017 15:29:12 +0200
Message-ID: <CACRpkdbhweB9d6ka3Ka+kR=uAg2t3kn7P2+dyhkcY=NVPcU8jw@mail.gmail.com>
References: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org> <1496928465-25004-7-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:35669 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751590AbdFIN3Q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2017 09:29:16 -0400
Received: by mail-it0-f53.google.com with SMTP id m62so136856430itc.0
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jun 2017 06:29:15 -0700 (PDT)
In-Reply-To: <1496928465-25004-7-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

On Thu, Jun 8, 2017 at 3:27 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The mmc_send_cid() is never called using non SPI mode. Thus, let's remove
> the redundant code dealing with this.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
