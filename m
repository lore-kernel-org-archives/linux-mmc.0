From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Wed, 8 Jun 2011 10:20:00 +0100
Message-ID: <BANLkTikvdm=RLoY38xrvVAF5Zo9qCSa4hg@mail.gmail.com>
References: <20110605123852.BC6F39D401C@zog.reactivated.net>
	<BANLkTimus7C-=_b2hgdfakU6Dt9=FgzyrQ@mail.gmail.com>
	<BANLkTin=+QGN=6_YjH8uEyZBbnTjuEXDjA@mail.gmail.com>
	<BANLkTi=-ZRVLqrmriGOV7YGXHHvJHTmkzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57657 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773Ab1FHJUB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2011 05:20:01 -0400
Received: by pzk9 with SMTP id 9so154607pzk.19
        for <linux-mmc@vger.kernel.org>; Wed, 08 Jun 2011 02:20:01 -0700 (PDT)
In-Reply-To: <BANLkTi=-ZRVLqrmriGOV7YGXHHvJHTmkzg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

On 7 June 2011 21:52, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Uhm, strange. Maybe this has something to do with the sd8686's reset
> line which you are not toggling ?

The GPIO reset line doesn't seem to make any difference here.

> Btw, the previous patch which you sent didn't have this reset command,
> and the patch did work for you. What has changed in this respect ?

In the first patch I sent I had only tested basic power-up after
probe, and found it to be working. Then I tested the other scenarios
listed in my last mail - basically powering it off and on *again* -
and found them to be broken, but fixed by further mirroring what
existing non-rpm code would do in order to power up a SD card.

Daniel
