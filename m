From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [RFC] MMC: error handling improvements
Date: Wed, 16 Feb 2011 19:01:06 +0000
Message-ID: <1297882866.20252.20.camel@hornet.cambridge.arm.com>
References: <20110215230311.GT4152@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from service87.mimecast.com ([94.185.240.25]:36856 "HELO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750857Ab1BPTBM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Feb 2011 14:01:12 -0500
In-Reply-To: <20110215230311.GT4152@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Hi,

> The adaptive clock
> rate algorithm can probably do with a lot more work to avoid it up-
> clocking to a rate which has proven to never work.  I'd actually go a=
s
> far as to say that the algorithm probably has a lot to be desired - b=
ut
> it seems to work for my test scenarios.

I've just gave it a try (on top of a clean 2.6.38-rc5):


/ # dd if=3D/dev/mmcblk0 of=3D/dev/null bs=3D128k count=3D10
10+0 records in
10+0 records out
1310720 bytes (1.3MB) copied, 2.922722 seconds, 437.9KB/s
/ # cat /dev/sda > /dev/null &
/ # dd if=3D/dev/mmcblk0 of=3D/dev/null bs=3D128k count=3D10
mmcblk0: error -5 transferring data, sector 0, nr 120, cmd response 0x9=
00, card status 0xb00
mmcblk0: error -5 transferring data, sector 0, nr 120, cmd response 0x9=
00, card status 0xb00
mmcblk0: retrying with slower /2 clock rate
mmcblk0: error -5 transferring data, sector 0, nr 120, cmd response 0x9=
00, card status 0xb00
mmcblk0: retrying with slower /4 clock rate
mmcblk0: error -5 transferring data, sector 0, nr 120, cmd response 0x9=
00, card status 0xb00
mmcblk0: retrying with slower /8 clock rate
mmcblk0: error -5 transferring data, sector 0, nr 120, cmd response 0x9=
00, card status 0xb00
mmcblk0: retrying with slower /16 clock rate
10+0 records in
10+0 records out
1310720 bytes (1.3MB) copied, 46.763456 seconds, 27.4KB/s
/ # kill %1
/ #=20
[1]+  Terminated                 cat /dev/sda 1>/dev/null
/ # dd if=3D/dev/mmcblk0 of=3D/dev/null bs=3D128k count=3D10
10+0 records in
10+0 records out
1310720 bytes (1.3MB) copied, 46.539866 seconds, 27.5KB/s
/ # sleep 30
/ # dd if=3D/dev/mmcblk0 of=3D/dev/null bs=3D128k count=3D10
10+0 records in
10+0 records out
1310720 bytes (1.3MB) copied, 46.540215 seconds, 27.5KB/s


So it does the right thing with decreasing the clock rate in face of
problems, I just can't see it clocking it back up...

Cheers!

Pawe=C5=82



