From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] drivers/mmc/host/mmc_spi.c: Use get/put_unaligned_be32
Date: Wed, 14 May 2014 12:17:15 +0200
Message-ID: <CAPDyKFo9xZ-z6eM0zG2A+=Bwj0EVyGxm=m28Lh9cHPSB+8qq1w@mail.gmail.com>
References: <20140511100211.1334.qmail@ns.horizon.com>
	<20140511100502.1491.qmail@ns.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140511100502.1491.qmail-HzZAx2gCgqrSUeElwK9/Pw@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: George Spelvin <linux-gpGsJRJZ3PBBDgjK7y7TUQ@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, arik-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org, david.gnedt-rFfgOQFw6VLk7+2FdBfRIA@public.gmane.org, eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org, jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, John Linville <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, luca-XPOmlcxoEMv1KXRcyAk9cg@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 11 May 2014 12:05, George Spelvin <linux-gpGsJRJZ3PBBDgjK7y7TUQ@public.gmane.org> wrote:
> Very minor source and binary size reduction.
>
> Signed-off-by: George Spelvin <linux-gpGsJRJZ3PBBDgjK7y7TUQ@public.gmane.org>
> ---
> I spotted this while making the previous crc7 change.
>
> This looks simple enough, but I don't actually have one of these devices to test.
> At least one other careful desk-check is solicited.

Acked-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Feel free to take this through the wireless tree as well. I assumes
it's that same patchset as the other spi related fixes?

Kind regards
Ulf Hansson

>
>  drivers/mmc/host/mmc_spi.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 338e2202ea..cc8d4a6099 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -448,7 +448,6 @@ mmc_spi_command_send(struct mmc_spi_host *host,
>  {
>         struct scratch          *data = host->data;
>         u8                      *cp = data->status;
> -       u32                     arg = cmd->arg;
>         int                     status;
>         struct spi_transfer     *t;
>
> @@ -465,14 +464,12 @@ mmc_spi_command_send(struct mmc_spi_host *host,
>          * We init the whole buffer to all-ones, which is what we need
>          * to write while we're reading (later) response data.
>          */
> -       memset(cp++, 0xff, sizeof(data->status));
> +       memset(cp, 0xff, sizeof(data->status));
>
> -       *cp++ = 0x40 | cmd->opcode;
> -       *cp++ = (u8)(arg >> 24);
> -       *cp++ = (u8)(arg >> 16);
> -       *cp++ = (u8)(arg >> 8);
> -       *cp++ = (u8)arg;
> -       *cp++ = crc7_be(0, &data->status[1], 5) | 0x01;
> +       cp[1] = 0x40 | cmd->opcode;
> +       put_unaligned_be32(cmd->arg, cp+2);
> +       cp[6] = crc7_be(0, cp+1, 5) | 0x01;
> +       cp += 7;
>
>         /* Then, read up to 13 bytes (while writing all-ones):
>          *  - N(CR) (== 1..8) bytes of all-ones
> @@ -711,10 +708,7 @@ mmc_spi_writeblock(struct mmc_spi_host *host, struct spi_transfer *t,
>          * so we have to cope with this situation and check the response
>          * bit-by-bit. Arggh!!!
>          */
> -       pattern  = scratch->status[0] << 24;
> -       pattern |= scratch->status[1] << 16;
> -       pattern |= scratch->status[2] << 8;
> -       pattern |= scratch->status[3];
> +       pattern = get_unaligned_be32(scratch->status);
>
>         /* First 3 bit of pattern are undefined */
>         pattern |= 0xE0000000;
> --
> 1.9.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
