From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: pcf857x: restore the initial line state of all pcf lines
Date: Wed, 25 Mar 2015 16:28:29 +0100
Message-ID: <CACRpkdaFXvqbo84BqBVJzoBqdejwauxhZDr+x4HgWbXehOqViw@mail.gmail.com>
References: <1418371601-22658-1-git-send-email-kishon@ti.com>
	<548F498F.7050202@ti.com>
	<549271A9.5040701@ti.com>
	<5492E09F.1000003@ti.com>
	<54AA2EB1.8090501@ti.com>
	<CACRpkdago2vWJYFmywULna6nkrbtciPZFESuuKixF0r8rSB1Sw@mail.gmail.com>
	<5506987C.3060601@ti.com>
	<CACRpkdYQv4z68HWAq0KFV1WiSgJeNzm4sosnJxXHHvQp5AqsSg@mail.gmail.com>
	<55097BF5.8080600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55097BF5.8080600@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Benoit Parrot <bparrot@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Mar 18, 2015 at 2:21 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>[Me]
>> Specify exactly what stuff may happen after the reboot notifier.
>
> okay, it's assumed the device may be used (active) till the shutdown handler
> of that particular device is called.
>
> In this particular case we are restoring the initial line state of all pcf
> lines even though we don't know if the devices connected to it are still
> being active, which might cause a contention as explained by NM [1]

OK I understand this, just that I want to know if it is a practical problem,
i.e. do you run into it? Does the system lock up?

> If the reboot notifier gets invoked after the shutdown handler then we could
> be sure that restoring the initial line state of the pcf lines wouldn't
> affect the devices connected to it.

OK so does it?

ftrace is your friend.

Yours,
Linus Walleij
