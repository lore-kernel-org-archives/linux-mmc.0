From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/3] mfd: Add realtek USB card reader driver
Date: Tue, 14 Jan 2014 16:46:34 +0300
Message-ID: <20140114134634.GM7444@mwanda>
References: <1389685656-880-1-git-send-email-rogerable@realtek.com>
 <1389685656-880-2-git-send-email-rogerable@realtek.com>
 <20140114130409.GB11820@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20140114130409.GB11820@lee--X1>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Alex Dubov <oakad@yahoo.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driverdev-devel@linuxdriverproject.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, rogerable@realtek.com, Chris Ball <cjb@laptop.org>, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: linux-mmc@vger.kernel.org

[ Sorry, I am coming down with the flu today so I'm doing dorky things
  like reviewing review comments.  I'm not sure how coherent I am.  ]

On Tue, Jan 14, 2014 at 01:04:09PM +0000, Lee Jones wrote:
 
> > +static void rtsx_usb_sg_timed_out(unsigned long data)
> > +{
> > +	struct rtsx_ucr *ucr = (struct rtsx_ucr *)data;
> 
> What's going to happen when your device runs 64bit?
> 

I'm not sure I understand what you mean here.  On linux sizeof(long) is
always the same as sizeof(void *).


> > +	if (cmd_len > IOBUF_SIZE)
> > +		return -EINVAL;
> > +
> > +	if (cmd_len % 4)
> > +		cmd_len += (4 - cmd_len % 4);
> 
> Please document in a comment.

There is a kernel macro for this:

	cmd_len = ALIGN(cmd_len, 4);

	if (cmd_len > IOBUF_SIZE)
		return -EINVAL;

> 
> > +
> > +
> 
> Extra '/n'
> 

It weirds me out when you mix up '\n' and /n'.

> > +int rtsx_usb_ep0_write_register(struct rtsx_ucr *ucr, u16 addr,
> > +		u8 mask, u8 data)
> > +{
> > +	u16 value = 0, index = 0;
> > +
> > +	value |= 0x03 << 14;
> > +	value |= addr & 0x3FFF;
> > +	value = ((value << 8) & 0xFF00) | ((value >> 8) & 0x00FF);
> > +	index |= (u16)mask;
> > +	index |= (u16)data << 8;
> 
> Lots of random numbers here, please #define for clarity and ease of
> reading.
> 

The only really random number is the 0x03, but yeah, it would help if
that we a define.

	addr |= 0x03 << 14;

	value = __swab16(addr);
	index = mask | (data << 8);

> > +
> > +	dev_dbg(&intf->dev,
> > +		": Realtek USB Card Reader found at bus %03d address %03d\n",
> > +		 usb_dev->bus->busnum, usb_dev->devnum);
> > +
> > +	ucr = kzalloc(sizeof(struct rtsx_ucr), GFP_KERNEL);
> 
> s/struct rtsx_ucr/*ucr/
> 
> Any reason for not using managed resources?
> 

Roger, he means the devm_kzalloc().

regards,
dan carpenter
