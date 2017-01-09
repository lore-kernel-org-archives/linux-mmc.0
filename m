From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 7/8] mmc-core: Use kcalloc() in mmc_test_alloc_mem()
Date: Mon, 9 Jan 2017 19:36:36 +0100
Message-ID: <CACRpkdb+DhRbZnRR6BxYVU67mrGg12kURV=AOVM62g9=2oRMfA@mail.gmail.com>
References: <8e2accf5-90b3-6bd0-2abd-699927bc459b@users.sourceforge.net> <304ae7a7-bc51-83d7-2a6b-844cdf4c346f@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <304ae7a7-bc51-83d7-2a6b-844cdf4c346f@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Harjani Ritesh <riteshh@codeaurora.org>, Jens Axboe <axboe@fb.com>, Mike Christie <mchristi@redhat.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Sun, Jan 8, 2017 at 10:50 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 8 Jan 2017 21:43:12 +0100
>
> * The script "checkpatch.pl" pointed information out like the following.
>
>   WARNING: Prefer kcalloc over kzalloc with multiply
>
>   Thus fix the affected source code place.
>
> * Replace the specification of a data structure by a pointer dereference
>   to make the corresponding size determination a bit safer according to
>   the Linux coding style convention.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
