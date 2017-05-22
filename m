From: Michal Miroslaw <mirq-linux@rere.qmqm.pl>
Subject: Re: SD combo cards: do you have them? do you use them?
Date: Mon, 22 May 2017 23:03:28 +0200
Message-ID: <20170522210327.faifytawwftvydzx@rere.qmqm.pl>
References: <CACRpkdaHb3Yxp1-xc3W42hDH0x89kUXR4jCc2q2C3QY1mktq-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([84.10.57.10]:36880 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933017AbdEVVIy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 22 May 2017 17:08:54 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdaHb3Yxp1-xc3W42hDH0x89kUXR4jCc2q2C3QY1mktq-Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Mon, May 22, 2017 at 04:44:53PM +0200, Linus Walleij wrote:
> SD combo cards are cards that combine SD with an SDIO
> function, such as a memory card that also provides a WiFi
> interface.
> 
> In my untrained view, these combo cards, just like stand-alone
> SDIO cards for WiFi, rose to fame between the years 2000
> and 2011 with the advent of Palm Pilots and iPAQ handhelds
> featuring a SD slot but no USB slot. It was thus the one
> standardized connector on the device and it could take one
> card only.
> 
> Support for SD combo card was added by Michal Miroslaw
> in 2010, and it was merged by Andrew Morton before Ulf
> took over as MMC/SD maintainer.
> 
> So: are people using these cards?
> 
> I am NOT looking to delete the support for them. I am looking
> for use cases and getting the right hardware.
> 
> What kind of hardware combining SD storage and SDIO with
> SD combo cards are just working with Linux? What are
> people using for this? What cards do I need to obtain to
> test things end-to-end with Linux without out-of-tree drivers?

When I implemented SD-Combo support, I was working on a prototype
SDIO-serial with uSD memory slot. IIRC this was working fine under
Linux (even without the memory card, when SDIO part nevertheless
indicated its presence). The project have not taken off to
production, though.

Best Regards,
Micha³ Miros³aw
