From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [PATCH 4/4] mmc: add MMC_QUIRK_NONSTD_FUNC_IF
Date: Wed, 5 Jan 2011 10:10:34 +0100
Message-ID: <AANLkTinrz+qonuPSo-HOJ2zmjwmyn0YJkMTg+MwKXN2s@mail.gmail.com>
References: <1294175416-12358-1-git-send-email-ohad@wizery.com>
	<1294175416-12358-4-git-send-email-ohad@wizery.com>
	<AANLkTimg7DU=1bYv-k2-WwiSurHmsrjN_+zb_=irZv9n@mail.gmail.com>
	<AANLkTi=HyXUAMALQD4MMZrw=Por8bTkJ6HxSC10UrDt4@mail.gmail.com>
	<AANLkTikwaSmwy2b6if-=BhU9c5Ea_9xyOdKDC0VhpBox@mail.gmail.com>
	<AANLkTik8FNxAhGz8Dzj=h4S1hyDGUYw4HSAhzwHWfWpG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:56629 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab1AEJKe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Jan 2011 04:10:34 -0500
Received: by pxi15 with SMTP id 15so2724639pxi.19
        for <linux-mmc@vger.kernel.org>; Wed, 05 Jan 2011 01:10:34 -0800 (PST)
In-Reply-To: <AANLkTik8FNxAhGz8Dzj=h4S1hyDGUYw4HSAhzwHWfWpG@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, "DE CESCO, Jonathan" <jonathanc@ti.com>

On Wed, Jan 5, 2011 at 12:34 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Wed, Jan 5, 2011 at 1:25 AM, Pierre Tardy <tardyp@gmail.com> wrote:
>> There is no such platform data in intel_mid platforms.. Sound like
>> another platform hack will be needed for wl1271 to be integrated. :-(
>
> John (cc'ed) ported this to your platform and can share the solution
> with you; IIRC the idea was the same: identify the card according to
> the slot id (this is reasonable because the card is nonremovable) and
> set it as MMC_QUIRK_NONSTD_FUNC_IF.
Well, we dont do it like this in intel_mid. Every platform quirk has
to come somehow from the firmware (SFI), and there is no such
descriptor to my knowledge. Lets see what John is proposing...


>> Our first idea to resolve this problem was to hardcode wl1273 vendor
>> id/product id in a black list table near read_fbr...
>
> I'm not sure we want to hardcode such details in the SDIO core itself
> (think of how it would look if more devices will show up..).

Yes, that's why I thought of a table, we might want to make this more
generic, and, as you are proposing more than one quirk those few days
for cards, we could add those quirks in struct sdio_device_id, like
they do for PCI...


The thing is that the semantic of your solution is wrong. You want to say:
Hey! wl1271 is broken
and you actually say:
Hey! the card in slot named "external" of omap4 zoom is brocken.


Regards,
Pierre
