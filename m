From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: Question about GENHD_FL_REMOVABLE flag for eMMC cards...
Date: Mon, 07 Jun 2010 10:13:42 +0300
Message-ID: <4C0C9C26.9090504@nokia.com>
References: <AANLkTil7TuTw_VlUNo0pBKywQZ1Ol1t_okB-nBue9Xgm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47309 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755999Ab0FGHOQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jun 2010 03:14:16 -0400
In-Reply-To: <AANLkTil7TuTw_VlUNo0pBKywQZ1Ol1t_okB-nBue9Xgm@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: aparna m <m.aparna01@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

aparna m wrote:
>  Hello,
> 
> I see a comment in the MMC block layer  drivers/mmc/card/block.c that
> GENHD_FL_REMOVABLE  should not be set for MMC block devices.
> How about the case of eMMC cards that are embedded on the chip.
> In that case, the eMMC card cannot be removed nor inserted and so the
> block device also cannot be removed.
> I guess eMMC falls under the case that it is a permanent block device
> and a permanent media.
> 
> How should this be set for this case? Please correct me if I am wrong.

Mostly it is an issue with unsafe resume (see CONFIG_MMC_UNSAFE_RESUME)

There is mmc_assume_removable module parameter (see drivers/mmc/core/core.c)

And there is the mmc_host capability flag MMC_CAP_NONREMOVABLE (see
include/linux/mmc/host.h)

> Thanks,
> Aparna.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

