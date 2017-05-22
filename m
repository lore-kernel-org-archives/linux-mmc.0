From: Linus Walleij <linus.walleij@linaro.org>
Subject: SD combo cards: do you have them? do you use them?
Date: Mon, 22 May 2017 16:44:53 +0200
Message-ID: <CACRpkdaHb3Yxp1-xc3W42hDH0x89kUXR4jCc2q2C3QY1mktq-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:35019 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934376AbdEVOoy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 May 2017 10:44:54 -0400
Received: by mail-it0-f44.google.com with SMTP id c15so153178698ith.0
        for <linux-mmc@vger.kernel.org>; Mon, 22 May 2017 07:44:54 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Michal Miroslaw <mirq-linux@rere.qmqm.pl>

SD combo cards are cards that combine SD with an SDIO
function, such as a memory card that also provides a WiFi
interface.

In my untrained view, these combo cards, just like stand-alone
SDIO cards for WiFi, rose to fame between the years 2000
and 2011 with the advent of Palm Pilots and iPAQ handhelds
featuring a SD slot but no USB slot. It was thus the one
standardized connector on the device and it could take one
card only.

Support for SD combo card was added by Michal Miroslaw
in 2010, and it was merged by Andrew Morton before Ulf
took over as MMC/SD maintainer.

So: are people using these cards?

I am NOT looking to delete the support for them. I am looking
for use cases and getting the right hardware.

What kind of hardware combining SD storage and SDIO with
SD combo cards are just working with Linux? What are
people using for this? What cards do I need to obtain to
test things end-to-end with Linux without out-of-tree drivers?

Yours,
Linus Walleij
