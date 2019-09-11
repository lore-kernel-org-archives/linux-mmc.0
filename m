From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: hi3798cv200: make array degrees static
 const, makes object smaller
Date: Wed, 11 Sep 2019 16:21:10 +0200
Message-ID: <CAPDyKFqriNuywSzk-c77==abgJQLWRXuKWSn_04jVy+gaB8h-Q@mail.gmail.com>
References: <20190906091719.24886-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190906091719.24886-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel-janitors@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 6 Sep 2019 at 11:17, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Don't populate the array degrees on the stack but instead make it
> static const. Makes the object code smaller by 46 bytes.
>
> Before:
>    text    data     bss     dec     hex filename
>    5356    1560       0    6916    1b04 dw_mmc-hi3798cv200.o
>
> After:
>    text    data     bss     dec     hex filename
>    5214    1656       0    6870    1ad6 dw_mmc-hi3798cv200.o
>
> (gcc version 9.2.1, amd64)
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc-hi3798cv200.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
> index bc51cef47c47..83e1bad0a008 100644
> --- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
> +++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
> @@ -66,7 +66,7 @@ static void dw_mci_hi3798cv200_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  static int dw_mci_hi3798cv200_execute_tuning(struct dw_mci_slot *slot,
>                                              u32 opcode)
>  {
> -       int degrees[] = { 0, 45, 90, 135, 180, 225, 270, 315 };
> +       static const int degrees[] = { 0, 45, 90, 135, 180, 225, 270, 315 };
>         struct dw_mci *host = slot->host;
>         struct hi3798cv200_priv *priv = host->priv;
>         int raise_point = -1, fall_point = -1;
> --
> 2.20.1
>
