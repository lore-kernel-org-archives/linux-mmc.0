From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Tue, 7 Jun 2011 23:52:40 +0300
Message-ID: <BANLkTi=-ZRVLqrmriGOV7YGXHHvJHTmkzg@mail.gmail.com>
References: <20110605123852.BC6F39D401C@zog.reactivated.net>
 <BANLkTimus7C-=_b2hgdfakU6Dt9=FgzyrQ@mail.gmail.com> <BANLkTin=+QGN=6_YjH8uEyZBbnTjuEXDjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62335 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756914Ab1FGWBD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2011 18:01:03 -0400
Received: by wya21 with SMTP id 21so3902289wya.19
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jun 2011 15:01:02 -0700 (PDT)
In-Reply-To: <BANLkTin=+QGN=6_YjH8uEyZBbnTjuEXDjA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Tue, Jun 7, 2011 at 7:41 PM, Daniel Drake <dsd@laptop.org> wrote:
> On 5 June 2011 14:48, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> Sending a reset is necessary only if we are re-initing a powered on
>> card, but in this case, we know that we just powered the card up, so
>> this is not needed.
>
> Don't ask me for an explanation, but this is required here

Uhm, strange. Maybe this has something to do with the sd8686's reset
line which you are not toggling ?

Btw, the previous patch which you sent didn't have this reset command,
and the patch did work for you. What has changed in this respect ?

>  Are you suggesting that a quirk is used to enable this reset, or
> to disable it?

To disable the CMD5 arg=0. it's not mandatory by the spec, and some
cards don't need it. It's not harmful either way, but it's just
cleaner for those cards (and it's really just adding 1 'if'
statement..).
