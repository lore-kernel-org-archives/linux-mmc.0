From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: swap on eMMC and other flash
Date: Mon, 9 Apr 2012 12:54:39 +0000
Message-ID: <201204091254.39380.arnd@arndb.de>
References: <201203301744.16762.arnd@arndb.de> <4F8245EA.6000600@kernel.org> <006f01cd1623$ac4a2860$04de7920$%jeong@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:56157 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230Ab2DIMyq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Apr 2012 08:54:46 -0400
In-Reply-To: <006f01cd1623$ac4a2860$04de7920$%jeong@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?utf-8?q?=EC=A0=95=ED=9A=A8=EC=A7=84?= <syr.jeong@samsung.com>
Cc: 'Minchan Kim' <minchan@kernel.org>, 'Alex Lemberg' <Alex.Lemberg@sandisk.com>, linaro-kernel@lists.linaro.org, 'Rik van Riel' <riel@redhat.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, "'Luca Porzio (lporzio)'" <lporzio@micron.com>, linux-mm@kvack.org, kernel-team@android.com, 'Yejin Moon' <yejin.moon@samsung.com>, 'Hugh Dickins' <hughd@google.com>, 'Yaniv Iarovici' <Yaniv.Iarovici@sandisk.com>, cpgs@samsung.com

On Monday 09 April 2012, =EC=A0=95=ED=9A=A8=EC=A7=84 wrote:
> If swap system use 512KB page and issue Discard/Trim align with 512KB=
, eMMC make best
> performance as of today. However, large page size in swap partition m=
ay not best way
> in Linux system level.
> I'm not sure that the best page size between Swap system and eMMC dev=
ice.

Can you explain the significance of the 512KB size? I've seen devices r=
eport 512KB
erase size, although measurements clearly showed an erase block size of=
 8MB and I
do not understand this discprepancy.

Right now, we always send discards of 1MB clusters to the device, which=
 does what
you want, although I'm not sure if those clusters are naturally aligned=
 to the start
of the partition. Obviously this also requires aligning the start of th=
e partition
to the erase block size, but most devices should already get that right=
 nowadays.

	Arnd
