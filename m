From: Avri Altman <Avri.Altman@sandisk.com>
Subject: RE: [PATCH 5/5] mmc: block: move multi-ioctl() to use block layer
Date: Tue, 23 May 2017 09:21:12 +0000
Message-ID: <BY2PR0401MB0901D2EBE89E42B8B6CB8CBEE5F90@BY2PR0401MB0901.namprd04.prod.outlook.com>
References: <20170510082418.10513-1-linus.walleij@linaro.org>
 <20170510082418.10513-6-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:28142 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759853AbdEWJVO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 May 2017 05:21:14 -0400
In-Reply-To: <20170510082418.10513-6-linus.walleij@linaro.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Linus Walleij
> Sent: Wednesday, May 10, 2017 11:24 AM
> To: linux-mmc@vger.kernel.org; Ulf Hansson <ulf.hansson@linaro.org>;
> Adrian Hunter <adrian.hunter@intel.com>
> Cc: linux-block@vger.kernel.org; Jens Axboe <axboe@kernel.dk>; Christoph
> Hellwig <hch@lst.de>; Arnd Bergmann <arnd@arndb.de>; Bartlomiej
> Zolnierkiewicz <b.zolnierkie@samsung.com>; Paolo Valente
> <paolo.valente@linaro.org>; Linus Walleij <linus.walleij@linaro.org>
> Subject: [PATCH 5/5] mmc: block: move multi-ioctl() to use block layer
>=20
> This switches also the multiple-command ioctl() call to issue all ioctl()=
s
> through the block layer instead of going directly to the device.
>=20
> We extend the passed argument with an argument count and loop over all
> passed commands in the ioctl() issue function called from the block layer=
.
>=20
> By doing this we are again loosening the grip on the big host lock, since=
 two
> calls to mmc_get_card()/mmc_put_card() are removed.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Avri Altman <Avri.Altman@sandisk.com>
