From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 4/4] mmc: add MMC_QUIRK_NONSTD_FUNC_IF
Date: Wed, 5 Jan 2011 11:40:07 +0200
Message-ID: <AANLkTik7yr6bXcGpNt09zoXU_P03RE=vo2HepDa2fhuW@mail.gmail.com>
References: <1294175416-12358-1-git-send-email-ohad@wizery.com>
 <1294175416-12358-4-git-send-email-ohad@wizery.com> <AANLkTimg7DU=1bYv-k2-WwiSurHmsrjN_+zb_=irZv9n@mail.gmail.com>
 <AANLkTi=HyXUAMALQD4MMZrw=Por8bTkJ6HxSC10UrDt4@mail.gmail.com>
 <AANLkTikwaSmwy2b6if-=BhU9c5Ea_9xyOdKDC0VhpBox@mail.gmail.com>
 <AANLkTik8FNxAhGz8Dzj=h4S1hyDGUYw4HSAhzwHWfWpG@mail.gmail.com> <AANLkTinrz+qonuPSo-HOJ2zmjwmyn0YJkMTg+MwKXN2s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f194.google.com ([209.85.214.194]:55681 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab1AEJk2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Jan 2011 04:40:28 -0500
Received: by iwn42 with SMTP id 42so7660345iwn.1
        for <linux-mmc@vger.kernel.org>; Wed, 05 Jan 2011 01:40:27 -0800 (PST)
In-Reply-To: <AANLkTinrz+qonuPSo-HOJ2zmjwmyn0YJkMTg+MwKXN2s@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, "DE CESCO, Jonathan" <jonathanc@ti.com>

On Wed, Jan 5, 2011 at 11:10 AM, Pierre Tardy <tardyp@gmail.com> wrote:
> Well, we dont do it like this in intel_mid. Every platform quirk has
> to come somehow from the firmware (SFI), and there is no such
> descriptor to my knowledge. Lets see what John is proposing...

I think that John shared it with you this morning. I haven't looked
into your platform too much, but if it's using upstream code, let's
take the discussion to the list (by rebasing John's solution and
posting it here).

> Yes, that's why I thought of a table, we might want to make this more
> generic, and, as you are proposing more than one quirk those few days
> for cards, we could add those quirks in struct sdio_device_id, like
> they do for PCI...

Interesting. Care to send a patch for review ?

> The thing is that the semantic of your solution is wrong. You want to say:
> Hey! wl1271 is broken
> and you actually say:
> Hey! the card in slot named "external" of omap4 zoom is brocken.

Not exactly; I do say that the specific wl1271 card is quirky, but I
must set it early before the card is probed, so I use the host
controller's quirks callback ->init_card().

I agree that a quirks table, if done right, might be easier and won't
involve the board in the process; let's try to explore it.

Thanks,
Ohad.
>
>
> Regards,
> Pierre
>
