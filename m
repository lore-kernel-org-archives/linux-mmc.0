From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 21/21] mmc: core: Don't use extern declarations of public
 mmc functions
Date: Mon, 9 Jan 2017 19:27:56 +0100
Message-ID: <CACRpkdaXC97DMvdzmPoH6XL_ubsR30=bE=ai69W4_9uoCsTRQA@mail.gmail.com>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org> <1483102054-1752-22-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:33179 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163274AbdAIS15 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jan 2017 13:27:57 -0500
Received: by mail-qt0-f181.google.com with SMTP id v23so143797362qtb.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jan 2017 10:27:57 -0800 (PST)
In-Reply-To: <1483102054-1752-22-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

On Fri, Dec 30, 2016 at 1:47 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Using extern when declaring functions in the public header, core.h, is
> redundant. Let's just remove the use of it.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

I only specify extern explicitly when declaring variables (like globals).
Good riddance.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
