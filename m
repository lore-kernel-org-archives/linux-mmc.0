From: Daniel Drake <dsd@laptop.org>
Subject: Re: SDIO runtime crash on resume
Date: Fri, 29 Oct 2010 15:48:17 +0100
Message-ID: <AANLkTik6y-_=TZb9qbDf66C4q+eoiZbvCZtrtcAAKYpj@mail.gmail.com>
References: <AANLkTikVuQx+hUX8onLVdHW1mhfbH7MZJqsHt0s-baiA@mail.gmail.com>
	<AANLkTi=0oL38cmbGJ3sfE876ZxJUfrKK+wTs5+JBTR_r@mail.gmail.com>
	<AANLkTinjXQy9Hcu68DmQ-Xq59P=PNq==m1FYKviz1Pe3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45087 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932515Ab0J2OsT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Oct 2010 10:48:19 -0400
Received: by wwe15 with SMTP id 15so3364993wwe.1
        for <linux-mmc@vger.kernel.org>; Fri, 29 Oct 2010 07:48:18 -0700 (PDT)
In-Reply-To: <AANLkTinjXQy9Hcu68DmQ-Xq59P=PNq==m1FYKviz1Pe3@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On 28 October 2010 15:39, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> - What is your mmc host ? sdhci-pci presumably ? I might be able to
> get such hardware.. But not before next week (LPC).. Hey any chance
> you or Chris plan to attend LPC with this setup ? I'm going to be
> there and if I had your setup with a reproducible bug that would make
> this very easy to fix...

Yes, it's sdhci-pci.

> - Just for general knowledge - as soon as you load your driver
> (libertas, right ?) - was your card powered up and correctly
> configured (sdio clock/voltage/bus width. again check with
> /sys/kernel/debug/mmc2/ios) ?

No driver for this hardware was loaded.

> I assume there are no failures before it ? the system was correctly suspended ?

It looked that way.

Config is here:
http://dev.laptop.org/~dsd/20101029/xo1p5-config
Note that anything built as a module is not available on the setup in
question where the bug was found. So =m may as well say "is not set"

If you still need it, I'll try and get the other info to you soon.

Daniel
