From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc/sdio: don't allow interface to runtime-suspend until
 probe is finished.
Date: Mon, 5 Dec 2011 21:37:07 +0200
Message-ID: <CAK=WgbbqgAYZ8uurf+xVyCxfZxoHcLdytxzdUNtoP9VNYPd57A@mail.gmail.com>
References: <20111205125416.6093ecd8@notabene.brown> <CAK=Wgbb-6eV6aDxTdi3qFLZmu0cHSZvHRUpUEr3YQ=4tO5sCPw@mail.gmail.com>
 <20111206060654.0e8bebe0@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111206060654.0e8bebe0@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-mmc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Daniel Drake <dsd@laptop.org>, Joe Woodward <jw@terrafix.co.uk>, Chris Ball <cjb@laptop.org>, Bing Zhao <bzhao@marvell.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, Dec 5, 2011 at 9:06 PM, NeilBrown <neilb@suse.de> wrote:
> Challenge accepted.

cool :)

> Even if I don't find a better solution, this seems backwards. =A0Sure=
 the
> default should be that PM is enabled, but individual board can reques=
t no
> PM on MMC interfaces where it is a problem.

I somewhat tend to pick a white listing approach, so we don't keep on
inflicting further pain on random sdio users (at least until we learn
more about the issues at hand), but I wouldn't object black listing.

> The chip has a requirement that the reset line is held down during po=
wer-on,
> and raised shortly after (I don't know exactly how short). =A0So if y=
ou just
> remove power and give it back, the chip doesn't come up properly.

Well, not according to Bing Zhao from Marvell:

http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg08257.html

Though I agree that if we do find this reset line helping (and get it
to work cleanly with the help of some regulator code), the solution
might be much more robust.

> "It *should be* perfectly fine ..." :-)

heh, yeah :)

> We just have to make sure the bug powers up the card properly.
> Maybe I need to create a virtual regulator that powers on the real re=
gulator,
> then raises the reset line. =A0I wonder how hard that is.

Btw did you try toggling the reset line manually and see if it really h=
elps ?

> I'll spend some more time on this and get back to you - probably next=
 week.

Very cool, thanks a lot.

Ohad.
