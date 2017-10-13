From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCHv3 1/1] mmc: core: export emmc revision
Date: Fri, 13 Oct 2017 14:38:55 +0200
Message-ID: <CACRpkdYyvr2TNeXxq8sq9KBGzA7m=y9Cik_32QrW6DcAxp3C4w@mail.gmail.com>
References: <20171012174703.44680-1-jinqian@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171012174703.44680-1-jinqian@android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jin Qian <jinqian@android.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jin Qian <jinqian@google.com>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Uri Yanai <uri.yanai@sandisk.com>, Chanho Min <chanho.min@lge.com>, Jungseung Lee <js07.lee@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Oct 12, 2017 at 7:46 PM, Jin Qian <jinqian@android.com> wrote:

> From: Jin Qian <jinqian@google.com>
>
> Expose emmc revision as part of device attributes.
>
> Signed-off-by: Jin Qian <jinqian@android.com>
(...)

> +MMC_DEV_ATTR(rev, "0x%x\n", card->ext_csd.rev);

This will be 0x0000 on ordinary MMC cards right?

Have you tested it?

Yours,
Linus Walleij
