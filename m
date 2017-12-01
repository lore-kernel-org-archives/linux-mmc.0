From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: Avoid swiotlb buffer being full
Date: Fri, 1 Dec 2017 11:01:45 +0100
Message-ID: <CACRpkdabdijCiy4CV23erUKwaTT1pQOJKMjPuv6BFrd-MC8vLQ@mail.gmail.com>
References: <1511778530-6761-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1511778530-6761-1-git-send-email-ulf.hansson@linaro.org>
Sender: stable-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Linus <torvalds@linux-foundation.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Konrad Rzeszutek Wilk <konrad@kernel.org>, Jiri Slaby <jslaby@suse.cz>, "# v4 . 14+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Nov 27, 2017 at 11:28 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The commit de3ee99b097d ("mmc: Delete bounce buffer handling") deletes the
> bounce buffer handling, but also causes the max_req_size for sdhci to be
> increased, in case when max_segs == 1. This causes errors for sdhci-pci
> Ricoh variant, about the swiotlb buffer to become full.
>
> Fix the issue, by taking IO_TLB_SEGSIZE and IO_TLB_SHIFT into account when
> deciding the max_req_size for sdhci.
>
> Reported-by: Jiri Slaby <jslaby@suse.cz>
> Fixes: de3ee99b097d ("mmc: Delete bounce buffer handling")
> Cc: <stable@vger.kernel.org> # v4.14+
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Tested-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thank you for fixing my screwups :/

Yours,
Linus Walleij
