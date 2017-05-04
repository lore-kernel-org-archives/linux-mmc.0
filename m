From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/4] mmc: sdhci-esdhc: Add SDHCI_QUIRK_32BIT_DMA_ADDR
Date: Thu, 4 May 2017 10:47:11 +0200
Message-ID: <CAK8P3a2PTrDEKbvGRDcq6dhDaALbEQbUwO-TpjricgJPREFK=g@mail.gmail.com>
References: <1493805925-3644-1-git-send-email-benoit@wsystem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:35656 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbdEDIrM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 May 2017 04:47:12 -0400
In-Reply-To: <1493805925-3644-1-git-send-email-benoit@wsystem.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit@wsystem.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@nxp.com>, joancarles <joancarles@fqingenieria.es>, =?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>, Wolfram Sang <wsa@the-dreams.de>

On Wed, May 3, 2017 at 12:05 PM, Beno=C3=AEt Th=C3=A9baudeau <benoit@wsyste=
m.com> wrote:
> The eSDHC can only DMA from 32-bit-aligned addresses.
>
> This fixes the following test cases of mmc_test:
>   11:   Badly aligned write
>   12:   Badly aligned read
>   13:   Badly aligned multi-block write
>   14:   Badly aligned multi-block read
>
> Signed-off-by: Beno=C3=AEt Th=C3=A9baudeau <benoit@wsystem.com>

Is this the right description? I thought that SDHCI_QUIRK_32BIT_DMA_ADDR
was for devices that cannot address high memory above 0xffffffff, rather th=
an
requiring a specific alignment.

If this is indeed an address range problem rather than an alignment problem=
,
are you sure it is the SD controller that is wrong here, rather than having=
 a
64-bit DMA capable  SDHCI connected to a 32-bit parent bus? In the
latter case, the dma-ranges property in the parent bus should limit
the addressing, not the device.

      Arnd
