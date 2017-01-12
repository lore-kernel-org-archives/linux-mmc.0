From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/8] MMC-core: Fine-tuning for some function implementations
Date: Thu, 12 Jan 2017 13:01:13 +0100
Message-ID: <CAPDyKFpTGon_ejUVWQPMHvR5vS7Zg7WGAESgZ9QnCULAMokXvg@mail.gmail.com>
References: <8e2accf5-90b3-6bd0-2abd-699927bc459b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8e2accf5-90b3-6bd0-2abd-699927bc459b@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Harjani Ritesh <riteshh@codeaurora.org>, Jens Axboe <axboe@fb.com>, Linus Walleij <linus.walleij@linaro.org>, Mike Christie <mchristi@redhat.com>, Shawn Lin <shawn.lin@rock-chips.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 8 January 2017 at 22:38, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 8 Jan 2017 22:30:03 +0100
>
> Some update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (8):
>   Use kmalloc_array() in mmc_test_area_init()
>   Fix a typo in a comment line
>   Use seq_puts() in mtf_testlist_show()
>   mmc_test: Add some spaces for better code readability
>   mmc_test: Combine substrings for 5 messages
>   mmc_test: Improve a size determination in five functions
>   Use kcalloc() in mmc_test_alloc_mem()
>   Use kmalloc_array() in mmc_alloc_sg()
>
>  drivers/mmc/core/mmc_test.c | 77 +++++++++++++++++++++------------------------
>  drivers/mmc/core/queue.c    |  2 +-
>  2 files changed, 36 insertions(+), 43 deletions(-)
>

Thanks applied for next, with some changes to the prefix of the commit
message headers.

Kind regards
Uffe
