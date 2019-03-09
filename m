From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: Linux v5.0-rc7: bcm2835 MMC issues
Date: Sat, 9 Mar 2019 11:57:57 +0100 (CET)
Message-ID: <1685719010.348465.1552129077871@email.ionos.de>
References: <20190224150746.GC26495@darkstar.musicnaut.iki.fi>
 <155745885.93258.1551034990363@email.ionos.de>
 <20190226011509.GB31163@darkstar.musicnaut.iki.fi>
 <06528ceb-ff1d-626b-f520-477b0ea49d6f@i2se.com>
 <20190227185101.GA28051@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190227185101.GA28051-4/PLUo9XfK9owWHViPbQSXlKr5M7+etX9Sl0XMgJPXI@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


> Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org> hat am 27. Februar 2019 um 19:51 geschrieben:
> 
> 
> On Tue, Feb 26, 2019 at 09:31:14AM +0100, Stefan Wahren wrote:
> > it will take some time for to setup this test scenario. Could you please
> > do me a favor and test 4.20.12 which has some backports of recent mmc /
> > DMA fixes.
> 
> Both 4.20 and 4.20.12 work fine. Only 5.0-rc fails reliably.

I tried to reproduce the issue by compiling gcc and using stress on Raspberry Pi 3 (arm64/defconfig) with Arch Linux ARM without any luck.

Were you able to reproduce the issue using stress?

> 
> A.
