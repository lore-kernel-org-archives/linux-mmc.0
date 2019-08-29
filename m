From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RESEND PATCH v2 0/5] a few fixes for sprd's sd host controller
Date: Thu, 29 Aug 2019 11:32:32 +0200
Message-ID: <CAPDyKFp_+YuPOjURiE0YhT0uotZi=P2sRVYNr3ejgZmrMaN=tA@mail.gmail.com>
References: <20190829014645.4479-1-zhang.lyra@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829014645.4479-1-zhang.lyra@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 29 Aug 2019 at 03:47, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> With this patch-set, both sd card and mmc can be setup.  This patch-set was
> verified on Unisoc's Whale2 and another mobile phone platform SC9863A.
>
> Changes from v1:
> - Added Reviewed-by and Tested-by of Baolin;
> - Added fixes tag for all patches in this series.
>
> Chunyan Zhang (5):
>   mmc: sdhci-sprd: fixed incorrect clock divider
>   mmc: sdhci-sprd: add get_ro hook function
>   mmc: sdhci-sprd: add SDHCI_QUIRK2_PRESET_VALUE_BROKEN
>   mms: sdhci-sprd: add SDHCI_QUIRK_BROKEN_CARD_DETECTION
>   mmc: sdhci-sprd: clear the UHS-I modes read from registers
>
>  drivers/mmc/host/sdhci-sprd.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>
> --
> 2.20.1
>

Thanks, but I amended the current applied patches, assuming the only
change change you did was to put the fixes tag on one single line (for
each patch).

Kind regards
Uffe
