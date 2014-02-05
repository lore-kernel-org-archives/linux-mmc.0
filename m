From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 05/17] mmc: mmci: Put the device into low power state at system suspend
Date: Wed, 05 Feb 2014 12:08:38 -0800
Message-ID: <87ob2ls4op.fsf@paris.lan>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
	<1391529538-21685-6-git-send-email-ulf.hansson@linaro.org>
	<8738jyu1h9.fsf@paris.lan>
	<CACRpkdZt5+t7b0_a__2kJP4V9PS2cyXmguWrST+fzbKCnosi7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZt5+t7b0_a__2kJP4V9PS2cyXmguWrST+fzbKCnosi7g@mail.gmail.com>
	(Linus Walleij's message of "Wed, 5 Feb 2014 13:49:49 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alessandro Rubini <rubini@unipv.it>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Mark Brown <broonie@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-spi@vger.kernel.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Tue, Feb 4, 2014 at 8:22 PM, Kevin Hilman <khilman@linaro.org> wrote:
>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>>
>>> Due to the available runtime PM callbacks, we are now able to put our
>>> device into low power state at system suspend.
> (...)
>> I'm trying to thing of a good reason to not make PM_SLEEP depend on
>> PM_RUNTIME for platforms like this.
>
> Isn't the typical Android platform using PM_SLEEP without using
> PM_RUNTIME?

No, most Android platforms that I'm aware of use both extensively.

Kevin
