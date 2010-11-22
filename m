From: saeed bishara <saeed.bishara@gmail.com>
Subject: Re: [PATCH v4 2/2] [ARM] Dove: rename SDHCI devices to "sdhci-dove"
Date: Mon, 22 Nov 2010 09:42:52 +0200
Message-ID: <AANLkTikfh7ngxNKS6nvsSuAWX+Hwv7Fs-phSZb1Jwi+w@mail.gmail.com>
References: <cover.1288293593.git.mike@compulab.co.il>
	<d0ad0e29e3842b9ab786aad8a6efc15054114331.1288293593.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:61921 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714Ab0KVHmw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Nov 2010 02:42:52 -0500
Received: by mail-qy0-f181.google.com with SMTP id 5so470323qyk.19
        for <linux-mmc@vger.kernel.org>; Sun, 21 Nov 2010 23:42:52 -0800 (PST)
In-Reply-To: <d0ad0e29e3842b9ab786aad8a6efc15054114331.1288293593.git.mike@compulab.co.il>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Saeed Bishara <saeed@marvell.com>, linux-arm-kernel@lists.infradead.org

On Thu, Oct 28, 2010 at 9:23 PM, Mike Rapoport <mike@compulab.co.il> wr=
ote:
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> CC: Saeed Bishara <saeed@marvell.com>
Acked-by: Saeed Bishara <saeed@marvell.com>
> ---
> =C2=A0arch/arm/mach-dove/common.c | =C2=A0 =C2=A04 ++--
> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.=
c
> index f7a1258..fe627ab 100644
> --- a/arch/arm/mach-dove/common.c
> +++ b/arch/arm/mach-dove/common.c
> @@ -770,7 +770,7 @@ static struct resource dove_sdio0_resources[] =3D=
 {
> =C2=A0};
>
> =C2=A0static struct platform_device dove_sdio0 =3D {
> - =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "=
sdhci-mv",
> + =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "=
sdhci-dove",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.id =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D 0,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.dev =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.dma_mask =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &sdio_dmamask,
> @@ -798,7 +798,7 @@ static struct resource dove_sdio1_resources[] =3D=
 {
> =C2=A0};
>
> =C2=A0static struct platform_device dove_sdio1 =3D {
> - =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "=
sdhci-mv",
> + =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "=
sdhci-dove",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.id =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D 1,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.dev =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.dma_mask =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &sdio_dmamask,
> --
> 1.7.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
