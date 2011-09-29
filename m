From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: slow eMMC write speed
Date: Thu, 29 Sep 2011 09:05:40 +0200
Message-ID: <CACRpkdZh-9HTTs1BnH_ncT2S10gvuODXLSG-pOjsAdJOApmaMg@mail.gmail.com>
References: <CAHzg1A9usWP8o3xjEq3yFn56bEqk_Qp0a8-2FJzoRZG1MqPRPA@mail.gmail.com>
	<CACRpkdYamRVpBbhAcgn7rXBGcgHUp7+9PCrmOUkXV1BvZ+4pDw@mail.gmail.com>
	<CAHzg1A9H31hWdEKR5+_p8HuA_oq6o8EkESpJ22kQ4e4oFDH8GQ@mail.gmail.com>
	<4E837C89.9020109@linux.intel.com>
	<CAHzg1A8Cgz8DNje_We9MKJ90E4=9BDw9XzvEQU5h2et8HPHBjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47013 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab1I2HFl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Sep 2011 03:05:41 -0400
Received: by gyg10 with SMTP id 10so257039gyg.19
        for <linux-mmc@vger.kernel.org>; Thu, 29 Sep 2011 00:05:40 -0700 (PDT)
In-Reply-To: <CAHzg1A8Cgz8DNje_We9MKJ90E4=9BDw9XzvEQU5h2et8HPHBjw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Praveen G K <praveen.gk@gmail.com>
Cc: J Freyensee <james_p_freyensee@linux.intel.com>, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jon Medhurst <jon.medhurst@linaro.org>

On Wed, Sep 28, 2011 at 10:34 PM, Praveen G K <praveen.gk@gmail.com> wr=
ote:

> The problem is I am seeing write
> speeds of about 5MBps on a Sandisk eMMC product and I can clearly see
> the time lost when measured between sending a command and receiving a
> data irq. =A0I am not sure what kind of an issue this is. =A05MBps fe=
els
> really slow but can the internal housekeeping of the card take so muc=
h
> time?

It can indeed take as much time as it wants as long as it meets
the specifications, what does your datasheet say?

If you connect a signal analyzer to your MMC bus you *will*
know for sure whether this is actually caused by the card,
of if there is some kernel irq/workqueue latency involved.

If the card is the issue, what you can do to improve
performance is to look for other eMMC vendors... ;-)

> I mean, for the usual transfers it takes about 3ms to transfer
> 64kB of data, but for the 63rd and 64th transfers, it takes 250 ms.
> The thing is this is not on a file system. =A0I am measuring the spee=
d
> using basic "dd" command to write directly to the block device.

Have you tried to make a deeper analysis of the card
characteristics using Arnd Bergmanns "flashbench" tool?
http://git.linaro.org/gitweb?p=3Dpeople/arnd/flashbench.git;a=3Dsummary

There you will see for sure if there are some problematic
read boundaries on this specific card.

Yours,
Linus Walleij
