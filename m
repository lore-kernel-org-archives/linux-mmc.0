From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: irq flood with mmc boot partitions on s3c2416 with 3.0rc1
Date: Mon, 13 Jun 2011 19:09:06 -0500
Message-ID: <BANLkTi=YvSL_yzku6v3tsJaaLTL=fBXShg@mail.gmail.com>
References: <201106022149.47936.heiko@sntech.de>
	<BANLkTi=xVzdLDq5wbzLtQFu+nz=8G9SbKQ@mail.gmail.com>
	<201106030956.43174.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og114.obsmtp.com ([64.18.0.28]:41307 "EHLO
	exprod5og114.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755122Ab1FNAJJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jun 2011 20:09:09 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p5E09hTo005209
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2011 20:09:43 -0400 (EDT)
Received: from mail-px0-f169.google.com (mail-px0-f169.google.com [209.85.212.169])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p5E09dMJ005199
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2011 20:09:43 -0400 (EDT)
Received: by mail-px0-f169.google.com with SMTP id 9so3388467pxi.0
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2011 17:09:07 -0700 (PDT)
In-Reply-To: <201106030956.43174.heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: Kyungmin Park <kmpark@infradead.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Everybody,

On Fri, Jun 3, 2011 at 2:56 AM, Heiko St=FCbner <heiko@sntech.de> wrote=
:
>
> Hi,
>
> Am Freitag 03 Juni 2011, 01:48:05 schrieb Kyungmin Park:
> > As I don't have the s3c2416 user manaul, I'm not sure it's support
> > AUTO CMD12 or not. but at least it's support at s3c6410 and later.
> According to the manual, the 2416 supports AUTO CMD12.
>
> As I wrote disabling auto cmd12 only works sometimes and other times =
the irq
> storm happens like with auto cmd12 enabled - always after the first r=
eboot.
> So it seems auto cmd12 is not the real reason for the error.
>
> Do you also encounter the second error later on (for me in udev stage=
):
> > =A0mmcblk1boot0: retrying using single block read
> > =A0mmc1: ADMA error
> > =A0mmcblk1boot0: error -5 transferring data, sector 448, nr 32, car=
d status
> > 0x900
> > =A0end_request: I/O error, dev mmcblk1boot0, sector 448
> > =A0Buffer I/O error on device mmcblk1boot0, logical block 56
> > =A0mmcblk1boot1: retrying using single block read
> > =A0mmc1: ADMA error
> > =A0mmcblk1boot1: error -5 transferring data, sector 448, nr 32, car=
d status
> > 0x900
> > =A0end_request: I/O error, dev mmcblk1boot1, sector 448
>
>

I recently came back from vacation (which is why I didn't pitch in
before). Has there been any further update on this? I want to exclude
my EMMC partitioning changes as the possible culprit here.

A
