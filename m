From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/8] mmc-core: Use kmalloc_array() in mmc_test_area_init()
Date: Mon, 9 Jan 2017 19:31:42 +0100
Message-ID: <CACRpkdbO2_fRDuuEV-aJCL7X=m7Zads=M-N_75OqBdz66YYqHA@mail.gmail.com>
References: <8e2accf5-90b3-6bd0-2abd-699927bc459b@users.sourceforge.net> <a9b14d1d-de5c-5a22-fcd0-021d7b01cb36@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <a9b14d1d-de5c-5a22-fcd0-021d7b01cb36@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Harjani Ritesh <riteshh@codeaurora.org>, Jens Axboe <axboe@fb.com>, Mike Christie <mchristi@redhat.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Sun, Jan 8, 2017 at 10:42 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 8 Jan 2017 18:44:26 +0100
>
> * A multiplication for the size determination of a memory allocation
>   indicated that an array data structure should be processed.
>   Thus use the corresponding function "kmalloc_array".
>
>   This issue was detected by using the Coccinelle software.
>
> * Replace the specification of a data structure by a pointer dereference
>   to make the corresponding size determination a bit safer according to
>   the Linux coding style convention.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Chunyan has been running this test code so she might have additional
insights to provide. I am not aware about anyone else really running the
tests, are there people who do it?

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
