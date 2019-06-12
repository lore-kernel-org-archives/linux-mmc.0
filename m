From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] mmc: sdhci: Fix indenting on SDHCI_CTRL_8BITBUS
Date: Wed, 12 Jun 2019 15:42:50 +0200
Message-ID: <CAPDyKFo9U7ChoEQC1QFaW9cXLYQ-Q2UrYyH0KqJd_reyka3zvw@mail.gmail.com>
References: <20190610185354.35310-1-rrangel@chromium.org> <20190610185354.35310-3-rrangel@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610185354.35310-3-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Raul E Rangel <rrangel@chromium.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "ernest.zhang" <ernest.zhang@bayhubtech.com>, Daniel Kurtz <djkurtz@chromium.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, 10 Jun 2019 at 20:55, Raul E Rangel <rrangel@chromium.org> wrote:
>
> The value is referring to SDHCI_HOST_CONTROL, not SDHCI_CTRL_DMA_MASK.

Perhaps re-phrase this changelog as to mention that you are removing a
white-space to fix alignment, as that was not so obvious.

Kind regards
Uffe

>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
>
>  drivers/mmc/host/sdhci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 199712e7adbb3..89fd96596a1f7 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -89,7 +89,7 @@
>  #define   SDHCI_CTRL_ADMA32    0x10
>  #define   SDHCI_CTRL_ADMA64    0x18
>  #define   SDHCI_CTRL_ADMA3     0x18
> -#define   SDHCI_CTRL_8BITBUS   0x20
> +#define  SDHCI_CTRL_8BITBUS    0x20
>  #define  SDHCI_CTRL_CDTEST_INS 0x40
>  #define  SDHCI_CTRL_CDTEST_EN  0x80
>
> --
> 2.22.0.rc2.383.gf4fbbf30c2-goog
>
