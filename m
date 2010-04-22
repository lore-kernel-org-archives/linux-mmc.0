From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 5/8] SH: Add SDHI DMA support to ecovec
Date: Wed, 21 Apr 2010 20:16:29 -0400
Message-ID: <p2iaec7e5c31004211716z430581dfn9a695537d4d8489a@mail.gmail.com>
References: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
	 <Pine.LNX.4.64.1004211734460.5292@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37193 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292Ab0DVAVb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Apr 2010 20:21:31 -0400
In-Reply-To: <Pine.LNX.4.64.1004211734460.5292@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>

On Wed, Apr 21, 2010 at 11:37 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> @@ -442,6 +444,8 @@ static void sdhi0_set_pwr(struct platform_device =
*pdev, int state)
> =A0}
>
> =A0static struct sh_mobile_sdhi_info sdhi0_info =3D {
> + =A0 =A0 =A0 .dma_slave_tx =3D SHDMA_SLAVE_SDHI0_TX,
> + =A0 =A0 =A0 .dma_slave_rx =3D SHDMA_SLAVE_SDHI0_RX,
> =A0 =A0 =A0 =A0.set_pwr =3D sdhi0_set_pwr,
> =A0};
>
> @@ -478,6 +482,9 @@ static void sdhi1_set_pwr(struct platform_device =
*pdev, int state)
> =A0}
>
> =A0static struct sh_mobile_sdhi_info sdhi1_info =3D {
> + =A0 =A0 =A0 .dma_slave_tx =3D SHDMA_SLAVE_SDHI1_TX,
> + =A0 =A0 =A0 .dma_slave_rx =3D SHDMA_SLAVE_SDHI1_RX,
> + =A0 =A0 =A0 .tmio_flags =3D TMIO_DEFER_RX_COMPLETE,

This is a bit odd. How come SDHI1 needs this flag and SDHI0 doesn't?

/ magnus
