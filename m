From: Praveen Krishnan <praveen.gk@gmail.com>
Subject: Re: DDR eMMC write failures
Date: Fri, 4 Nov 2011 17:26:34 -0700
Message-ID: <CAHzg1A_igBoJ01eNzS5HX3LAAWo7tkTtmdbh8ACASt5r9LvbLg@mail.gmail.com>
References: <CAHzg1A-7RNthipDredO4KSrC+bM0nqLuhWaw1cveFzzfXd2k3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64619 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117Ab1KEA0g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2011 20:26:36 -0400
Received: by faao14 with SMTP id o14so3201428faa.19
        for <linux-mmc@vger.kernel.org>; Fri, 04 Nov 2011 17:26:35 -0700 (PDT)
In-Reply-To: <CAHzg1A-7RNthipDredO4KSrC+bM0nqLuhWaw1cveFzzfXd2k3Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

I am seeing some very strange things.

When I do

Dd if=3D/dev/zero of=3D/dev/mmcblk0 bs=3D512k count=3D200 (it fails whe=
n
writing about 100MB of data with a crc error)

When I do
Dd if=3D/dev/zero of=3D/dev/mmcblk0 bs=3D64k count=3D3000 (it fails onl=
y after
125 MB of data with a crc error)

When I do

Dd if=3D/dev/zero of=3D/dev/mmcblk0 bs=3D32k count=3D16000 (it fails wh=
en I
try to write 500MB of data, but good until 375MB of data)

Any ideas what I am running into?

Thanks,
Praveen


On Wed, Nov 2, 2011 at 4:51 PM, Praveen Krishnan <praveen.gk@gmail.com>=
 wrote:
> Hello all,
>
> I am working on getting the DDR50 mode up and running for the eMMC
> cards. =A0I am running into some weird CRC error cases. =A0Initially,=
 I
> thought that everything works fine, but when I stress test it with
> large amounts of data (more than 100MB of writes), I notice that my
> console is spewed with venomous error messages. =A0I get a CRC error =
and
> every now and then, I also see this message "Got data interrupt even
> though no data operation was in progress" and "Buffer I/O error" and
> so on.
>
> Can anybody give any pointers as to what could be causing this?
>
> Thanks a lot,
> Praveen
>
