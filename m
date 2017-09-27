From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2 v6] mmc: block: Convert RPMB to a character device
Date: Wed, 27 Sep 2017 21:45:58 +0200
Message-ID: <CACRpkdabXNgCz+mtOOAZR1OqbCT0VgpxKT=FPh_99DTnsnCcSQ@mail.gmail.com>
References: <20170920080201.32438-1-linus.walleij@linaro.org> <b4a75994-1556-56ac-499c-8527988ee70f@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <b4a75994-1556-56ac-499c-8527988ee70f@intel.com>
Sender: linux-block-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>, Avri Altman <Avri.Altman@sandisk.com>, Tomas Winkler <tomas.winkler@intel.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Sep 27, 2017 at 1:35 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> BUG when removing, fixed by reverting this patch.
>
> [  346.548512] mmc1: card 0001 removed
> [  346.552782] BUG: unable to handle kernel NULL pointer dereference at 0000000000000070

How did you achieve this? I need to reproduce it.

RPMB is only available on eMMC cards and I don't have a removable eMMC
card since by definition they are soldered on.

Does it happen on an ordinary MMC card without RPMB?

I'm sorry if I'm ignorant of something very obvious here...

I will read the code and see if I'm missing something obvious.

Yours,
Linus Walleij
