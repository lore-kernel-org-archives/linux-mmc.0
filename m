From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC v02 03/15] dmaengine: core: Introduce new, universal API to
 request a channel
Date: Tue, 1 Dec 2015 11:56:42 +0200
Message-ID: <565D6EDA.4070002@ti.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <1448891145-10766-4-git-send-email-peter.ujfalusi@ti.com>
 <CAHp75VeTe6hcnuqHNv=GX8pZJmde0H-AjZpxMHq=f5YfOL5hSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57324 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282AbbLAJ5P (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Dec 2015 04:57:15 -0500
In-Reply-To: <CAHp75VeTe6hcnuqHNv=GX8pZJmde0H-AjZpxMHq=f5YfOL5hSA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, linux-spi <linux-spi@vger.kernel.org>

On 11/30/2015 04:51 PM, Andy Shevchenko wrote:
>> +struct dma_chan *dma_request_chan(struct device *dev, const char *n=
ame)
>> +{
>> +       struct dma_device *device, *_d;
>> +       struct dma_chan *chan =3D NULL;
>> +
>> +       /* If device-tree is present get slave info from here */
>> +       if (dev->of_node)
>> +               chan =3D of_dma_request_slave_channel(dev->of_node, =
name);
>> +
>> +       /* If device was enumerated by ACPI get slave info from here=
 */
>> +       if (ACPI_HANDLE(dev) && !chan)
>=20
> The preferable way is to use
> has_acpi_companion() instead of ACPI_HANDLE().

I have done this part based on the dma_request_slave_channel_reason().
Will switch to use the has_acpi_companion() for the next RFC.

>> +               chan =3D acpi_dma_request_slave_chan_by_name(dev, na=
me);
>> +
>> +       if (chan)
>> +               return chan;
>> +

--=20
P=C3=A9ter
