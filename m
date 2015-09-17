From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: wbsd: Remove unneded semicolon
Date: Thu, 17 Sep 2015 10:49:05 +0200
Message-ID: <CAPDyKFpO-hU=hYQU+czB=Buo2Z1OnUTB-mG=KtbxTY0D22kqKQ@mail.gmail.com>
References: <1442395804-17736-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442395804-17736-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pierre Ossman <pierre@ossman.eu>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 16 September 2015 at 11:30, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> It's not needed an is just creating a null statement, so remove it.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Thanks, applied for next!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/wbsd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
> index ca183ea767b3..c3fd16d997ca 100644
> --- a/drivers/mmc/host/wbsd.c
> +++ b/drivers/mmc/host/wbsd.c
> @@ -809,7 +809,7 @@ static void wbsd_request(struct mmc_host *mmc, struct mmc_request *mrq)
>                         cmd->error = -EINVAL;
>
>                         goto done;
> -               };
> +               }
>         }
>
>         /*
> --
> 2.4.3
>
