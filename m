From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: irq flood with mmc boot partitions on s3c2416 with 3.0rc1
Date: Fri, 3 Jun 2011 09:56:42 +0200
Message-ID: <201106030956.43174.heiko@sntech.de>
References: <201106022149.47936.heiko@sntech.de> <BANLkTi=xVzdLDq5wbzLtQFu+nz=8G9SbKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from s15407518.onlinehome-server.info ([82.165.136.167]:58643 "EHLO
	s15407518.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752903Ab1FCH4q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Jun 2011 03:56:46 -0400
In-Reply-To: <BANLkTi=xVzdLDq5wbzLtQFu+nz=8G9SbKQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andreiw@motorola.com

Hi,

Am Freitag 03 Juni 2011, 01:48:05 schrieb Kyungmin Park:
> As I don't have the s3c2416 user manaul, I'm not sure it's support
> AUTO CMD12 or not. but at least it's support at s3c6410 and later.
According to the manual, the 2416 supports AUTO CMD12.

As I wrote disabling auto cmd12 only works sometimes and other times the irq 
storm happens like with auto cmd12 enabled - always after the first reboot.
So it seems auto cmd12 is not the real reason for the error.

Do you also encounter the second error later on (for me in udev stage):
>  mmcblk1boot0: retrying using single block read
>  mmc1: ADMA error
>  mmcblk1boot0: error -5 transferring data, sector 448, nr 32, card status
> 0x900
>  end_request: I/O error, dev mmcblk1boot0, sector 448
>  Buffer I/O error on device mmcblk1boot0, logical block 56
>  mmcblk1boot1: retrying using single block read
>  mmc1: ADMA error
>  mmcblk1boot1: error -5 transferring data, sector 448, nr 32, card status
> 0x900
>  end_request: I/O error, dev mmcblk1boot1, sector 448


Thanks
Heiko
