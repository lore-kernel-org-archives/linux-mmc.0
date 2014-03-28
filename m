From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH v5 1/3] mfd: Add realtek USB card reader driver
Date: Fri, 28 Mar 2014 09:31:26 +0100
Message-ID: <1395995486.9520.2.camel@linux-fkkt.site>
References: <1395744293-24398-1-git-send-email-rogerable@realtek.com>
 <1395744293-24398-2-git-send-email-rogerable@realtek.com>
 <201403280231.s2S2VP8X017745@rtits1.realtek.com>
 <5334ED70.6050309@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <5334ED70.6050309@realtek.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Roger <rogerable@realtek.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driverdev-devel@linuxdriverproject.org, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, Andrew Morton <akpm@linux-foundation.org>, Lee Jones <lee.jones@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, 2014-03-28 at 11:33 +0800, Roger wrote:
> On 03/26/2014 10:36 PM, Oliver Neukum wrote:
> > On Tue, 2014-03-25 at 18:44 +0800, rogerable@realtek.com wrote:
> >> From: Roger Tseng <rogerable@realtek.com>

> >> +	if (ret)
> >> +		goto out_init_fail;
> >> +
> >> +	/* initialize USB SG transfer timer */
> >> +	init_timer(&ucr->sg_timer);
> >> +	setup_timer(&ucr->sg_timer, rtsx_usb_sg_timed_out, (unsigned long) ucr);
> >> +#ifdef CONFIG_PM
> >> +	intf->needs_remote_wakeup = 1;
> >
> > Why?
> Our reader supports remote wake-up from card slot event(insertion, 
> removal). It should be enabled to let the driver be able to detect the 
> newly inserted card.

Interesting. This capability has been lacking for a long time.
That is cool hardware. Are you sure the upper layers implement
the event infrastructure so that devices are not polled?

> The LED is not in a permanent cut-off state after here. It is called to 
> guarantee the LED is off during suspend to save more power. It could be 
> lit up in the card host drivers(e.g. rtsx_usb_sdmmc.c) anytime whenever 
> necessary.
> 
> This has been asked may times. I'm considering putting some comment in 
> next revision.

Good idea.

	Regards
		Oliver
