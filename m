From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Wed, 8 Jun 2011 12:33:53 +0300
Message-ID: <BANLkTinbqoPOMuL30ksmDJEtM2RebAhksQ@mail.gmail.com>
References: <20110605123852.BC6F39D401C@zog.reactivated.net>
 <BANLkTimus7C-=_b2hgdfakU6Dt9=FgzyrQ@mail.gmail.com> <BANLkTin=+QGN=6_YjH8uEyZBbnTjuEXDjA@mail.gmail.com>
 <BANLkTi=-ZRVLqrmriGOV7YGXHHvJHTmkzg@mail.gmail.com> <BANLkTikvdm=RLoY38xrvVAF5Zo9qCSa4hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65394 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768Ab1FHJeO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2011 05:34:14 -0400
Received: by wya21 with SMTP id 21so206601wya.19
        for <linux-mmc@vger.kernel.org>; Wed, 08 Jun 2011 02:34:13 -0700 (PDT)
In-Reply-To: <BANLkTikvdm=RLoY38xrvVAF5Zo9qCSa4hg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Wed, Jun 8, 2011 at 12:20 PM, Daniel Drake <dsd@laptop.org> wrote:
> In the first patch I sent I had only tested basic power-up after
> probe, and found it to be working. Then I tested the other scenarios
> listed in my last mail - basically powering it off and on *again* -
> and found them to be broken, but fixed by further mirroring what
> existing non-rpm code would do in order to power up a SD card.

Sounds like you didn't power the card off then in the driver after probe ?

Can you show the diff with which you did this experiment ?

There is no difference between powering the card up in sdio_bus_probe
to powering it up later in the driver. If the card was indeed powered
off beforehand, then the latter should work too. Your reset command
strongly suggests that wasn't the case.
