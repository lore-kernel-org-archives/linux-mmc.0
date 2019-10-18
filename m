From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC] mmc: cqhci: commit descriptors before setting the doorbell
Date: Fri, 18 Oct 2019 12:58:30 +0200
Message-ID: <CAPDyKFqbRNXaNVEACFQkKEymaY=Jm8L65-Ne_LbAmqFUkY1zcw@mail.gmail.com>
References: <20191014183849.14864-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191014183849.14864-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Asutosh Das <asutoshd@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, 14 Oct 2019 at 20:37, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Add a write memory barrier to make sure that descriptors are actually
> written to memory before ringing the doorbell.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Applied for fixes and by adding a stable tag, thanks!

BTW, do you have a valid commit that it fixes?

Kind regards
Uffe


> ---
>
> This patch fixes a very infrequent ADMA error (1 out of 100 times) that
> I have been seeing after enabling command queuing for J721e.
> Also looking at memory-barriers.txt and this commit[1],
> it looks like we should be doing this before any descriptor write
> followed by a doorbell ring operation. It'll be nice if someone with more
> expertise in memory barriers can comment.
>
> [1] ad1a1b9cd67a ("scsi: ufs: commit descriptors before setting the
>     doorbell")
>
>  drivers/mmc/host/cqhci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index f7bdae5354c3..5047f7343ffc 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -611,7 +611,8 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         cq_host->slot[tag].flags = 0;
>
>         cq_host->qcnt += 1;
> -
> +       /* Make sure descriptors are ready before ringing the doorbell */
> +       wmb();
>         cqhci_writel(cq_host, 1 << tag, CQHCI_TDBR);
>         if (!(cqhci_readl(cq_host, CQHCI_TDBR) & (1 << tag)))
>                 pr_debug("%s: cqhci: doorbell not set for tag %d\n",
> --
> 2.19.2
>
