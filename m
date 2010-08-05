From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for eSDHC driver
Date: Wed, 4 Aug 2010 19:02:56 -0600
Message-ID: <AANLkTinJKO3-iXOXuL7CMWCj5qMMHyMrtnadwPpqTeBu@mail.gmail.com>
References: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36991 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756437Ab0HEBDQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Aug 2010 21:03:16 -0400
Received: by ywh1 with SMTP id 1so2237304ywh.19
        for <linux-mmc@vger.kernel.org>; Wed, 04 Aug 2010 18:03:16 -0700 (PDT)
In-Reply-To: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roy Zang <tie-fei.zang@freescale.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org

On Mon, Aug 2, 2010 at 9:11 PM, Roy Zang <tie-fei.zang@freescale.com> w=
rote:
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
>
> Add auto CMD12 command support for eSDHC driver.
> This is needed by P4080 and P1022 for block read/write.
> Manual asynchronous CMD12 abort operation causes protocol violations =
on
> these silicons.
>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
> =A0drivers/mmc/host/sdhci-of-core.c | =A0 =A04 ++++
> =A0drivers/mmc/host/sdhci.c =A0 =A0 =A0 =A0 | =A0 14 ++++++++++++--
> =A0drivers/mmc/host/sdhci.h =A0 =A0 =A0 =A0 | =A0 =A02 ++
> =A03 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c6d1bd8..a92566e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -817,8 +817,12 @@ static void sdhci_set_transfer_mode(struct sdhci=
_host *host,
> =A0 =A0 =A0 =A0WARN_ON(!host->data);
>
> =A0 =A0 =A0 =A0mode =3D SDHCI_TRNS_BLK_CNT_EN;
> - =A0 =A0 =A0 if (data->blocks > 1)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRNS_MULTI;
> + =A0 =A0 =A0 if (data->blocks > 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_MULTIBLO=
CK_READ_ACMD12)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRNS_MU=
LTI | SDHCI_TRNS_ACMD12;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRNS_MU=
LTI;

nit:
+               mode |=3D SDHCI_TRNS_MULTI;
+               if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
+                       mode |=3D SDHCI_TRNS_ACMD12;

Clearer, no?

> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0if (data->flags & MMC_DATA_READ)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mode |=3D SDHCI_TRNS_READ;
> =A0 =A0 =A0 =A0if (host->flags & SDHCI_REQ_USE_DMA)
