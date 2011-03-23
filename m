From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [patch 149/177] drivers/mmc/host/omap_hsmmc.c: use resource_size()
Date: Wed, 23 Mar 2011 13:08:50 +0530
Message-ID: <AANLkTikU3-WOmA9=TKv_2dFvB4zRvMR67Ro3aEW_ANuW@mail.gmail.com>
References: <201103222334.p2MNYhll002442@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50564 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417Ab1CWHjL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Mar 2011 03:39:11 -0400
Received: by wwa36 with SMTP id 36so9794026wwa.1
        for <linux-mmc@vger.kernel.org>; Wed, 23 Mar 2011 00:39:10 -0700 (PDT)
In-Reply-To: <201103222334.p2MNYhll002442@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org, cjb@laptop.org, linux-mmc@vger.kernel.org, madhu.cr@ti.com

On Wed, Mar 23, 2011 at 5:04 AM,  <akpm@linux-foundation.org> wrote:
> From: Chris Ball <cjb@laptop.org>
>
> Use resource_size().
>
> Signed-off-by: Chris Ball <cjb@laptop.org>
> Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
> Cc: <linux-mmc@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

=46eel free to add
Acked-by: Kishore Kadiyala <kishore.kadiyala@ti.com>

> ---
>
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A07 +++----
> =A01 file changed, 3 insertions(+), 4 deletions(-)
>
> diff -puN drivers/mmc/host/omap_hsmmc.c~drivers-mmc-host-omap_hsmmcc-=
use-resource_size drivers/mmc/host/omap_hsmmc.c
> --- a/drivers/mmc/host/omap_hsmmc.c~drivers-mmc-host-omap_hsmmcc-use-=
resource_size
> +++ a/drivers/mmc/host/omap_hsmmc.c
> @@ -2047,8 +2047,7 @@ static int __init omap_hsmmc_probe(struc
>
> =A0 =A0 =A0 =A0res->start +=3D pdata->reg_offset;
> =A0 =A0 =A0 =A0res->end +=3D pdata->reg_offset;
> - =A0 =A0 =A0 res =3D request_mem_region(res->start, res->end - res->=
start + 1,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev->name);
> + =A0 =A0 =A0 res =3D request_mem_region(res->start, resource_size(re=
s), pdev->name);
> =A0 =A0 =A0 =A0if (res =3D=3D NULL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EBUSY;
>
> @@ -2287,7 +2286,7 @@ err1:
> =A0err_alloc:
> =A0 =A0 =A0 =A0omap_hsmmc_gpio_free(pdata);
> =A0err:
> - =A0 =A0 =A0 release_mem_region(res->start, res->end - res->start + =
1);
> + =A0 =A0 =A0 release_mem_region(res->start, resource_size(res));
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> @@ -2324,7 +2323,7 @@ static int omap_hsmmc_remove(struct plat
>
> =A0 =A0 =A0 =A0res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0)=
;
> =A0 =A0 =A0 =A0if (res)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(res->start, res->end=
 - res->start + 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(res->start, resource=
_size(res));
> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, NULL);
>
> =A0 =A0 =A0 =A0return 0;
> _
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
