From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: cqhci: replace NUM_SLOTS with cq_host->num_slots
Date: Mon, 28 Jan 2019 12:38:16 +0100
Message-ID: <CAPDyKFp1fAJK3_XWcwcC4oLAJWvXnt=MvHcZz4X2PMojWPDmWg@mail.gmail.com>
References: <20190114191724.29960-1-alamy.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114191724.29960-1-alamy.liu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alamy Liu <alamy.liu@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

+ Adrian (the SDHCI maintainer)

On Mon, 14 Jan 2019 at 20:17, Alamy Liu <alamy.liu@gmail.com> wrote:
>
> Prevent to use fixed value (NUM_SLOTS) after it had been determined
> and saved in a variable (cq_host->num_slots).
>
> Signed-off-by: Alamy Liu <alamy.liu@gmail.com>
> ---
>  drivers/mmc/host/cqhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index 159270e947..26d63594b7 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -699,7 +699,7 @@ static void cqhci_error_irq(struct mmc_host *mmc, u32 status, int cmd_error,
>                  * The only way to guarantee forward progress is to mark at
>                  * least one task in error, so if none is indicated, pick one.
>                  */
> -               for (tag = 0; tag < NUM_SLOTS; tag++) {
> +               for (tag = 0; tag < cq_host->num_slots; tag++) {
>                         slot = &cq_host->slot[tag];
>                         if (!slot->mrq)
>                                 continue;
> --
> 2.17.1
>

Alamy, I realized that you haven't included Adrian when posted your
recent sdhci patches. Please re-post all of them so we can get
Adrian's input.

Kind regards
Uffe
