From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v3 09/12] EXAMPLE CODE: usb: port: Parse pwrseq phandle
 from Device Tree
Date: Wed, 01 Jun 2016 11:06:46 +0200
Message-ID: <574EA5A6.3090102@samsung.com>
References: <1464768141-25420-1-git-send-email-k.kozlowski@samsung.com>
 <1464768141-25420-10-git-send-email-k.kozlowski@samsung.com>
 <146477144362.1485.3331887341591876278@sboyd-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <146477144362.1485.3331887341591876278@sboyd-linaro>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <stephen.boyd@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, hzpeterchen@gmail.com, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.or, Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 06/01/2016 10:57 AM, Stephen Boyd wrote:
> Quoting Krzysztof Kozlowski (2016-06-01 01:02:18)
>> Parse usb-pwrseq property from Device Tree to get the phandle to pwrseq
>> device.  The pwrseq device will be used by USB hub to cycle the power
>> before activating ports.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> Drive by review comment.
> 
> I was hoping this would help me with a problem I'm having where I have a
> hub (smsc4604) that needs to be taken out of reset before my HSIC
> controller sends a USB reset to it, but it seems this is more about
> doing some sort of power on sequence after enumeration?

This example is not finished but from what you wrote, it might suit your
needs as well. The power sequence is done before enumeration because
without it, the device won't enumerate.

The exact power sequence for USB devices has to be still developed.
Comments are welcomed.

>> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
>> index 460c855be0d0..89b9bdfc7061 100644
>> --- a/drivers/usb/core/port.c
>> +++ b/drivers/usb/core/port.c
>> @@ -18,6 +18,8 @@
>>  
>>  #include <linux/slab.h>
>>  #include <linux/pm_qos.h>
>> +#include <linux/pwrseq.h>
>> +#include <linux/usb/of.h>
>>  
>>  #include "hub.h"
>>  
>> @@ -526,6 +528,14 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
>>                 return retval;
>>         }
>>  
>> +       port_dev->dev.of_node = usb_of_get_child_node(hdev->dev.parent->of_node,
>> +                                                     port1);
>> +       port_dev->pwrseq = pwrseq_alloc(&port_dev->dev, "usb-pwrseq");
>> +       if (IS_ERR(port_dev->pwrseq)) {
>> +               device_unregister(&port_dev->dev);
>> +               return PTR_ERR(port_dev->pwrseq);
> 
> Are we certain that port_dev hasn't been freed at this point? We just
> called device_unregister() on it, so it seems safer to save away the
> return value before calling device_unregister() here.

Right, good point. Thanks for feedback.

Best regards,
Krzysztof
