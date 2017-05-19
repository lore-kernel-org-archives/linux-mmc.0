From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: atmel-mci: Delete an error message for a failed
 memory allocation in atmci_of_init()
Date: Fri, 19 May 2017 10:32:46 +0200
Message-ID: <CAPDyKFrgjdwd2Z_19GC1us+SA-4-sjNOnyFWsnPCzt=JGvtwNw@mail.gmail.com>
References: <199b33a2-6722-fba1-e7ec-5ac016c5bad0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <199b33a2-6722-fba1-e7ec-5ac016c5bad0@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-mmc@vger.kernel.org

On 13 May 2017 at 15:17, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 13 May 2017 15:05:28 +0200
>
> Omit an extra message for a memory allocation failure in this function.
>
> This issue was detected by using the Coccinelle software.
>
> Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thanks applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/atmel-mci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 388e4a3f13e6..584247464eb8 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -667,10 +667,8 @@ atmci_of_init(struct platform_device *pdev)
>         }
>
>         pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> -       if (!pdata) {
> -               dev_err(&pdev->dev, "could not allocate memory for pdata\n");
> +       if (!pdata)
>                 return ERR_PTR(-ENOMEM);
> -       }
>
>         for_each_child_of_node(np, cnp) {
>                 if (of_property_read_u32(cnp, "reg", &slot_id)) {
> --
> 2.12.3
>
