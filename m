From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: Linux v5.0-rc7: bcm2835 MMC issues
Date: Sun, 24 Feb 2019 20:03:10 +0100 (CET)
Message-ID: <155745885.93258.1551034990363@email.ionos.de>
References: <20190224150746.GC26495@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190224150746.GC26495-4/PLUo9XfK9owWHViPbQSXlKr5M7+etX9Sl0XMgJPXI@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Aaro,

> Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org> hat am 24. Februar 2019 um 16:07 geschrieben:
> 
> 
> Hi,
> 
> After upgrading from v4.20 -> v5.0-rc7, I'm getting MMC issues on
> RPi3. Below is one example, system just ends up being completely freezed
> after couple hours into GCC bootstrap (passed fine with v4.20).
> 
> Happened three times already (also after replacing the MMC card just
> in case).
> 

thanks for your report. 

Can you give us a more detailed test scenario?
How long does it take until the issue occur?
Did you already tested v4.20.12 or only v4.20?
Does the issue occur in v5.0-rc7 if you make sdhost use PIO mode (CONFIG_DMA_BCM2835=m)?
