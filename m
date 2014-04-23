From: Fabio Estevam <festevam@gmail.com>
Subject: Re: SD CRC error on mx27pdk
Date: Wed, 23 Apr 2014 12:21:39 -0300
Message-ID: <CAOMZO5CWLH=ZbUd9dyTqtNVqu0RTSMeBGReBYetO-wzxayS7qw@mail.gmail.com>
References: <CAOMZO5AZ4gJZMo-DZRPffaF+NdzmzMf32YwPu2gEp9AH8gDk4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:64776 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757764AbaDWPVl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Apr 2014 11:21:41 -0400
Received: by mail-la0-f49.google.com with SMTP id ec20so606579lab.36
        for <linux-mmc@vger.kernel.org>; Wed, 23 Apr 2014 08:21:39 -0700 (PDT)
In-Reply-To: <CAOMZO5AZ4gJZMo-DZRPffaF+NdzmzMf32YwPu2gEp9AH8gDk4Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>, Shawn Guo <shawn.guo@freescale.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Wed, Apr 23, 2014 at 12:10 PM, Fabio Estevam <festevam@gmail.com> wrote:

> ,but I get this error:
>
> mxc-mmc 10013000.sdhci: mxcmci_finish_data: -EILSEQ
> mmc0: error -84 whilst initialising SD card
> mmc0: host does not support reading read-only switch. assuming write-enable.
> mmc0: new SDHC card at address b5a1
> mmcblk0: mmc0:b5a1 SD04G 3.69 GiB
>  mmcblk0: unknown partition table

I forgot to mention that this error does not happen if I boot the
non-dt kernel, so it seems to be related to dt only.
