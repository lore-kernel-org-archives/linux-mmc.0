From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH RESEND] mmc: sh_mmcif: fix MMC_GEN_CMD setting
Date: Thu, 08 Mar 2012 23:47:29 -0500
Message-ID: <m2linapehq.fsf@bob.laptop.org>
References: <4F571E36.4050509@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <4F571E36.4050509@renesas.com> (Yoshihiro Shimoda's message of
	"Wed, 07 Mar 2012 17:37:10 +0900")
Sender: linux-sh-owner@vger.kernel.org
To: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-mmc@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Mar 07 2012, Shimoda, Yoshihiro wrote:
> The MMC_GEN_CMD (CMD56) doesn't need to check busy signal.
> So, the patch fixes the setting.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/mmc/host/sh_mmcif.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 4a2c5b2..e8b70e3 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -745,7 +745,6 @@ static u32 sh_mmcif_set_cmd(struct sh_mmcif_host *host,
>  	case MMC_SET_WRITE_PROT:
>  	case MMC_CLR_WRITE_PROT:
>  	case MMC_ERASE:
> -	case MMC_GEN_CMD:
>  		tmp |= CMD_SET_RBSY;
>  		break;
>  	}
> @@ -828,7 +827,6 @@ static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
>  	case MMC_SET_WRITE_PROT:
>  	case MMC_CLR_WRITE_PROT:
>  	case MMC_ERASE:
> -	case MMC_GEN_CMD:
>  		mask = MASK_START_CMD | MASK_MRBSYE;
>  		break;
>  	default:

Thanks, pushed to mmc-next for 3.4.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
