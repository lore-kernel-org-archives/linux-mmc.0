From: John Ewalt <johnewalt@gmail.com>
Subject: (unknown)
Date: Sun, 16 Apr 2017 18:43:52 -0600
Message-ID: <CAE+8Nk+C3eBq1LdkzzcfecHkkcZCDfRuJcMeGMXKNQp29fdbog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37860 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756803AbdDQAny (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 16 Apr 2017 20:43:54 -0400
Received: by mail-wm0-f43.google.com with SMTP id u2so24132518wmu.0
        for <linux-mmc@vger.kernel.org>; Sun, 16 Apr 2017 17:43:53 -0700 (PDT)
Subject: 
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi all,

I am not sure if this is the right way to ask a question about SD cards, so
please correct me as I am new to Linux kernel development.

I am currently working with a Intel Joule SOM and development board
(Broxton M core) and when I insert the SD card, it is recognized as a
SDR104 UHS-I card.  Since this host has the MMC_CAP_AGGRESSIVE_PM bit set,
it is suspended.  That all works as expected.  When the card is resumed,
the OCR is read expecting bit 24 (switch to 1.8 V accepted (S18A)) to be
set, but it is clear as the card is still at 1.8v signaling since it was
never powered down during the suspend.

I see 3 ways to solve this problem:
First, power down the card during suspend.  I think this is the intended
behavior but there is no power manager registered to this host (as
compiled) and I'm not sure how to add one, let alone the hardware changes
necessary to implement the powering down of the sd card.

Second, don't suspend (I have tested this and it works as the card is not
suspended)

Third, the host could remember that the card was at 1.8v signaling and if
it will not "switch" to 1.8v, assume it is at 1.8v and go through the
uhs_setup anyway.  I have tried this too and it works for UHS cards, but I
doubt it would be the right change.


I would appreciate any help or direction anyone can provide as I would
really like to use my fast card at the full data rates.  I am currently
setup to test any suggestions you have.

Thank you all,

-John
