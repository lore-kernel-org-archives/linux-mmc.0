From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mmc: sunxi: change controller error info to
 debug level
Date: Fri, 24 Mar 2017 08:46:43 +0100
Message-ID: <CAPDyKFppqPjjXtAAcSynxMw-1Oc7W6ZMf=oJLzWwsnLUWCq5Rw@mail.gmail.com>
References: <20170316132903.61246-1-icenowy@aosc.xyz>
Reply-To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDF57NG2XIHRBZE52PDAKGQE4OOUDZI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170316132903.61246-1-icenowy-ymACFijhrKM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 16 March 2017 at 14:29, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org> wrote:
> The controller's errors are usually normal (for example, for MMC or SDIO
> cards, some errors are expected to happen; and for boards without a
> dedicated card detect pin the error info will even flood console and
> hide other normal messages) and hard to understand.
>
> Change their print level to debug, thus it won't be shown to generic
> users.
>
> Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>

For some reason this change didn't enter the mmc patchtracker. However
I have picked it up for next anyway.

Thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 6ffcd2838272..0391c62cc99f 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -489,7 +489,7 @@ static void sunxi_mmc_dump_errinfo(struct sunxi_mmc_host *host)
>                                       cmd->opcode == SD_IO_RW_DIRECT))
>                 return;
>
> -       dev_err(mmc_dev(host->mmc),
> +       dev_dbg(mmc_dev(host->mmc),
>                 "smc %d err, cmd %d,%s%s%s%s%s%s%s%s%s%s !!\n",
>                 host->mmc->index, cmd->opcode,
>                 data ? (data->flags & MMC_DATA_WRITE ? " WR" : " RD") : "",
> --
> 2.12.0
>
