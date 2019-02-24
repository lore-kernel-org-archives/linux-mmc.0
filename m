From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: Re: Linux v5.0-rc7: bcm2835 MMC issues
Date: Sun, 24 Feb 2019 22:15:42 +0200
Message-ID: <20190224201542.GA31163@darkstar.musicnaut.iki.fi>
References: <20190224150746.GC26495@darkstar.musicnaut.iki.fi>
 <155745885.93258.1551034990363@email.ionos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <155745885.93258.1551034990363-uEpKuDZ350hmhno068Nerg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Sun, Feb 24, 2019 at 08:03:10PM +0100, Stefan Wahren wrote:
> > Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org> hat am 24. Februar 2019 um 16:07 geschrieben:
> > After upgrading from v4.20 -> v5.0-rc7, I'm getting MMC issues on
> > RPi3. Below is one example, system just ends up being completely freezed
> > after couple hours into GCC bootstrap (passed fine with v4.20).
> > 
> > Happened three times already (also after replacing the MMC card just
> > in case).
> > 
> 
> thanks for your report. 
> 
> Can you give us a more detailed test scenario?

Well, I have minimal arm64 rootfs + swap on MMC. Then I extract GCC
8.3.0 sources and try to do the compiler bootstrap:

  mkdir build
  cd build
  ../gcc-8.3.0/configure <long list of options here>
  make -j4

Then just wait. :)

> How long does it take until the issue occur?

I would say 1-2 hours. The serial log shows ~6500 seconds, and I started the
build right after the boot.

My guess is that the issue occurs during the stage in the build where there
is some really heavy swapping going on (almost 1 GB swap used).

> Did you already tested v4.20.12 or only v4.20?

Only v4.20, and it was already few weeks ago when I did the GCC 8.2.0
bootstrap. It went fine (5 hours build + 12 hours testsuite) without
any errors in dmesg.

> Does the issue occur in v5.0-rc7 if you make sdhost use PIO mode
> (CONFIG_DMA_BCM2835=m)?

I have currently test running where I moved the file system and swap from
SD card slot behind an USB SD card adapter (still the same physical SD
card). And that has been running fine for 4 hours already. I want to
first see if that one finishes properly, then I can start a new test
using sdhost and PIO mode.

A.
