From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 0/2] mmc: allow mmc_alloc_host() and tmio_mmc_host_alloc()
Date: Fri, 11 Nov 2016 12:19:05 +0900
Message-ID: <CAK7LNAThxsE3QW4EdPUyxmxbnt_PPjeogi8Fox5AHkddsuu-Sg@mail.gmail.com>
References: <1478784263-18777-1-git-send-email-yamada.masahiro@socionext.com>
 <20161110133559.GA10191@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20161110133559.GA10191@kroah.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sascha Sommer <saschasommer@freenet.de>, Johan Hovold <johan@kernel.org>, Sonic Zhang <sonic.zhang@analog.com>, devel@driverdev.osuosl.org, Russell King <linux@armlinux.org.uk>, Jaehoon Chung <jh80.chung@samsung.com>, Chen-Yu Tsai <wens@csie.org>, Pierre Ossman <pierre@ossman.eu>, Harald Welte <HaraldWelte@viatech.com>, Alex Dubov <oakad@yahoo.com>, adi-buildroot-devel@lists.sourceforge.net, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Ben Dooks <ben-linux@fluff.org>, Tony Olech <tony.olech@elandigitalsystems.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Nicol
List-Id: linux-mmc@vger.kernel.org

2016-11-10 22:35 GMT+09:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> On Thu, Nov 10, 2016 at 10:24:21PM +0900, Masahiro Yamada wrote:
>>
>> sdhci_alloc_host() returns an error pointer when it fails.
>> but mmc_alloc_host() cannot.
>>
>> This series allow to propagate a proper error code
>> when host-allocation fails.
>
> Why?  What can we really do about the error except give up?  Why does
> having a explicit error value make any difference to the caller, they
> can't do anything different, right?


The error code is shown in the console, like

  probe of 5a000000.sdhc failed with error -12


The proper error code will give a clue
why the driver failed to probe.


> I suggest just leaving it as-is, it's simple, and you don't have to mess
> with PTR_ERR() anywhere.


Why?

Most of driver just give up probing for any error,
but we still do ERR_PTR()/PTR_ERR() here and there.
I think this patch is the same pattern.

If a function returns NULL on failure, we need to think about
"what is the most common failure case".

Currently, MMC drivers assume -ENOMEM is the best
fit for mmc_alloc_host(), but the assumption is fragile.

Already, mmc_alloc_host() calls a function
that returns not only -ENOMEM, but also -ENOSPC.

In the future, some other failure cases might be
added to mmc_alloc_host().

Once we decide the API returns an error pointer,
drivers just propagate the return value from the API.
This is much more stable implementation.



-- 
Best Regards
Masahiro Yamada
