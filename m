From: Clemens Eisserer <linuxhippy@gmail.com>
Subject: Fstrim fails on raspberry pi / SD-card
Date: Fri, 10 Jan 2014 15:18:23 -0500
Message-ID: <CAFvQSYSG-JBqpgs_YjS6JmP-u-tkEH-4QXcRVPr2TaRhorSBJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:43349 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbaAJUSY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jan 2014 15:18:24 -0500
Received: by mail-ob0-f175.google.com with SMTP id uz6so5293021obc.34
        for <linux-mmc@vger.kernel.org>; Fri, 10 Jan 2014 12:18:23 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

I've read several reports of raspberry pi users which were able to
perform batch discards on their SD cards by invoking the "fstrim"
command, which in turn should be translated to an ERASE command
(cmd23). I found out some patches where commited to linux-mmc which
implement this functionality arround linux-2.6.36.

However, all I get on my raspberry (as well as on my laptop) when
running fstrim is:
> root@raspberrypi:~# fstrim -v p2/
> fstrim: mountp2/: FITRIM ioctl failed: Operation not supported

Has this functionality been disabled intentionally, or is it likely an
issue with the SD card or the driver?
In case this is hw specific, how can I find out the cause it is disabled?

Thank you in advance, Clemens
