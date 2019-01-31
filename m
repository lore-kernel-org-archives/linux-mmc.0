From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V11 3/4] mmc: sdhci: Add ADMA3 DMA support for V4 enabled host
Date: Thu, 31 Jan 2019 08:28:04 +0100
Message-ID: <CAPDyKFpZ1Y+n58v4SrHgJWeKv-JLT59-xSNzSLwWNhsohBWNYQ@mail.gmail.com>
References: <1548271854-1765-1-git-send-email-skomatineni@nvidia.com> <1548271854-1765-3-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548271854-1765-3-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mikko Perttunen <mperttunen@nvidia.com>, Chunyan Zhang <chunyan.zhang@unisoc.com>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, anrao@nvidia.com, DTML <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 23 Jan 2019 at 20:31, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> Below are the supported DMA types in Host Control1 Register
> with Version 4 enable
> b'00 - SDMA
> b'01 - Not Used
> b'10 - ADMA2
> b'11 - ADMA2 or ADMA3
>
> ADMA3 uses Command Descriptor to issue an SD command.
> A multi-block data transfer is performed by using a pair of CMD
> descriptor and ADMA2 descriptor.
>
> ADMA3 performs multiple of multi-block data transfer by using
> Integrated Descriptor which is more suitable for Command Queuing
> to fetch both Command and Transfer descriptors.
>
> Host Capabilities register indicates the supports of ADMA3 DMA.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Thierry Reding <treding@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  [V11]: Fixed typo in commit message of this patch.
>  [V10]: Changes are same as V9 except this series has SDHCI core changes
>         into seperate patch
>
>  drivers/mmc/host/sdhci.c | 9 ++++++++-
>  drivers/mmc/host/sdhci.h | 2 ++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a22e11a65658..c6afe793399e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3353,7 +3353,14 @@ void sdhci_cqe_enable(struct mmc_host *mmc)
>
>         ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>         ctrl &= ~SDHCI_CTRL_DMA_MASK;
> -       if (host->flags & SDHCI_USE_64_BIT_DMA)
> +       /*
> +        * Host from V4.10 supports ADMA3 DMA type.
> +        * ADMA3 performs integrated descriptor which is more suitable
> +        * for cmd queuing to fetch both command and transfer descriptors.
> +        */
> +       if (host->v4_mode && (host->caps1 & SDHCI_CAN_DO_ADMA3))
> +               ctrl |= SDHCI_CTRL_ADMA3;
> +       else if (host->flags & SDHCI_USE_64_BIT_DMA)
>                 ctrl |= SDHCI_CTRL_ADMA64;
>         else
>                 ctrl |= SDHCI_CTRL_ADMA32;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 6cc9a3c2ac66..4070be49d947 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -88,6 +88,7 @@
>  #define   SDHCI_CTRL_ADMA1     0x08
>  #define   SDHCI_CTRL_ADMA32    0x10
>  #define   SDHCI_CTRL_ADMA64    0x18
> +#define   SDHCI_CTRL_ADMA3     0x18
>  #define   SDHCI_CTRL_8BITBUS   0x20
>  #define  SDHCI_CTRL_CDTEST_INS 0x40
>  #define  SDHCI_CTRL_CDTEST_EN  0x80
> @@ -230,6 +231,7 @@
>  #define  SDHCI_RETUNING_MODE_SHIFT             14
>  #define  SDHCI_CLOCK_MUL_MASK  0x00FF0000
>  #define  SDHCI_CLOCK_MUL_SHIFT 16
> +#define  SDHCI_CAN_DO_ADMA3    0x08000000
>  #define  SDHCI_SUPPORT_HS400   0x80000000 /* Non-standard */
>
>  #define SDHCI_CAPABILITIES_1   0x44
> --
> 2.7.4
>
