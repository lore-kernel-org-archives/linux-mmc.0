From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/2] mmc: sdhci: Add sdma_boundary to sdhci_host
Date: Tue, 8 Aug 2017 12:38:35 +0200
Message-ID: <CAPDyKFq5nGRqZQgYyp-UZZ-VbXTLNW3YseoDATh93JpDku4ibw@mail.gmail.com>
References: <20170803124614.21788-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170803124614.21788-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 3 August 2017 at 14:46,  <srinivas.kandagatla@linaro.org> wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patchset adds fix to support sdhci controller which have issues
> when sdma boundary buffer bits are programmed in Block Size Register (0x04)
> when using ADMA.
>
> First patch adds member to struct sdhci_host to allow drivers to
> specify sdma_buffer_boundary value that it can support and second
> one sets sdma_boundary to zero in msm sdhci driver.
>
> Tested on DB410c with WLAN SDIO card.
>
> thanks,
> srini
>
> Changes since v2:
>         - Chanaged local variable to fix line wrap.
>         - Changed sdma_buffer_boundary_arg to sdma_boundary suggested by Adrian
>
> Srinivas Kandagatla (2):
>   mmc: sdhci: add sdma_boundary member to struct sdhci_host
>   mmc: sdhci-msm: set sdma_boundary to zero
>
>  drivers/mmc/host/sdhci-msm.c |  1 +
>  drivers/mmc/host/sdhci.c     | 13 ++++++++-----
>  drivers/mmc/host/sdhci.h     |  3 +++
>  3 files changed, 12 insertions(+), 5 deletions(-)
>
> --
> 2.9.3
>

Thanks, applied for next!

Kind regards
Uffe
