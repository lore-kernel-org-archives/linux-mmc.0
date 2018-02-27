From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: Avoid accessing registers in runtime
 suspended state
Date: Tue, 27 Feb 2018 12:27:47 +0100
Message-ID: <CAPDyKFpEjCwfcX6HwiBJceCzyRtJw4fGb_BvuKRQSOD_=TKtVg@mail.gmail.com>
References: <1519375646-146695-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1519375646-146695-1-git-send-email-shawn.lin@rock-chips.com>
Sender: stable-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 23 February 2018 at 09:47, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> cat /sys/kernel/debug/mmc0/regs will hang up the system since
> it's in runtime suspended state, so the genpd and biu_clk is
> off. This patch fixes this problem by calling pm_runtime_get_sync
> to wake it up before reading the registers.
>
> Fixes: e9ed8835e990 ("mmc: dw_mmc: add runtime PM callback")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied fixes!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/dw_mmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 0aa3997..e38dcf4 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -165,6 +165,8 @@ static int dw_mci_regs_show(struct seq_file *s, void *v)
>  {
>         struct dw_mci *host = s->private;
>
> +       pm_runtime_get_sync(host->dev);
> +
>         seq_printf(s, "STATUS:\t0x%08x\n", mci_readl(host, STATUS));
>         seq_printf(s, "RINTSTS:\t0x%08x\n", mci_readl(host, RINTSTS));
>         seq_printf(s, "CMD:\t0x%08x\n", mci_readl(host, CMD));
> @@ -172,6 +174,8 @@ static int dw_mci_regs_show(struct seq_file *s, void *v)
>         seq_printf(s, "INTMASK:\t0x%08x\n", mci_readl(host, INTMASK));
>         seq_printf(s, "CLKENA:\t0x%08x\n", mci_readl(host, CLKENA));
>
> +       pm_runtime_put_autosuspend(host->dev);
> +
>         return 0;
>  }
>
> --
> 1.9.1
>
>
