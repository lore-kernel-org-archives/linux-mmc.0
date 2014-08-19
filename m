From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/4] mmc: host: switch OF parser to use gpio descriptors
Date: Mon, 18 Aug 2014 22:27:40 -0500
Message-ID: <CACRpkdasvUXgyJ24OR3tz83Qwt+RYXGMTrKh82ER-g=YX=e9Zg@mail.gmail.com>
References: <1407864355-21545-1-git-send-email-linus.walleij@linaro.org>
	<1407864355-21545-3-git-send-email-linus.walleij@linaro.org>
	<20140818194655.GA2565@schnuecks.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20140818194655.GA2565@schnuecks.de>
Sender: linux-gpio-owner@vger.kernel.org
To: Simon Baatz <gmbnomis@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, Aug 18, 2014 at 2:46 PM, Simon Baatz <gmbnomis@gmail.com> wrote:
> On Tue, Aug 12, 2014 at 07:25:54PM +0200, Linus Walleij wrote:
>> This switches the central MMC OF parser to use gpio descriptors
>> instead of grabbing GPIOs explicitly from the device tree.
>> This strips out an unecessary use of the integer-based GPIO
>> API that we want to get rid of, cuts down on code as the
>> gpio descriptor code will handle active low flags.
>>
>> As it is in no way a bug not to supply CD/WP GPIOs the messages
>> about them not being specified have been depromoted from
>> dev_err() to dev_dbg().
>
> I think the intention of the current code is to issue an
> error if a valid GPIO was specified but could not be obtained.

OK I'll post a fixup.

Yours,
Linus Walleij
