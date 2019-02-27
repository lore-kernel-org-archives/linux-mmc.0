From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/2] mmc: cqhci: fix space allocated for transfer descriptor
Date: Wed, 27 Feb 2019 15:11:04 +0100
Message-ID: <CAPDyKFo05Nh0O42oRgW5qN6U2eWFX4-kVZUmUdTcbPmcxRNeUw@mail.gmail.com>
References: <20190225192214.3881-1-alamy.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190225192214.3881-1-alamy.liu@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Alamy Liu <alamy.liu@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Asutosh Das <asutoshd@codeaurora.org>, Ritesh Harjani <riteshh@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 25 Feb 2019 at 20:22, Alamy Liu <alamy.liu@gmail.com> wrote:
>
> There is not enough space being allocated when DCMD is disabled.
>
> CQE_DCMD is not necessary to be enabled when CQE is enabled.
> (Software could halt CQE to send command)
>
> In the case that CQE_DCMD is not enabled, it still needs to allocate
> space for data transfer. For instance:
>   CQE_DCMD is enabled:  31 slots space (one slot used by DCMD)
>   CQE_DCMD is disabled: 32 slots space
>
> Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
> Signed-off-by: Alamy Liu <alamy.liu@gmail.com>

Applied for fixes and added a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cqhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index 4cc7863c13..974997b6cb 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -202,7 +202,7 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
>         cq_host->desc_size = cq_host->slot_sz * cq_host->num_slots;
>
>         cq_host->data_size = cq_host->trans_desc_len * cq_host->mmc->max_segs *
> -               (cq_host->num_slots - 1);
> +               cq_host->mmc->cqe_qdepth;
>
>         pr_debug("%s: cqhci: desc_size: %zu data_sz: %zu slot-sz: %d\n",
>                  mmc_hostname(cq_host->mmc), cq_host->desc_size, cq_host->data_size,
> --
> 2.17.1
>
