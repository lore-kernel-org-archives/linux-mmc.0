From: Will Newton <will.newton@gmail.com>
Subject: Re: [RFC] mmc: dw_mmc: Fix the max_blk_count in IDMAC
Date: Thu, 23 Feb 2012 12:14:24 +0000
Message-ID: <CAFbHwiT_KTWBLUSDbfMvuK0UEa_RrVqVF5V1WBqm+5c39Rtnqg@mail.gmail.com>
References: <000301ccf1fc$64e5dbe0$2eb193a0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42453 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400Ab2BWMOZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Feb 2012 07:14:25 -0500
Received: by daed14 with SMTP id d14so1210994dae.19
        for <linux-mmc@vger.kernel.org>; Thu, 23 Feb 2012 04:14:24 -0800 (PST)
In-Reply-To: <000301ccf1fc$64e5dbe0$2eb193a0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, James Hogan <james.hogan@imgtec.com>

2012/2/23 Seungwon Jeon <tgih.jun@samsung.com>:
> Hi all,
>
> Even though 1MB is reserved for descriptor table in IDMAC,
> the dw_mmc host driver is allowed to receive only maximum
> 128KB block length in one request. This is caused by setting
> improper max_blk_count. It needs to be e adjusted so that
> descriptor table is used fully.
>
> It is found that the performance is improved with the increased the
> max_blk_count. In my case, there is 82%(6%) improvement in sequential
> write(read). Is there anybody who knows the reason about the old sett=
ing?
>
> Best regards,
> Seungwon Jeon.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
> =A0drivers/mmc/host/dw_mmc.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index bf3c9b4..af2b901 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1804,9 +1804,9 @@ static int __init dw_mci_init_slot(struct dw_mc=
i *host, unsigned int id)
> =A0#ifdef CONFIG_MMC_DW_IDMAC
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->max_segs =3D host->ring_size;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->max_blk_size =3D 65536;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_blk_count =3D host->ring_size;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->max_seg_size =3D 0x1000;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_req_size =3D mmc->max_seg_size=
 * mmc->max_blk_count;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_req_size =3D mmc->max_seg_size=
 * host->ring_size;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_blk_count =3D mmc->max_req_siz=
e / 512;

I am not sure this is correct, it seems like most drivers calculate
max_req_size like this:

mmc->max_req_size =3D mmc->max_blk_size * mmc->max_blk_count;

And indeed in the external DMA case dw_mmc does that too.

It should probably be safe to set max_seg_size to max_req_size too.

> =A0#else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->max_segs =3D 64;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->max_blk_size =3D 65536; /* BLKSIZ=
 is 16 bits */
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
