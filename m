From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/8] mmc-core: Use seq_puts() in mtf_testlist_show()
Date: Mon, 9 Jan 2017 19:33:33 +0100
Message-ID: <CACRpkdbV1noZ9bLj5hzDpj7UsCbLfDa66sLK-3i7pLYm0=45GA@mail.gmail.com>
References: <8e2accf5-90b3-6bd0-2abd-699927bc459b@users.sourceforge.net> <5b8afe3b-0dee-0d95-c855-f0b93a95a072@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:36163 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753066AbdAISde (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jan 2017 13:33:34 -0500
Received: by mail-qt0-f171.google.com with SMTP id k15so373712282qtg.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jan 2017 10:33:34 -0800 (PST)
In-Reply-To: <5b8afe3b-0dee-0d95-c855-f0b93a95a072@users.sourceforge.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Harjani Ritesh <riteshh@codeaurora.org>, Jens Axboe <axboe@fb.com>, Mike Christie <mchristi@redhat.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Sun, Jan 8, 2017 at 10:45 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 8 Jan 2017 19:48:28 +0100
>
> The script "checkpatch.pl" pointed information out like the following.
>
> WARNING: Prefer seq_puts to seq_printf
>
> Thus fix the affected source code place.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
