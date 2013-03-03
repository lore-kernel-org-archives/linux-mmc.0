From: Daniel Palmer <daniel@0x0f.com>
Subject: atmel-mci: issues after upgrading to linux 3.8
Date: Sun, 3 Mar 2013 20:59:00 +0900
Message-ID: <CAFr9PX=h0gzBaJF0nMAbHO_UBx1VA79jiu2VTYaUQ1Q6VJipAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:59384 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825Ab3CCL7B (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Mar 2013 06:59:01 -0500
Received: by mail-pb0-f44.google.com with SMTP id wz12so2553251pbc.31
        for <linux-mmc@vger.kernel.org>; Sun, 03 Mar 2013 03:59:00 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi all,

Hopefully this is the right place for this. Maybe it should go to a
list more related to the at91 stuff. Please tell me if that is the
case.
I'm not subscribed so please CC me.

I have an Atmel sam9g45 based machine that has been running 3.4.0-rc4
for a long time without any major issues.
I decided to try out 3.8 this weekend and now have some issues using a
SD card via the atmel-mci driver.
It seems whenever something does a lot of transfers that the card stops working;

root@ein:~# hdparm -Tt /dev/mmcblk0

/dev/mmcblk0:
 Timing cached reads:   106 MB in  2.00 seconds =  52.94 MB/sec
 Timing buffered disk reads: [ 1422.480000] mmcblk0: error -115
sending stop command, original cmd response 0x900, card status 0xb00
[ 1422.480000] mmcblk0: error -110 transferring data, sector 54784, nr
256, cmd response 0x900, card status 0xb00
[ 1422.480000] mmcblk0: retrying using single block read
[ 1424.490000] mmcblk0: error -110 transferring data, sector 54784, nr
256, cmd response 0x900, card status 0x0
[ 1424.500000] end_request: I/O error, dev mmcblk0, sector 54784
[ 1426.890000] mmcblk0: error -110 transferring data, sector 54785, nr
255, cmd response 0x900, card status 0x0
[ 1426.900000] end_request: I/O error, dev mmcblk0, sector 54785

I'm not sure what is triggering the issue. Sometimes the machine will
boot into Debian and run for a while without issue and sometimes it
will start playing up just after init starts. One thing I have noticed
is that if I can actually manage to warm reboot the machine and boot
back into the working 3.4.0-rc4 kernel the same issue starts happening
there too.

I thought it could be because of the SD failing so I tried another
card I had around and I bought a new card today. There didn't seem to
be any change with either card. I'm not familiar with the mmc
subsystem at all so I don't know where to start on debugging this. I
have the mmc debugging option turned on and can see lots of output
about the states the driver is going through but I couldn't see
anything that suggested why it is failing. Any pointers on how to
approach fixing this would be appreciated.

Cheers,

Daniel
