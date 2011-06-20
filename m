From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: irq flood with mmc boot partitions on s3c2416 with 3.0rc1
Date: Mon, 20 Jun 2011 14:34:53 -0500
Message-ID: <BANLkTi=FWsfFWQDKk4CbSB5JK5NXhVJZnQ@mail.gmail.com>
References: <201106022149.47936.heiko@sntech.de>
	<BANLkTinCyr=pL9tyK+F9XxX2r15acqEsNA@mail.gmail.com>
	<201106191623.48470.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og102.obsmtp.com ([64.18.0.143]:55744 "EHLO
	exprod5og102.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116Ab1FTTez convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 15:34:55 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.129.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p5KJZVtM014603
	for <linux-mmc@vger.kernel.org>; Mon, 20 Jun 2011 15:35:31 -0400 (EDT)
Received: from mail-pz0-f42.google.com (mail-pz0-f42.google.com [209.85.210.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p5KJHdCu005859
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 20 Jun 2011 15:35:31 -0400 (EDT)
Received: by mail-pz0-f42.google.com with SMTP id 37so4185125pzk.15
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jun 2011 12:34:53 -0700 (PDT)
In-Reply-To: <201106191623.48470.heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: Daniel Mack <zonque@gmail.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com

Heiko,

On Sun, Jun 19, 2011 at 9:23 AM, Heiko St=FCbner <heiko@sntech.de> wrot=
e:
> Am Samstag 18 Juni 2011, 22:56:11 schrieb Daniel Mack:

The log you sent out seems a bit short (it's covers < 1s of boot time
- usb0: no IPv6 routers present is the last line ). Can you send -
1) A full log with errors without any of my patches.
2) A full log with just the first patch.
3) A full log with just the second patch.

I'm interested in knowing what the pattern of access to boot0 and
boot1 is that causes these failures - does it only report I/O errors
for for certain blocks (say, above some number) or for all of them.

A
