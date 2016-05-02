From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: mmc_spi broken?
Date: Mon, 2 May 2016 10:47:11 +0200
Message-ID: <CAPDyKFoXmAbvZz61QRX1nBDXXKaXJgSEHVu8+Xa4oaN=qnw=kw@mail.gmail.com>
References: <1461400625.27953.5.camel@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37699 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbcEBIrM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 May 2016 04:47:12 -0400
Received: by mail-wm0-f50.google.com with SMTP id a17so131200916wme.0
        for <linux-mmc@vger.kernel.org>; Mon, 02 May 2016 01:47:11 -0700 (PDT)
In-Reply-To: <1461400625.27953.5.camel@gmx.at>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Franz <flash86@gmx.at>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 23 April 2016 at 10:37, Franz <flash86@gmx.at> wrote:
> I am trying to get an SD Card to work via SPI interface. I am using a
> RaspberryPI Compute Module with kernel Version 4.4, but I can't get it
> to work properly. I've tried it with the native spi interface as well as
> with the spi aux interface and also with a gpio bitbang spi interface.
> It's always the same error:
>
> [ 2639.558282] mmc1: new SD card on SPI
> [ 2639.566325] mmcblk1: mmc1:0000 SD256 243 MiB
> [ 2639.646120]  mmcblk1: p1 < >
> [ 2639.833759] mmcblk1: error -38 sending status command, retrying
> [ 2639.839973] mmcblk1: error -38 sending status command, retrying
> [ 2639.846170] mmcblk1: error -38 sending status command, aborting
> [ 2639.853406] mmc1: SPI card removed
> [ 2640.240223] mmc1: host does not support reading read-only switch,
> assuming write-enable
> [ 2640.248328] mmc1: new SD card on SPI
> [ 2640.256373] mmcblk1: mmc1:0000 SD256 243 MiB
> [ 2640.336068]  mmcblk1: p1 < >
> [ 2640.523545] mmcblk1: error -38 sending status command, retrying
> [ 2640.529757] mmcblk1: error -38 sending status command, retrying
> [ 2640.535893] mmcblk1: error -38 sending status command, aborting
> [ 2640.543129] mmc1: SPI card removed
> [ 2640.930176] mmc1: host does not support reading read-only switch,
> assuming write-enable
> [ 2640.938313] mmc1: new SD card on SPI
> [ 2640.946679] mmcblk1: mmc1:0000 SD256 243 MiB
> [ 2641.026395]  mmcblk1: p1 < >
> [ 2641.213996] mmcblk1: error -38 sending status command, retrying
> [ 2641.220208] mmcblk1: error -38 sending status command, retrying
> [ 2641.226344] mmcblk1: error -38 sending status command, aborting
> [ 2641.233435] mmc1: SPI card removed
> [ 2641.620177] mmc1: host does not support reading read-only switch,
> assuming write-enable
> [ 2641.628277] mmc1: new SD card on SPI
> [ 2641.636530] mmcblk1: mmc1:0000 SD256 243 MiB
> [ 2641.716114]  mmcblk1: p1 < >
> [ 2641.903636] mmcblk1: error -38 sending status command, retrying
> [ 2641.909852] mmcblk1: error -38 sending status command, retrying
> [ 2641.915987] mmcblk1: error -38 sending status command, aborting
> [ 2641.923056] mmc1: SPI card removed
>
> I don't have any RO or CD pins configured, just plain SPI interface
> directly to the SD Card. I've tried it with different SD cards with
> differen capacities. It's always the same error. The above messages
> appear in a endless loop.The last time I've used the mmc_spi driver was
> kernel 3.8 I think with this version everything worked without any
> problems.  Does anyone know how to fix this?

So it seems to be a regression. I would try a bisect and see if it can
pin-point us to a certain commit that causes the issue.

Kind regards
Uffe
