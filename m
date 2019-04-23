From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/4] mmc: mmci: avoid fake busy polling
Date: Tue, 23 Apr 2019 15:39:57 +0200
Message-ID: <CAPDyKFoZuQ+hshZpj-qjchKf7enW4ChPd=r_QhK2xtuJcSvqxQ@mail.gmail.com>
References: <1551802205-32188-1-git-send-email-ludovic.Barre@st.com> <1551802205-32188-2-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551802205-32188-2-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org

On Tue, 5 Mar 2019 at 17:10, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> The busy status bit could occurred even if no busy response is
> expected (example cmd11). On sdmmc variant, the busy_detect_flag
> reflects inverted value of d0 state, it's sampled at the end of a
> CMD response and a second time 2 clk cycles after the CMD response.
> To avoid a fake busy, the busy status could be checked and polled
> only if the command has RSP_BUSY flag.

I would appreciate a better explanation of what this patch really changes.

The above is giving some background to the behavior of sdmmc variant,
but at this point that variant doesn't even have the
->variant->busy_detect flag set.

>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 387ff14..4901b73 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1220,12 +1220,13 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>              unsigned int status)
>  {
>         void __iomem *base = host->base;
> -       bool sbc;
> +       bool sbc, busy_resp;
>
>         if (!cmd)
>                 return;
>
>         sbc = (cmd == host->mrq->sbc);
> +       busy_resp = !!(cmd->flags & MMC_RSP_BUSY);
>
>         /*
>          * We need to be one of these interrupts to be considered worth
> @@ -1239,8 +1240,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>         /*
>          * ST Micro variant: handle busy detection.
>          */
> -       if (host->variant->busy_detect) {
> -               bool busy_resp = !!(cmd->flags & MMC_RSP_BUSY);
> +       if (busy_resp && host->variant->busy_detect) {
>
>                 /* We are busy with a command, return */
>                 if (host->busy_status &&
> @@ -1253,7 +1253,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>                  * that the special busy status bit is still set before
>                  * proceeding.
>                  */
> -               if (!host->busy_status && busy_resp &&
> +               if (!host->busy_status &&
>                     !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
>                     (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {

All the changes above makes perfect sense to me, but looks more like a
cleanup of the code, rather than actually changing the behavior.

>
> @@ -1508,6 +1508,7 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>  {
>         struct mmci_host *host = dev_id;
>         u32 status;
> +       bool busy_resp;
>         int ret = 0;
>
>         spin_lock(&host->lock);
> @@ -1550,9 +1551,15 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>                 }
>
>                 /*
> -                * Don't poll for busy completion in irq context.
> +                * Don't poll for:
> +                * -busy completion in irq context.
> +                * -no busy response expected.
>                  */
> -               if (host->variant->busy_detect && host->busy_status)
> +               busy_resp = host->cmd ?
> +                       !!(host->cmd->flags & MMC_RSP_BUSY) : false;

This doesn't make sense to me, but I may be missing something.

host->busy_status is being updated by mmci_cmd_irq() and only when
MMC_RSP_BUSY is set for the command in flight. In other words,
checking for MMC_RSP_BUSY here as well is redundant. No?

> +
> +               if (host->variant->busy_detect &&
> +                   (!busy_resp || host->busy_status))
>                         status &= ~host->variant->busy_detect_flag;
>
>                 ret = 1;
> --
> 2.7.4
>

Kind regards
Uffe
