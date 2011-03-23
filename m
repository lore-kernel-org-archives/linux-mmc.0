From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [patch 148/177] drivers/mmc/host/omap.c: use resource_size()
Date: Wed, 23 Mar 2011 13:10:27 +0530
Message-ID: <AANLkTi=ftyiFayk+=reDcoZbsDbxi8z6KwGRL9EuviPw@mail.gmail.com>
References: <201103222334.p2MNYfMe002438@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:32805 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417Ab1CWHks convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Mar 2011 03:40:48 -0400
Received: by wya21 with SMTP id 21so7409581wya.19
        for <linux-mmc@vger.kernel.org>; Wed, 23 Mar 2011 00:40:47 -0700 (PDT)
In-Reply-To: <201103222334.p2MNYfMe002438@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org, cjb@laptop.org, jarkko.lavinen@nokia.com, linux-mmc@vger.kernel.org, tony@atomide.com

On Wed, Mar 23, 2011 at 5:04 AM,  <akpm@linux-foundation.org> wrote:
> From: Chris Ball <cjb@laptop.org>
>
> Signed-off-by: Chris Ball <cjb@laptop.org>
> Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: <linux-mmc@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Kishore Kadiyala <kishore.kadiyala@ti.com>

> ---
>
> =A0drivers/mmc/host/omap.c | =A0 =A06 +++---
> =A01 file changed, 3 insertions(+), 3 deletions(-)
>
> diff -puN drivers/mmc/host/omap.c~drivers-mmc-host-omapc-use-resource=
_size drivers/mmc/host/omap.c
> --- a/drivers/mmc/host/omap.c~drivers-mmc-host-omapc-use-resource_siz=
e
> +++ a/drivers/mmc/host/omap.c
> @@ -1417,7 +1417,7 @@ static int __init mmc_omap_probe(struct
> =A0 =A0 =A0 =A0if (res =3D=3D NULL || irq < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENXIO;
>
> - =A0 =A0 =A0 res =3D request_mem_region(res->start, res->end - res->=
start + 1,
> + =A0 =A0 =A0 res =3D request_mem_region(res->start, resource_size(re=
s),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev-=
>name);
> =A0 =A0 =A0 =A0if (res =3D=3D NULL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EBUSY;
> @@ -1457,7 +1457,7 @@ static int __init mmc_omap_probe(struct
>
> =A0 =A0 =A0 =A0host->irq =3D irq;
> =A0 =A0 =A0 =A0host->phys_base =3D host->mem_res->start;
> - =A0 =A0 =A0 host->virt_base =3D ioremap(res->start, res->end - res-=
>start + 1);
> + =A0 =A0 =A0 host->virt_base =3D ioremap(res->start, resource_size(r=
es));
> =A0 =A0 =A0 =A0if (!host->virt_base)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_ioremap;
>
> @@ -1514,7 +1514,7 @@ err_free_mmc_host:
> =A0err_ioremap:
> =A0 =A0 =A0 =A0kfree(host);
> =A0err_free_mem_region:
> - =A0 =A0 =A0 release_mem_region(res->start, res->end - res->start + =
1);
> + =A0 =A0 =A0 release_mem_region(res->start, resource_size(res));
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> _
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
