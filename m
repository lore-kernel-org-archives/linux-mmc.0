From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 15/21] mmc: core: Move erase/trim/discard defines from
 public core.h to mmc.h
Date: Mon, 9 Jan 2017 19:22:11 +0100
Message-ID: <CACRpkdZOg+g8-d-Z9Hc0Zod37Z_WRQ_p12y--SU7pKWVd1WrNw@mail.gmail.com>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org> <1483102054-1752-16-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:34274 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031638AbdAISWM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jan 2017 13:22:12 -0500
Received: by mail-qt0-f182.google.com with SMTP id l7so94702571qtd.1
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jan 2017 10:22:12 -0800 (PST)
In-Reply-To: <1483102054-1752-16-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

On Fri, Dec 30, 2016 at 1:47 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> As the public mmc.h header already contains similar defines for other mmc
> commands and arguments, let's move those for erase/trim/discard into here
> as well.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
