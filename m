From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: block: Fix cmd error reset failure path
Date: Mon, 27 Feb 2017 15:08:40 +0100
Message-ID: <CACRpkdZMZFpSK7e3OSZFqFYmX1AR9bRq24AFeGY8Udu+XD3wAw@mail.gmail.com>
References: <558473bd-9fea-6f95-4eb1-9d72b5a25234@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:36931 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbdB0OIt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Feb 2017 09:08:49 -0500
Received: by mail-it0-f50.google.com with SMTP id 203so65752072ith.0
        for <linux-mmc@vger.kernel.org>; Mon, 27 Feb 2017 06:08:41 -0800 (PST)
In-Reply-To: <558473bd-9fea-6f95-4eb1-9d72b5a25234@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Mon, Feb 27, 2017 at 8:36 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Commit 4e1f780032c5 ("mmc: block: break out mmc_blk_rw_cmd_abort()")
> assumed the request had not completed, but in one case it had. Fix that.
>
> Fixes: 4e1f780032c5 ("mmc: block: break out mmc_blk_rw_cmd_abort()")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Ouch.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
