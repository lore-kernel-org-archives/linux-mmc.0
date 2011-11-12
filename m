From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: debugfs: parse all ext_csd via debug_fs
Date: Sat, 12 Nov 2011 11:25:06 +0100
Message-ID: <CACRpkdY4TnVmiU-XP9gQGVzxwV7ZHJ6Ms++_c2+7dTfNBgWLVQ@mail.gmail.com>
References: <1319468694-8773-1-git-send-email-peppe.cavallaro@st.com>
	<CAAgDR1N_CKnXo=G2oTHAShhgegMZF-nMySBuWebDPeu8VTEBKg@mail.gmail.com>
	<4EA7EEBC.2070109@st.com>
	<CAAgDR1NhqOkDZ8M18Uc6CtWtZSy153wOnuxjhQ-m7aitPwitLQ@mail.gmail.com>
	<4EAA5F02.2080702@st.com>
	<878vnmjftj.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51836 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538Ab1KLKZI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Nov 2011 05:25:08 -0500
Received: by iage36 with SMTP id e36so5055873iag.19
        for <linux-mmc@vger.kernel.org>; Sat, 12 Nov 2011 02:25:07 -0800 (PST)
In-Reply-To: <878vnmjftj.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Giuseppe CAVALLARO <peppe.cavallaro@st.com>, Sebastian Rasmussen <sebras@gmail.com>, linux-mmc@vger.kernel.org

On Sat, Nov 12, 2011 at 2:21 AM, Chris Ball <cjb@laptop.org> wrote:

> I wonder if we should start an MMC userspace tools repository contain=
ing
> code for features like the cmd passthrough ioctl, secure erase/trim/d=
iscard
> requests, and debugging output of the type this patch provides. =A0On=
 the
> other hand, maybe existing similar tools should just be modified to
> learn about how to deal with MMC?

Go for mmc-tools.git

People might have a lot of useful stuff to throw in there...
And I easily see this thing being picked up by distros.

If for nothing else it's an opportunity to exercise using P=F6ttering
and Sievers libabc as basis for some kind of userspace lib.
http://lwn.net/Articles/465093/

Just my =800.01.

Linus Walleij
