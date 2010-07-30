From: Linus Walleij <linus.walleij@stericsson.com>
Subject: Re: [PATCH] mmc: only set blockaddressed for > 2GiB cards
Date: Fri, 30 Jul 2010 19:28:44 +0200
Message-ID: <AANLkTin-EGaq9q0ATgRfm=XKTgJ7EYT_Q-Ruzr_OQXsY@mail.gmail.com>
References: <1277194762-21399-1-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1277194762-21399-1-git-send-email-rabin.vincent@stericsson.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, Hanumath Prasad <hanumath.prasad@stericsson.com>, Rabin Vincent <rabin.vincent@stericsson.com>
List-Id: linux-mmc@vger.kernel.org

2010/6/22 Rabin Vincent <rabin.vincent@stericsson.com>:

> From: Hanumath Prasad <hanumath.prasad@stericsson.com>
>
> A non-zero value of SEC_COUNT does not indicate that the card is sect=
or
> addressed. =A0According to the MMC specification, cards with a densit=
y
> greater than 2GiB are sector addressed.

What's happening with this beauty? Andrew would you mind
picking this one up please?

Yours,
Linus Walleij
