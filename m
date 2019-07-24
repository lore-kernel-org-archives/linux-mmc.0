From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] memstick: r592: Use dev_get_drvdata
Date: Wed, 24 Jul 2019 16:08:23 +0200
Message-ID: <CAPDyKFpThB0Ktyp5a=ZrLST=VvztbGEvdHr1HHzouOa23+nN0w@mail.gmail.com>
References: <20190723115044.18591-1-hslester96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190723115044.18591-1-hslester96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chuhong Yuan <hslester96@gmail.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 23 Jul 2019 at 13:50, Chuhong Yuan <hslester96@gmail.com> wrote:
>
> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/memstick/host/r592.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
> index 2932f421b3ea..dd3a1f3dcc19 100644
> --- a/drivers/memstick/host/r592.c
> +++ b/drivers/memstick/host/r592.c
> @@ -847,8 +847,7 @@ static void r592_remove(struct pci_dev *pdev)
>  #ifdef CONFIG_PM_SLEEP
>  static int r592_suspend(struct device *core_dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(core_dev);
> -       struct r592_device *dev = pci_get_drvdata(pdev);
> +       struct r592_device *dev = dev_get_drvdata(core_dev);
>
>         r592_clear_interrupts(dev);
>         memstick_suspend_host(dev->host);
> @@ -858,8 +857,7 @@ static int r592_suspend(struct device *core_dev)
>
>  static int r592_resume(struct device *core_dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(core_dev);
> -       struct r592_device *dev = pci_get_drvdata(pdev);
> +       struct r592_device *dev = dev_get_drvdata(core_dev);
>
>         r592_clear_interrupts(dev);
>         r592_enable_device(dev, false);
> --
> 2.20.1
>
