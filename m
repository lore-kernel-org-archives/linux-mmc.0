From: Roger <rogerable@realtek.com>
Subject: Re: [PATCH 1/3] mfd: Add realtek USB card reader driver
Date: Mon, 20 Jan 2014 16:55:52 +0800
Message-ID: <52DCE498.2010409@realtek.com>
References: <1389685656-880-1-git-send-email-rogerable@realtek.com>
 <1389685656-880-2-git-send-email-rogerable@realtek.com>
 <20140114130409.GB11820@lee--X1> <52D79E31.6000300@realtek.com>
 <20140116093506.GI11820@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20140116093506.GI11820@lee--X1>
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
Cc: Samuel Ortiz <sameo@linux.intel.com>, Alex Dubov <oakad@yahoo.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wei_wang <wei_wang@realsil.com.cn>, Chris Ball <cjb@laptop.org>, Dan Carpenter <dan.carpenter@oracle.com>, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 01/16/2014 05:35 PM, Lee Jones wrote:
>>>> +static int rtsx_usb_bulk_transfer_sglist(struct rtsx_ucr *ucr,
>>>> +             unsigned int pipe, struct scatterlist *sg, int num_sg,
>>>> +             unsigned int length, unsigned int *act_len, int timeout)
>>>> +{
>>>> +     int ret;
>>>> +
>>>> +     dev_dbg(&ucr->pusb_intf->dev, "%s: xfer %u bytes, %d entries\n",
>>>> +                     __func__, length, num_sg);
>>>> +     ret = usb_sg_init(&ucr->current_sg, ucr->pusb_dev, pipe, 0,
>>>> +                     sg, num_sg, length, GFP_NOIO);
>>>> +     if (ret)
>>>> +             return ret;
>>>> +
>>>> +     ucr->sg_timer.expires = jiffies + msecs_to_jiffies(timeout);
>>>> +     add_timer(&ucr->sg_timer);
>>>> +     usb_sg_wait(&ucr->current_sg);
>>>> +     del_timer(&ucr->sg_timer);
>>>> +
>>>> +     if (act_len)
>>>> +             *act_len = ucr->current_sg.bytes;
>>>> +
>>>> +     return ucr->current_sg.status;
>>>> +}
>>>
>>> Code looks fine, but shouldn't this live in a USB driver?
>>>
>> We have studied drivers in usb/storage, the place that most likely
>> to put the driver. All of them are for STANDARD usb mass storage
>> class(something like USB_CLASS_MASS_STORAGE). But this is not the
>> same case. This driver is for our vendor-class device with
>> completely different protocol. It is really an USB interfaced flash
>> card command converter(or channel) device rather than a real
>> storage. It also has two derived modules(rtsx_usb_sdmmc,
>> rtsx_usb_memstick) for other two subsystems.
>>
>> We also have another driver: rtsx_pcr.c resident in mfd/ for similar
>> devices but of PCIe interface. It is nature for us to choose the
>> same place for this variant.
>
> Very well, as long as it truly does not fit in drivers/usb. It would
> be good to have one of the USB folk give the nod though.
>
I found Greg K-H is exactly one of the maintainers of USB subsystem as I 
read the MAINTAINERS document.

Greg, would you please comment this subsystem concern or introduce 
other members? Thanks.
