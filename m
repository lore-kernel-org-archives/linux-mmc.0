From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Wed, 8 Jun 2011 00:01:31 +0300
Message-ID: <BANLkTimR2e23mNQYLtcjW4wHVDsu6vfETQ@mail.gmail.com>
References: <20110605123852.BC6F39D401C@zog.reactivated.net>
 <BANLkTimus7C-=_b2hgdfakU6Dt9=FgzyrQ@mail.gmail.com> <BANLkTin=+QGN=6_YjH8uEyZBbnTjuEXDjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45905 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756688Ab1FGVBx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2011 17:01:53 -0400
Received: by wwa36 with SMTP id 36so5355023wwa.1
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jun 2011 14:01:52 -0700 (PDT)
In-Reply-To: <BANLkTin=+QGN=6_YjH8uEyZBbnTjuEXDjA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Tue, Jun 7, 2011 at 7:41 PM, Daniel Drake <dsd@laptop.org> wrote:
> Also, the most frustrating thing when working on this issue is that
> the codepaths for powering up a SD card between the following 3
> situations are significantly different:
> =A01. Power up and probe during boot
> =A02. Resume from suspend
> =A03. Power up after runtime suspend
>
> It feels like there should be a lot more in common here.

Definitely agree. I also suggested this in my first reply to you on
our other thread:

http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg08193.html
