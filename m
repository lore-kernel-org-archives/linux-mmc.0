From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v4 2/2] mmc: host: s3cmci: allow probing from device tree
Date: Mon, 06 Mar 2017 12:41:22 +0900
Message-ID: <b13fb653-9449-8744-a30b-9634d46eff8b@samsung.com>
References: <1488417536-15110-1-git-send-email-sergio.prado@e-labworks.com>
 <CGME20170302012845epcas4p3d7e48f13c80b2115cea89e914b067eeb@epcas4p3.samsung.com>
 <1488417536-15110-3-git-send-email-sergio.prado@e-labworks.com>
 <39c2b81b-6519-826b-2c8d-344725ce2882@samsung.com>
 <20170303113847.GA17377@sprado-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20170303113847.GA17377@sprado-desktop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergio Prado <sergio.prado@e-labworks.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 03/03/2017 08:38 PM, Sergio Prado wrote:
> On Fri, Mar 03, 2017 at 11:14:29AM +0900, Jaehoon Chung wrote:
>> On 03/02/2017 10:18 AM, Sergio Prado wrote:
>>> Allows configuring Samsung S3C24XX MMC/SD/SDIO controller using a device
>>> tree.
>>>
>>> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
>>> ---
>>>  drivers/mmc/host/s3cmci.c | 298 ++++++++++++++++++++++++----------------------
>>>  drivers/mmc/host/s3cmci.h |   3 +-
>>>  2 files changed, 158 insertions(+), 143 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
>>> index 7a173f8c455b..d066dbdb957c 100644
>>> --- a/drivers/mmc/host/s3cmci.c
>>> +++ b/drivers/mmc/host/s3cmci.c
>>> @@ -24,6 +24,10 @@
>>>  #include <linux/interrupt.h>
>>>  #include <linux/irq.h>
>>>  #include <linux/io.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/of_gpio.h>
>>> +#include <linux/mmc/slot-gpio.h>
>>>  
>>>  #include <plat/gpio-cfg.h>
>>>  #include <mach/dma.h>
>>> @@ -128,6 +132,22 @@ enum dbg_channels {
>>>  	dbg_conf  = (1 << 8),
>>>  };
>>>  
>>> +struct s3cmci_variant_data {
>>> +	int s3c2440_compatible;
>>> +};
>>
>> I didn't understand why this structure needs.
>>
>> Before this patch,
>> host->is2440;
>>
>> After this patch,
>> host->variant->s3c2440_compatible;
>>
>> Just add the one pointer for checking s3c2400 compatible..
>> Is it really meaningful?
>> (I didn't read the previous comments fully.)
> 
> Although just a pointer would be enought, having a structure makes it
> more flexible to extend it in the future.

If you will add the other members in this structure, it's ok.
But if it's only for compatible, i don't agree this.

Best Regards,
Jaehoon Chung

> 
> Best regards,
> 
> Sergio Prado
> 
> 
> 
