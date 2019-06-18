From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 3/3] mmc: sdhci: Fix indenting on SDHCI_CTRL_8BITBUS
Date: Tue, 18 Jun 2019 13:40:49 +0200
Message-ID: <CAPDyKFr8=W9PYEYB7DuKisBVZ4nTF5ibJN5_OqoEPPbRURTWtA@mail.gmail.com>
References: <20190617201014.84503-1-rrangel@chromium.org> <20190617201014.84503-3-rrangel@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190617201014.84503-3-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Raul E Rangel <rrangel@chromium.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "ernest.zhang" <ernest.zhang@bayhubtech.com>, Daniel Kurtz <djkurtz@chromium.org>, Adrian Hunter <adrian.hunter@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 17 Jun 2019 at 22:10, Raul E Rangel <rrangel@chromium.org> wrote:
>
> Remove whitespace in front of SDHCI_CTRL_8BITBUS. The value is not part
> of SDHCI_CTRL_DMA_MASK.
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


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
> 2.22.0.410.gd8fdbe21b5-goog
>
