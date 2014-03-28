From: Roger <rogerable@realtek.com>
Subject: Re: [PATCH v5 1/3] mfd: Add realtek USB card reader driver
Date: Fri, 28 Mar 2014 11:33:04 +0800
Message-ID: <5334ED70.6050309@realtek.com>
References: <1395744293-24398-1-git-send-email-rogerable@realtek.com>	
 <1395744293-24398-2-git-send-email-rogerable@realtek.com>
 <201403280231.s2S2VP8X017745@rtits1.realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <201403280231.s2S2VP8X017745@rtits1.realtek.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driverdev-devel@linuxdriverproject.org, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, Andrew Morton <akpm@linux-foundation.org>, Lee Jones <lee.jones@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

On 03/26/2014 10:36 PM, Oliver Neukum wrote:
> On Tue, 2014-03-25 at 18:44 +0800, rogerable@realtek.com wrote:
>> From: Roger Tseng <rogerable@realtek.com>
>

>> +static int rtsx_usb_probe(struct usb_interface *intf,
>> +			 const struct usb_device_id *id)
>> +{
>> +	struct usb_device *usb_dev = interface_to_usbdev(intf);
>> +	struct rtsx_ucr *ucr;
>> +	int ret;
>> +
>> +	dev_dbg(&intf->dev,
>> +		": Realtek USB Card Reader found at bus %03d address %03d\n",
>> +		 usb_dev->bus->busnum, usb_dev->devnum);
>> +
>> +	ucr = devm_kzalloc(&intf->dev, sizeof(*ucr), GFP_KERNEL);
>> +	if (!ucr)
>> +		return -ENOMEM;
>> +
>> +	ucr->pusb_dev = usb_dev;
>> +
>> +	ucr->iobuf = usb_alloc_coherent(ucr->pusb_dev, IOBUF_SIZE,
>> +			GFP_KERNEL, &ucr->iobuf_dma);
>> +	if (!ucr->iobuf)
>> +		return -ENOMEM;
>> +
>> +	usb_set_intfdata(intf, ucr);
>> +
>> +	ucr->vendor_id = id->idVendor;
>> +	ucr->product_id = id->idProduct;
>> +	ucr->cmd_buf = ucr->rsp_buf = ucr->iobuf;
>> +
>> +	mutex_init(&ucr->dev_mutex);
>> +
>> +	ucr->pusb_intf = intf;
>> +
>> +	/* initialize */
>> +	ret = rtsx_usb_init_chip(ucr);
>> +	if (ret)
>> +		goto out_init_fail;
>> +
>> +	ret = mfd_add_devices(&intf->dev, usb_dev->devnum, rtsx_usb_cells,
>> +			ARRAY_SIZE(rtsx_usb_cells), NULL, 0, NULL);
>
> Race condition. What prevents the mfd layer from using this device
> before you've finished the next steps of the initialisation?
>
OK, I'll put the timer init before mfd_add_devices.
>> +	if (ret)
>> +		goto out_init_fail;
>> +
>> +	/* initialize USB SG transfer timer */
>> +	init_timer(&ucr->sg_timer);
>> +	setup_timer(&ucr->sg_timer, rtsx_usb_sg_timed_out, (unsigned long) ucr);
>> +#ifdef CONFIG_PM
>> +	intf->needs_remote_wakeup = 1;
>
> Why?
Our reader supports remote wake-up from card slot event(insertion, 
removal). It should be enabled to let the driver be able to detect the 
newly inserted card.

>> +	usb_enable_autosuspend(usb_dev);
>> +#endif
>> +
>> +	return 0;
>> +
>> +out_init_fail:
>> +	usb_free_coherent(ucr->pusb_dev, IOBUF_SIZE, ucr->iobuf,
>> +			ucr->iobuf_dma);
>> +	return ret;
>> +}
>> +
...
>> +static int rtsx_usb_suspend(struct usb_interface *intf, pm_message_t message)
>> +{
>> +	struct rtsx_ucr *ucr =
>> +		(struct rtsx_ucr *)usb_get_intfdata(intf);
>> +
>> +	dev_dbg(&intf->dev, "%s called with pm message 0x%04u\n",
>> +			__func__, message.event);
>> +
>> +	mutex_lock(&ucr->dev_mutex);
>> +	rtsx_usb_turn_off_led(ucr);
>
> When is this turned on again?
>

The LED is not in a permanent cut-off state after here. It is called to 
guarantee the LED is off during suspend to save more power. It could be 
lit up in the card host drivers(e.g. rtsx_usb_sdmmc.c) anytime whenever 
necessary.

This has been asked may times. I'm considering putting some comment in 
next revision.

Best regards,
Roger Tseng
