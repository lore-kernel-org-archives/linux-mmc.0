From: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: Re: sdhci-esdhc-imx : cannot read eMMC
Date: Tue, 2 Sep 2014 17:10:14 +0200
Message-ID: <CAL8zT=gpiV9OMToH80Qr5B7HUUbVDp0m_WK9PaCvuaMGwrBSJA@mail.gmail.com>
References: <CAL8zT=gJtnyGSnVz+YWW3Z1LPXPp-Oe3SsGqvBvV=2LBpZ-t9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:40438 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbaIBPK3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Sep 2014 11:10:29 -0400
Received: by mail-oa0-f50.google.com with SMTP id o6so4900396oag.9
        for <linux-mmc@vger.kernel.org>; Tue, 02 Sep 2014 08:10:29 -0700 (PDT)
In-Reply-To: <CAL8zT=gJtnyGSnVz+YWW3Z1LPXPp-Oe3SsGqvBvV=2LBpZ-t9Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Jean-Michel Hautbois <jhautbois@gmail.com>

2014-09-02 11:20 GMT+02:00 Jean-Michel Hautbois
<jean-michel.hautbois@vodalys.com>:
> Hi there,
>
> I start a new thread, as I have done lots of test and this will be clearer.
> I have problems reading and writing eMMC on my i.MX6 board with 3.17-rc3.
> Sometimes I don't have read errors explicitly in dmesg, but fdisk has
> no effects.
> I activated MMC debug in my config file, and here is an extract of
> mmc0 register dump and all mmc1 part.
> On Freescale kernel, I confirm it works well with the same board and
> sample, I can write a partition on mmc1.

<snip>

> [    3.099853] sdhci [sdhci_add_host()]: mmc1: Auto-CMD23 available
> [    3.100143] sdhci-esdhc-imx 219c000.usdhc: No vqmmc regulator found

I have set my vqmmc-supply in my DT, and it works well now...
I don't really know why specifying vqmmc-supply is better, but I can
assure it is : I can mount the partition created on the eMMC.
The only remaining errors are on boot partitions reading.
Maybe should we have a parameter in DT in order to tell if we want to
get thse partitions or not, instead of the return value of
mmc_boot_partition_access() which is always 1 (if I don't miss
something) ?

Thanks,
JM
