From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sh_mmcif: remove redundant initialization of 'opc'
Date: Thu, 18 Jan 2018 09:33:26 +0100
Message-ID: <CAPDyKFrN+Of4A5S-os6E1fqueN_iE2u0sJmESnszBoABEbC1hQ@mail.gmail.com>
References: <20180117134157.23943-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117134157.23943-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel-janitors@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 17 January 2018 at 14:41, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Variable opc is initialized with a value that is never read, opc
> is later re-assigned a newer value, hence the initialization can
> be removed.
>
> Cleans up clang warning:
> drivers/mmc/host/sh_mmcif.c:919:6: warning: Value stored to 'opc'
> during its initialization is never read
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sh_mmcif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 53fb18bb7bee..7bb00c68a756 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -916,7 +916,7 @@ static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
>                                struct mmc_request *mrq)
>  {
>         struct mmc_command *cmd = mrq->cmd;
> -       u32 opc = cmd->opcode;
> +       u32 opc;
>         u32 mask = 0;
>         unsigned long flags;
>
> --
> 2.15.1
>
