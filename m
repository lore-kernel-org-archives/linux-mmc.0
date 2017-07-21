From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] staging: net: wireless: add ESP8089 WiFi driver
Date: Fri, 21 Jul 2017 17:01:33 +0200
Message-ID: <20170721150133.GA18198@kroah.com>
References: <20170721143502.1991-1-quentin.schulz@free-electrons.com>
 <20170721143502.1991-2-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20170721143502.1991-2-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: devel@driverdev.osuosl.org, ulf.hansson@linaro.org, baolin.wang@linaro.org, linus.walleij@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, linux-kernel@vger.kernel.org, hdegoede@redhat.com, wens@csie.org, icenowy@aosc.xyz, maxime.ripard@free-electrons.com, shawn.lin@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

On Fri, Jul 21, 2017 at 04:35:01PM +0200, Quentin Schulz wrote:
> The Espressif ESP8089 WiFi chips can be often found in cheap tablets.
> There is one in A23 Polaroid tablets for example.
> 
> The chip is often embedded as an eMMC SDIO device.
> 
> The code was taken from an out-of-tree repository and has seen a first
> pass in the cleanup process.
> 
> At the moment, there is no publicly available datasheet for this chip.
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Icenowy Zheng <icenowy@aosc.xyz>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Staging drivers need a TODO file that lists what has to be done to the
code to get it out of staging.  Why not just take a day or so and fix up
the remaining issues and get it into the "real" part of the kernel
correctly?

Also, staging drivers have to be "stand-alone", I can't take stuff that
requires core changes only for one staging driver.

thanks,

greg k-h
