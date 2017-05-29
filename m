From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/4] mmc: sdhci-esdhc: Add SDHCI_QUIRK_32BIT_DMA_ADDR
Date: Mon, 29 May 2017 08:12:54 -0300
Message-ID: <CAOMZO5DuH4KB6DpafWB_nSbSXpoqJ_jo9wjiCOuXR8vVCOTZpg@mail.gmail.com>
References: <1493805925-3644-1-git-send-email-benoit@wsystem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34699 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbdE2LM4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 May 2017 07:12:56 -0400
In-Reply-To: <1493805925-3644-1-git-send-email-benoit@wsystem.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit@wsystem.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@nxp.com>, joancarles <joancarles@fqingenieria.es>, =?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>, Wolfram Sang <wsa@the-dreams.de>, Dong Aisheng <aisheng.dong@nxp.com>

On Wed, May 3, 2017 at 7:05 AM, Beno=C3=AEt Th=C3=A9baudeau <benoit@wsystem=
.com> wrote:
> The eSDHC can only DMA from 32-bit-aligned addresses.
>
> This fixes the following test cases of mmc_test:
>   11:   Badly aligned write
>   12:   Badly aligned read
>   13:   Badly aligned multi-block write
>   14:   Badly aligned multi-block read
>
> Signed-off-by: Beno=C3=AEt Th=C3=A9baudeau <benoit@wsystem.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
