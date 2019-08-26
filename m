From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 0/5] a few fixes for sprd's sd host controller
Date: Mon, 26 Aug 2019 13:56:44 +0800
Message-ID: <CAMz4ku+o9KiqV4fJ17v4JwQCaTSxz1F6e+FBOnDssaVg1HztVw@mail.gmail.com>
References: <20190826031830.30931-1-zhang.lyra@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190826031830.30931-1-zhang.lyra@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Orson Zhai <orsonzhai@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 26 Aug 2019 at 11:18, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> With this patch-set, both sd card and mmc can be setup.  This patch-set was
> verified on Unisoc's Whale2 and another mobile phone platform SC9863A.

Tested on my board, so for the whole patch set.
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Baolin Wang <baolin.wang@linaro.org>

> Chunyan Zhang (5):
>   mmc: sdhci-sprd: fixed incorrect clock divider
>   mmc: sdhci: sprd: add get_ro hook function
>   mmc: sdhci: sprd: add SDHCI_QUIRK2_PRESET_VALUE_BROKEN
>   mms: sdhci: sprd: add SDHCI_QUIRK_BROKEN_CARD_DETECTION
>   mmc: sdhci: sprd: clear the UHS-I modes read from registers
>
>  drivers/mmc/host/sdhci-sprd.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>
> --
> 2.20.1
>


-- 
Baolin Wang
Best Regards
