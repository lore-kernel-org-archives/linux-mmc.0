From: Paul Mansfield <paul@mansfield.co.uk>
Subject: mmc driver read/write detect problem with Baytrail tablet
Date: Tue, 30 Jun 2015 15:13:46 +0100
Message-ID: <CAGwpYodzn4TGiCp7L1+KQgb+JreMx2y07wgRmUsDHG-3fwetLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:35826 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbbF3OOH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Jun 2015 10:14:07 -0400
Received: by wgjx7 with SMTP id x7so10972227wgj.2
        for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2015 07:14:06 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,

I am trying to get a baytrail-t based convertible tablet working with
linux, using kernel 4.1 built for 32 bit Debian Jessie. I've made
good progress, making my Toshiba Click Mini work
sufficiently well to be useable with a USB wifi adaptor (the driver
for the integrated SDIO wifi makes it unstable).

A major sticking point is that the internal microSDHC slot is always
read only; the device node /dev/mmcblk1 is read-write but when I
try and mount it the kernel complains it's not writable.

Meanwhile the tablet has a dock which has an full sized SDHC slot,
and that works perfectly. I can put cards in the internal and dock
card slots and they come up as separate devices, so they're
definitely different devices on different buses.

Is there some debug I can enable to let me find out why the driver
thinks that internal card slot is read only?

Is there some way to override the mmc driver read-only/write-protect
function to force the driver to allow writing?

Needless to say the card works fine in Windows 8.1.

thanks very much for your time

-- 
GPG key 843662C6 - Paul Mansfield <paul /at/ mansfield.co.uk>
Fingerprint = C642 3DD8 2C2A 5498 4C41  5963 6E9A 0CB0 8436 62C6
