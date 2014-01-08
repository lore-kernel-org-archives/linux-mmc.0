From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/3] mfd: Add realtek USB card reader driver
Date: Wed, 8 Jan 2014 16:03:06 +0300
Message-ID: <20140108130305.GQ30234@mwanda>
References: <1387792327-2511-1-git-send-email-rogerable@realtek.com>
 <1387792327-2511-2-git-send-email-rogerable@realtek.com>
 <20140102094750.GZ28413@mwanda>
 <1121E117AD4ECE49880A389A396215BB939A5BD715@rtitmbs7.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1121E117AD4ECE49880A389A396215BB939A5BD715@rtitmbs7.realtek.com.tw>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Roger Tseng <rogerable@realtek.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Alex Dubov <oakad@yahoo.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wei_wang <wei_wang@realsil.com.cn>, Chris Ball <cjb@laptop.org>, Lee Jones <lee.jones@linaro.org>, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 08, 2014 at 03:56:05PM +0800, Roger Tseng wrote:
> Hi Dan,
> 
> >> +int rtsx_usb_ep0_write_register(struct rtsx_ucr *ucr, u16 addr,
> >> +             u8 mask, u8 data)
> >> +{
> >> +     u16 value = 0, index = 0;
> >> +
> >> +     value |= (u16)(3 & 0x03) << 14;
> >> +     value |= (u16)(addr & 0x3FFF);
> >
> >Don't do pointless things:
> >
> >        value |= 0x03 << 14;
> >        value |= addr & 0x3FFF;
> >
> >> +     value = ((value << 8) & 0xFF00) | ((value >> 8) & 0x00FF);
> >
> >This is an endian conversion?  It is buggy.  Use the kernel endian
> >conversion functions cpu_to_le16().
> 
> This is not a conversion for endianess with respect to CPU but for
> command format  of the device. It should always be performed
> regardless of platform.
> 
> In other words, it could be equivalent to:
>         value |= 0x03 << 6; // lower byte
>         value |= (addr & 0x3F00) >> 8; // lower byte
>         value |= (addr & 0xFF) << 8; //higher byte
> 
> We think the previous form is easier to read. Should we keep it or
> change to the later one?

To me it's really weird that the standard would specify that the address
is in byte swapped reversed CPU-endian order.  But if that's what it
says then I don't care about formatting details.  The original code is
fine.

regards,
dan carpenter
