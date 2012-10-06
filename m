From: wwang <wei_wang@realsil.com.cn>
Subject: Re: [PATCH v6 1/3] drivers/mfd: Add realtek pcie card reader driver
Date: Sat, 6 Oct 2012 17:05:10 +0800
Message-ID: <506FF446.2010300@realsil.com.cn>
References: <cover.1347330871.git.wei_wang@realsil.com.cn> <b3b7a3d03d9591c1f393f4c4f488efbd15756c7c.1347330871.git.wei_wang@realsil.com.cn> <20120930224933.GB12231@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rtits2.realtek.com ([60.250.210.242]:45429 "EHLO
	rtits2.realtek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848Ab2JFJFu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 6 Oct 2012 05:05:50 -0400
In-Reply-To: <20120930224933.GB12231@sortiz-mobl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, "oakad@yahoo.com" <oakad@yahoo.com>, "bp@alien8.de" <bp@alien8.de>

=D3=DA 2012=C4=EA10=D4=C201=C8=D5 06:49, Samuel Ortiz =D0=B4=B5=C0:
> Hi Wei,
>
> On Tue, Sep 11, 2012 at 12:54:22PM +0800, wei_wang@realsil.com.cn wro=
te:
> Although  pretty big, the patch looks mostly good to me.
> I only have a few comments:
>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index d1facef..4c07a34 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -63,6 +63,15 @@ config MFD_SM501_GPIO
>>  	 lines on the SM501. The platform data is used to supply the
>>  	 base number for the first GPIO line to register.
>> =20
>> +config MFD_RTSX_PCI
>> +	tristate "Support for Realtek PCI-E driver-based card reader"
>> +	depends on PCI
>> +	help
>> +	  This supports for Realtek PCI-Express driver-based card reader i=
ncluding
>> +	  rts5209, rts5229, etc. Realtek driver-based card reader supports=
 access
> driver-based ?

Sorry, this is our internal naming convention. We have two groups of
card reader, one group has embedded MCU and uses in-box driver, the
other hasn't MCU and uses vendor driver. So we call the first group as
"MCU-based reader", and the second group as "driver-based reader". This
naming convention may confuse others, I will modify the description.
>
>> +
>> +static u8 rts5209_get_ic_version(struct rtsx_pcr *pcr)
>> +{
>> +	u8 val;
>> +
>> +	val =3D rtsx_pci_readb(pcr, 0x1C);
>> +	return val & 0x0F;
> For your IO accesses, it would e worth looking at the regmap MMIO rou=
tines. It
> would also simplify your main probe routine.

regmap MMIO is great. But I haven't used it before, and it seems that w=
e
haven't enough time to test it in this short merge window. I will take
your advice and use these routines in the near future.
>
>> +static int rts5209_turn_on_led(struct rtsx_pcr *pcr)
>> +{
>> +	return rtsx_pci_write_register(pcr, 0xFD58, 0x01, 0x00);
> You have many hardcoded register adresses around this code. Defining =
them in
> your header file wouldn't hurt.

I will modify it soon.

>
>> +static struct platform_device *rtsx_pci_create_subdev(struct rtsx_p=
cr *pcr,
>> +		const char *name, int slot_id)
>> +{
>> +	struct platform_device *p_dev;
>> +	int err;
>> +
>> +	p_dev =3D platform_device_alloc(name, pcr->id);
>> +	if (p_dev =3D=3D NULL) {
>> +		dev_dbg(&(pcr->pci->dev), "alloc platform device fail!\n");
>> +		return NULL;
>> +	}
>> +
>> +	p_dev->dev.parent =3D &(pcr->pci->dev);
>> +	platform_set_drvdata(p_dev, pcr);
>> +	pcr->slots[slot_id].p_dev =3D p_dev;
>> +
>> +	err =3D platform_device_add(p_dev);
>> +	if (err) {
>> +		dev_dbg(&(pcr->pci->dev), "add platform device fail!\n");
>> +		pcr->slots[slot_id].p_dev =3D NULL;
>> +		platform_device_put(p_dev);
>> +		return NULL;
>> +	}
>> +
>> +	return p_dev;
>> +}
> Please use the MFD device addition API for that.
>

You suggest using mfd_cell ? I have considered it, but it seems not ver=
y
flexible in my situation. I will create two sub devices in the driver,
one for SD/MMC card, the other for Memstick. I need to create the sub
device when the card inserted, and destroy it when the card removed. Th=
e
timing to create and destroy is totally up to the user.
But mfd_cell will create and destroy all of the sub devices at the same
time, using API mfd_add_devices and mfd_remove_devices, which can not
meet my desire.

>> +static irqreturn_t rtsx_pci_isr(int irq, void *dev_id)
>> +{
>> +	struct rtsx_pcr *pcr =3D dev_id;
>> +	u32 int_reg;
>> +
>> +	if (!pcr)
>> +		return IRQ_NONE;
>> +
>> +	spin_lock(&pcr->lock);
>> +
>> +	int_reg =3D rtsx_pci_readl(pcr, RTSX_BIPR);
>> +	/* Clear interrupt flag */
>> +	rtsx_pci_writel(pcr, RTSX_BIPR, int_reg);
>> +	if ((int_reg & pcr->bier) =3D=3D 0) {
>> +		spin_unlock(&pcr->lock);
>> +		return IRQ_NONE;
>> +	}
>> +	if (int_reg =3D=3D 0xFFFFFFFF) {
>> +		spin_unlock(&pcr->lock);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	int_reg &=3D (pcr->bier | 0x7FFFFF);
>> +
>> +	if (int_reg & SD_INT) {
>> +		if (int_reg & SD_EXIST) {
>> +			pcr->need_reset |=3D SD_EXIST;
>> +		} else {
>> +			pcr->need_release |=3D SD_EXIST;
>> +			pcr->need_reset &=3D ~SD_EXIST;
>> +		}
>> +	}
>> +
>> +	if (int_reg & MS_INT) {
>> +		if (int_reg & MS_EXIST) {
>> +			pcr->need_reset |=3D MS_EXIST;
>> +		} else {
>> +			pcr->need_release |=3D MS_EXIST;
>> +			pcr->need_reset &=3D ~MS_EXIST;
>> +		}
>> +	}
>> +
>> +	if (pcr->need_reset || pcr->need_release)
>> +		queue_delayed_work(workqueue, &pcr->carddet_work,
>> +				msecs_to_jiffies(200));
> Why do we need a delayed work here ?

We need a period of time to debounce the CD glitch, so I use a delayed
work here. After 200 milliseconds, I will check the CD signal again to
make sure this is a valid signal.

>
>> +static void rtsx_pci_enter_idle(unsigned long __data)
>> +{
>> +	struct rtsx_pcr *pcr =3D (struct rtsx_pcr *)__data;
>> +
>> +	queue_work(workqueue, &pcr->idle_work);
>> +}
> OT: We need threaded timers...
>

Sorry, I can't understand this...

>> +static int __init rtsx_pci_drv_init(void)
>> +{
>> +	workqueue =3D create_freezable_workqueue("rtsx_pci_wq");
>> +	if (!workqueue)
>> +		return -ENOMEM;
> Are you sure you really need to create your won workqueue ? My guess =
is that
> you probably don't.
I will modify it and make a full test.

BR,
Wei WANG
