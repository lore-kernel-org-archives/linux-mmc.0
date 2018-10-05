From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: tifm_sd: Mark expected switch fall-through
Date: Fri, 5 Oct 2018 15:54:12 +0200
Message-ID: <CAPDyKFprMFWxRbx-fpo9M4J_Q=z8kZNqMsna-FjR54cyBYE96A@mail.gmail.com>
References: <20181005095457.GA21116@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181005095457.GA21116@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Alex Dubov <oakad@yahoo.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 5 October 2018 at 11:54, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Notice that in this particular case, I replaced the
> "deliberate fall-through" comment with a proper "fall through"
> at the bottom of the case, which is what GCC is expecting to find.
>
> Addresses-Coverity-ID: 1373887 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>


Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/tifm_sd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
> index a3d8380..b6644ce 100644
> --- a/drivers/mmc/host/tifm_sd.c
> +++ b/drivers/mmc/host/tifm_sd.c
> @@ -336,7 +336,8 @@ static unsigned int tifm_sd_op_flags(struct mmc_command *cmd)
>                 rc |= TIFM_MMCSD_RSP_R0;
>                 break;
>         case MMC_RSP_R1B:
> -               rc |= TIFM_MMCSD_RSP_BUSY; // deliberate fall-through
> +               rc |= TIFM_MMCSD_RSP_BUSY;
> +               /* fall-through */
>         case MMC_RSP_R1:
>                 rc |= TIFM_MMCSD_RSP_R1;
>                 break;
> --
> 2.7.4
>
