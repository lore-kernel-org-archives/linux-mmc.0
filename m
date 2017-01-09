From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 10/21] mmc: host: Include interrupt.h in mmc host drivers
 that depends on it
Date: Mon, 9 Jan 2017 16:18:46 +0100
Message-ID: <CACRpkdYQU0AJDqZyiN+g7zWK8hVBA-sJ-v9Dijd+DFGwObYHCA@mail.gmail.com>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org> <1483102054-1752-11-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:35919 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969953AbdAIPSr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jan 2017 10:18:47 -0500
Received: by mail-qt0-f181.google.com with SMTP id k15so367995379qtg.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jan 2017 07:18:47 -0800 (PST)
In-Reply-To: <1483102054-1752-11-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

On Fri, Dec 30, 2016 at 1:47 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> An mmc host driver shouldn't rely on interrupt.h being included by another
> public mmc header. Instead make that dependency explicit by including
> interrupt.h in those host drivers that depends on it.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
