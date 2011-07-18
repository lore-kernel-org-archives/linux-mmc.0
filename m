From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: enable runtime PM by default
Date: Mon, 18 Jul 2011 05:53:15 +0300
Message-ID: <CAK=WgbZoixKQh1nj-tgERFGuDjV0O3NqCwtzad71KnmWC4_Umw@mail.gmail.com>
References: <20110717153914.A8FB49D401C@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48312 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab1GRCxg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Jul 2011 22:53:36 -0400
Received: by wyg8 with SMTP id 8so1799237wyg.19
        for <linux-mmc@vger.kernel.org>; Sun, 17 Jul 2011 19:53:35 -0700 (PDT)
In-Reply-To: <20110717153914.A8FB49D401C@zog.reactivated.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org

On Sun, Jul 17, 2011 at 6:39 PM, Daniel Drake <dsd@laptop.org> wrote:
> Now that we have improved the runtime power management powerup/powerdown
> code, we believe that MMC_CAP_POWER_OFF_CARD is no longer necessary:
> runtime PM should now work everywhere.

Let's also add:

The only hard evidence for introducing MMC_CAP_POWER_OFF_CARD was the
Marvell sd8686 wifi chip, which was believed to require external gpio
manipulation which wasn't supported by some boards.

After further investigation it was realized (and confirmed by Marvell
folks) that sd8686 requirements can be fulfilled by changing the reset
sequence itself, even if no external gpio is manipulated.

For further information, see the following thread:
http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg04289.html

> Enable this trivially for a release or two. If no problems are reported,
> we will follow up with a more extensive patch to remove this flag
> altogether. If problems are reported, we can look at whitelist/blacklist
> possibilities as before.

This is exactly how I planed to take this too, thanks.

Acked-by: Ohad Ben-Cohen <ohad@wizery.com>
