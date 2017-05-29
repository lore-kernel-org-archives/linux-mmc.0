From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/4] mmc: sdhci-esdhc-imx: Fix DAT line software reset
Date: Mon, 29 May 2017 08:13:21 -0300
Message-ID: <CAOMZO5CxMLt-cmHFPA_FYKx1pSq7rTsHQ9uuNPoBQHRyS3En9w@mail.gmail.com>
References: <1493805925-3644-1-git-send-email-benoit@wsystem.com> <1493805925-3644-2-git-send-email-benoit@wsystem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35163 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbdE2LNX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 May 2017 07:13:23 -0400
In-Reply-To: <1493805925-3644-2-git-send-email-benoit@wsystem.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit@wsystem.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@nxp.com>, joancarles <joancarles@fqingenieria.es>, =?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>, Wolfram Sang <wsa@the-dreams.de>, Dong Aisheng <aisheng.dong@nxp.com>

On Wed, May 3, 2017 at 7:05 AM, Beno=C3=AEt Th=C3=A9baudeau <benoit@wsystem=
.com> wrote:
> On i.MX25, the eSDHC DAT line software reset (SYSCTL.RSTD) unexpectedly
> clears at least the data transfer width (PROCTL.DTW), which then results
> in data CRC errors. This behavior is not documented, but it has actually
> been observed. Consequently, the DAT line software resets triggered by
> sdhci.c in case of errors caused unrecoverable errors.
>
> Fix this by making sure that the DAT line software reset does not alter
> the Host Control register. This behavior being undocumented, it may also
> be present on other i.MX SoCs, so apply this fix for the whole i.MX
> family.
>
> Signed-off-by: Beno=C3=AEt Th=C3=A9baudeau <benoit@wsystem.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
