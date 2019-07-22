From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: host: sdhci-sprd: Fix the missing pm_runtime_put_noidle()
Date: Mon, 22 Jul 2019 15:41:47 +0200
Message-ID: <CAPDyKFrykZ3TGvHjmf+AYZ=DQB+_HPjMf+s5QWUC+oNHErX=6w@mail.gmail.com>
References: <7bff392d44bf32e9e762ef6e3b53df0d95c22c91.1563184567.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7bff392d44bf32e9e762ef6e3b53df0d95c22c91.1563184567.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 15 Jul 2019 at 12:00, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> When the SD host controller tries to probe again due to the derferred
> probe mechanism, it will always keep the SD host device as runtime
> resume state due to missing the runtime put operation in error path
> last time.
>
> Thus add the pm_runtime_put_noidle() in error path to make the PM runtime
> counter balance, which can make the SD host device's PM runtime work well.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Applied for fixes and by adding a fixes/stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-sprd.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 6ee340a..603a5d9 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -624,6 +624,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>         sdhci_cleanup_host(host);
>
>  pm_runtime_disable:
> +       pm_runtime_put_noidle(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
>         pm_runtime_set_suspended(&pdev->dev);
>
> --
> 1.7.9.5
>
