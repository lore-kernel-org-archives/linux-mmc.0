From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] mmc: allow mmc_alloc_host() and tmio_mmc_host_alloc()
Date: Thu, 10 Nov 2016 14:35:59 +0100
Message-ID: <20161110133559.GA10191@kroah.com>
References: <1478784263-18777-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1478784263-18777-1-git-send-email-yamada.masahiro@socionext.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sascha Sommer <saschasommer@freenet.de>, Johan Hovold <johan@kernel.org>, Sonic Zhang <sonic.zhang@analog.com>, devel@driverdev.osuosl.org, Russell King <linux@armlinux.org.uk>, Jaehoon Chung <jh80.chung@samsung.com>, Chen-Yu Tsai <wens@csie.org>, Pierre Ossman <pierre@ossman.eu>, Harald Welte <HaraldWelte@viatech.com>, Alex Dubov <oakad@yahoo.com>, adi-buildroot-devel@lists.sourceforge.net, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, linux-mediatek@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, Tony Olech <tony.olech@elandigitalsystems.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, linux-usb@vger.kernel.org, linux-mm
List-Id: linux-mmc@vger.kernel.org

On Thu, Nov 10, 2016 at 10:24:21PM +0900, Masahiro Yamada wrote:
> 
> sdhci_alloc_host() returns an error pointer when it fails.
> but mmc_alloc_host() cannot.
> 
> This series allow to propagate a proper error code
> when host-allocation fails.

Why?  What can we really do about the error except give up?  Why does
having a explicit error value make any difference to the caller, they
can't do anything different, right?

I suggest just leaving it as-is, it's simple, and you don't have to mess
with PTR_ERR() anywhere.

thanks,

greg k-h
