From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: 4.13 on thinkpad x220: oops when writing to SD card
Date: Thu, 7 Sep 2017 21:58:31 +0200
Message-ID: <CACRpkdYt_b72zFA6Oqg5rcaqPnz=knr7DWnXp-pjz3gpf89THw@mail.gmail.com>
References: <20170905194739.GA31241@amd> <8f0f7310-ea4d-a200-75fd-23509947fb38@rock-chips.com>
 <6689241f-a4d8-7a3e-9f0b-482b034e5710@intel.com> <CAPDyKFqXaDFrJH1-YSSCx0xPXfMN99AM_Wu_sWQf5A6bw+zjdQ@mail.gmail.com>
 <f36b194b-f74b-20de-3122-0243774b74c2@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35094 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752375AbdIGT6c (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Sep 2017 15:58:32 -0400
Received: by mail-oi0-f49.google.com with SMTP id z73so970006oia.2
        for <linux-mmc@vger.kernel.org>; Thu, 07 Sep 2017 12:58:31 -0700 (PDT)
In-Reply-To: <f36b194b-f74b-20de-3122-0243774b74c2@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Pavel Machek <pavel@ucw.cz>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Seraphime Kirkovski <kirkseraph@gmail.com>

On Thu, Sep 7, 2017 at 9:53 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> From: Adrian Hunter <adrian.hunter@intel.com>
> Date: Thu, 7 Sep 2017 10:40:35 +0300
> Subject: [PATCH] mmc: block: Fix incorrectly initialized requests
>
> mmc_init_request() depends on card->bouncesz so it must be calculated
> before blk_init_allocated_queue() starts allocating requests.
>
> Reported-by: Seraphime Kirkovski <kirkseraph@gmail.com>
> Fixes: 304419d8a7e92 ("mmc: core: Allocate per-request data using the block layer core")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Really neat and quick fix, thanks a lot Adrian.

My fault for not finding more systems actually *using* these
bounce buffers. :( :(

Yours,
Linus Walleij
