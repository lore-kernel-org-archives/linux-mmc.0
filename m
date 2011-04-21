From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [RFC] MMC: Block: Ensure hardware partitions don't mess with
 mmcblk device naming.
Date: Thu, 21 Apr 2011 03:17:25 -0500
Message-ID: <BANLkTi=eZBEHrxAP36QAP8M7bkhw88uNGQ@mail.gmail.com>
References: <BANLkTik9s49HDYzmmeeFuaWU8bLYf67Cbg@mail.gmail.com>
	<1303366079-2196-1-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og109.obsmtp.com ([64.18.0.188]:40981 "EHLO
	exprod5og109.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504Ab1DUIR1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 04:17:27 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3L8Hp2O013991
	for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 04:17:51 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3L89MBA011326
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 04:17:50 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so1672725wwb.3
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 01:17:25 -0700 (PDT)
In-Reply-To: <1303366079-2196-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Andrei Warkentin <andreiw@motorola.com>

On Thu, Apr 21, 2011 at 1:07 AM, Andrei Warkentin <andreiw@motorola.com=
> wrote:
> With the hardware partitions support (which represent additional logi=
cal devices
> present on MMC), devidx does not correspond with index used to form
> /dev/mmcblkX names. So use an additional allocated index for device n=
ames.
>
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
> ---
> =A0drivers/mmc/card/block.c | =A0 24 +++++++++++++++++-------
> =A01 files changed, 17 insertions(+), 7 deletions(-)

The alternative is to borrow from a previous suggestion by Stephen
Warren, but instead of using card->host->index in place of devidx, use
card->host->index in place of an additional name_index used to form
/dev/mmcblkX device names.

Using card->host->index for devidx doesn't work when you have multiple
logical devices per host (because MMC card contains HW partitions).

Chris, unfortunately I am working OOF for next couple of days(I am
happy I took my eMMC board with me), so I was not able to test second
card (laptop only has 1 slot). Tested on your mmc tree with SDHCI and
my MMC08G card. Would you mind testing above RFC change? Sorry again
for the regression, grrrr.

A
