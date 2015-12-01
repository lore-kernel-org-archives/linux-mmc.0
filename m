From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC v02 03/15] dmaengine: core: Introduce new, universal API to
 request a channel
Date: Tue, 1 Dec 2015 12:07:40 +0200
Message-ID: <CAHp75Vd=hzGMr+CDV6MPccLw8WV7aRkjFpN_vYSQhF7cq5rFNg@mail.gmail.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
	<1448891145-10766-4-git-send-email-peter.ujfalusi@ti.com>
	<CAHp75VeTe6hcnuqHNv=GX8pZJmde0H-AjZpxMHq=f5YfOL5hSA@mail.gmail.com>
	<565D6EDA.4070002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <565D6EDA.4070002@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, linux-spi <linux-spi@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Dec 1, 2015 at 11:56 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 11/30/2015 04:51 PM, Andy Shevchenko wrote:
>>> +struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>>> +{
>>> +       struct dma_device *device, *_d;
>>> +       struct dma_chan *chan = NULL;
>>> +
>>> +       /* If device-tree is present get slave info from here */
>>> +       if (dev->of_node)
>>> +               chan = of_dma_request_slave_channel(dev->of_node, name);
>>> +
>>> +       /* If device was enumerated by ACPI get slave info from here */
>>> +       if (ACPI_HANDLE(dev) && !chan)
>>
>> The preferable way is to use
>> has_acpi_companion() instead of ACPI_HANDLE().
>
> I have done this part based on the dma_request_slave_channel_reason().

Understood, though that function was implemented before
has_acpi_companion() has been introduced.

> Will switch to use the has_acpi_companion() for the next RFC.

Good.

-- 
With Best Regards,
Andy Shevchenko
