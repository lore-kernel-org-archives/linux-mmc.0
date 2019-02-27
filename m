From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/2] mmc: cqhci: Fix a tiny potential memory leak on
 error condition
Date: Wed, 27 Feb 2019 15:11:08 +0100
Message-ID: <CAPDyKFqOgFMH3r8svC--fy88g5geuxGFMZ7VTYGfPGY7C3C9OA@mail.gmail.com>
References: <20190225192214.3881-1-alamy.liu@gmail.com> <20190225192214.3881-2-alamy.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190225192214.3881-2-alamy.liu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alamy Liu <alamy.liu@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Asutosh Das <asutoshd@codeaurora.org>, Ritesh Harjani <riteshh@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 25 Feb 2019 at 20:22, Alamy Liu <alamy.liu@gmail.com> wrote:
>
> Free up the allocated memory in the case of error return
>
> --- code study ---

Using three dashes makes "git am" believe this hole text snippet is a
comment and drops it from the changelog. I fixed it up this time, no
worries.

> The value of mmc_host->cqe_enabled stays 'false'.
> Thus, cqhci_disable (mmc_cqe_ops->cqe_disable) won't be called to
> free the memory.
> Also, cqhci_disable() seems to be designed to disable and free
> all resources, not suitable to handle this corner case.
>
> Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
> Signed-off-by: Alamy Liu <alamy.liu@gmail.com>

Applied for fixes and added a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cqhci.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index 974997b6cb..795893ba47 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -218,12 +218,21 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
>                                                  cq_host->desc_size,
>                                                  &cq_host->desc_dma_base,
>                                                  GFP_KERNEL);
> +       if (!cq_host->desc_base)
> +               return -ENOMEM;
> +
>         cq_host->trans_desc_base = dmam_alloc_coherent(mmc_dev(cq_host->mmc),
>                                               cq_host->data_size,
>                                               &cq_host->trans_desc_dma_base,
>                                               GFP_KERNEL);
> -       if (!cq_host->desc_base || !cq_host->trans_desc_base)
> +       if (!cq_host->trans_desc_base) {
> +               dmam_free_coherent(mmc_dev(cq_host->mmc), cq_host->desc_size,
> +                                  cq_host->desc_base,
> +                                  cq_host->desc_dma_base);
> +               cq_host->desc_base = NULL;
> +               cq_host->desc_dma_base = 0;
>                 return -ENOMEM;
> +       }
>
>         pr_debug("%s: cqhci: desc-base: 0x%p trans-base: 0x%p\n desc_dma 0x%llx trans_dma: 0x%llx\n",
>                  mmc_hostname(cq_host->mmc), cq_host->desc_base, cq_host->trans_desc_base,
> --
> 2.17.1
>
