From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH] mmc: move regulator handling to core
Date: Tue, 31 Aug 2010 14:15:07 +0200
Message-ID: <AANLkTimN0cSzp8756frWvQQpaUCy+3ydVg+JYD9LxHLc@mail.gmail.com>
References: <1259844390-10541-1-git-send-email-daniel@caiaq.de>
	<20100827190306.GB20407@void.printf.net>
	<AANLkTi=20KrUy334JRmMYwK7rbaVYrYCqW-BHZYGPrwT@mail.gmail.com>
	<20100829132711.GB10233@opensource.wolfsonmicro.com>
	<AANLkTim+cOSt=kjXXh_w+b4mzCiZN76HQ3az7SJKmOxR@mail.gmail.com>
	<20100831110758.GD20849@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100831110758.GD20849@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Matt Fleming <matt@console-pimps.org>, David Brownell <dbrownell@users.sourceforge.net>, Eric Miao <eric.y.miao@gmail.com>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>, Daniel Mack <daniel@caiaq.de>, Madhusudhan <madhu.cr@ti.com>, Cliff Brake <cbrake@bec-systems.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Chris Ball <cjb@laptop.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Pierre Ossman <pierre@ossman.eu>, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-mmc@vger.kernel.org

2010/8/31 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Sun, Aug 29, 2010 at 05:30:48PM +0200, Linus Walleij wrote:
>> 2010/8/29 Mark Brown <broonie@opensource.wolfsonmicro.com>:
>
>> > This seems like the wrong approach; if there's a problem it'd seem much
>> > better to fix the core code that everything is sharing rather than
>> > factor it out - the location of the code is orthogonal to its
>> > helpfulness.
>
>> I actually did not move the essential regulator bits out just enable/disable,
>> so that these were in the sites where the regulators were actually
>> enabled/disabled in respective driver. That makes the internal
>> regulator reference count do the trick.
>
> I'm not sure what "the sites where the regulators were actually
> enabled/disabled in respective driver" are but my understanding was that
> there's a bit of an issue here in that the MMC core does not guarantee
> balanced enable/disable calls.

Yeah I figured out what you wanted and sent an updated patch, check
it out. I'll just weave in some comments from Adrian and it'll do things
the way you want it I believe.

Yours,
Linus Walleij
