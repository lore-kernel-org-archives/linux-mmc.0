From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] sdhci: pxav3 controller needs 32 bit ADMA addressing
Date: Thu, 14 Jul 2011 09:48:26 +0800
Message-ID: <CAMj5BkhyNyohd+rO9VPqC9t6CyneCqd4ERTe4fRvxBDojRc8Yw@mail.gmail.com>
References: <44DD7577-7CB6-42D0-9427-A8731C248612@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39603 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab1GNBs2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jul 2011 21:48:28 -0400
Received: by qwk3 with SMTP id 3so3140880qwk.19
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jul 2011 18:48:27 -0700 (PDT)
In-Reply-To: <44DD7577-7CB6-42D0-9427-A8731C248612@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Zhangfei Gao <zgao6@marvell.com>

On Tue, Jul 12, 2011 at 5:47 AM, Philip Rakity <prakity@marvell.com> wr=
ote:
>
> enable the quirk.
>
> Best used in conjunction with patch downgrading
> ADMA to SDMA when transfer is not aligned.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
> =A0drivers/mmc/host/sdhci-pxav3.c | =A0 =A03 ++-
> =A01 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-=
pxav3.c
> index 4198dbb..fc7e4a5 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -195,7 +195,8 @@ static int __devinit sdhci_pxav3_probe(struct pla=
tform_device *pdev)
> =A0 =A0 =A0 =A0clk_enable(clk);
>
> =A0 =A0 =A0 =A0host->quirks =3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SDHCI_QUIRK_32BIT_ADMA_SIZE;
>
> =A0 =A0 =A0 =A0/* enable 1/8V DDR capable */
> =A0 =A0 =A0 =A0host->mmc->caps |=3D MMC_CAP_1_8V_DDR;
> --
> 1.7.0.4
>
>

Acked-by:  Zhangfei Gao <zhangfei.gao@marvell.com>
