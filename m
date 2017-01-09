From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 14/21] mmc: core: Move some host specific public functions
 to host.h
Date: Mon, 9 Jan 2017 19:21:16 +0100
Message-ID: <CACRpkdYy+A4shtiJMkjFC356zp_1w7P++LYw30CJabnuwyAc2Q@mail.gmail.com>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org> <1483102054-1752-15-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36487 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031638AbdAISVR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jan 2017 13:21:17 -0500
Received: by mail-qk0-f174.google.com with SMTP id 11so51006002qkl.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jan 2017 10:21:17 -0800 (PST)
In-Reply-To: <1483102054-1752-15-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

On Fri, Dec 30, 2016 at 1:47 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Ideally the public mmc header file, core.h, shouldn't contain interfaces
> particularly intended to be used by host drivers. Instead those should
> remain in the host.h header file. Therefore, let's move a couple functions
> from core.h to host.h.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
