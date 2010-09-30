From: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@pelagicore.com>
Subject: Re: [PATCH 1/6] mmc: sdhci-pltfm: Add structure for host-specific data
Date: Thu, 30 Sep 2010 11:54:53 +0200
Message-ID: <4CA45E6D.4070308@pelagicore.com>
References: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
	<1285790884-3516-2-git-send-email-w.sang@pengutronix.de>
	<4CA3AE89.2030107@pelagicore.com>
	<20100930081605.GA2655@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100930081605.GA2655@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Zhu Richard-R65037 <r65037@freescale.com>, linux-mmc@vger.kernel.org, =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors.ext@mocean-labs.com>, zhangfei gao <zhangfei.gao@gmail.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Philip Rakity <prakity@marvell.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 09/30/2010 10:16 AM, Wolfram Sang wrote:
> Hi Richard,
>
> On Wed, Sep 29, 2010 at 11:24:25PM +0200, Richard R=F6jfors wrote:
>> On 09/29/2010 10:07 PM, Wolfram Sang wrote:
>>> We need to carry some information per host, e.g. the clock. Add a
>>> structure for it and initialize it in the generic part. Also do not use
>>> the parent of the platform_device (if it is available), this breaks the
>>> clock-matching on ARM.
>>
>> The reason it's there is for instance a case when the shdci device is ex=
posed
>> from a MFD device which sits on top of PCI. Then the parent (PCI device)
>> is the device that is DMA capable. This patch will break such usage.
>
> I feared that there is a reason. The problem I see is now, that the paren=
t gets
> always set (from drivers/base/platform.c):

Then we obviously need to pass more information in the platform_data to be =
able
to chose which device to be used.

>
> So, sdhci-plftm cannot access the platform_data connected to the original
> platform_device via host->mmc->parent.

You're right it wouldn't. But isn't it a bit risky even if you could access=
 it,
in the long the platform_data coild point to something that is in the __dev=
init section
or similar?
What about extend the struct you defined with the pieces needed, and access=
 it via
sdhci_priv?

>> What is the purpose of this patch? You allocate space for an extra struc=
t,
>> which you have a pointer pointing to, but you never use the pointer?
>
> We want to extend sdhci-pltfm to support the various sdhci-cores on (for =
now
> mainly) ARM platforms. A number of those cores need board specific inform=
ation
> to be used in a custom init()-call, which shall be passed via platform_da=
ta.
> The pointer will be used in the platform specific extensions.

Sounds good.

Regards,
Richard

>
>>>
>>> Signed-off-by: Wolfram Sang<w.sang@pengutronix.de>
>>> Cc: Richard R=F6jfors<richard.rojfors.ext@mocean-labs.com>
>>> ---
>>>
>>> Changes since last version:
>>>
>>> * added types.h
>>
>> I saw no types.h?
>
> In the second chunk, the include file.
>
> Thanks,
>
>     Wolfram
>
>>
>>> * removed usage of pdev->dev.parent to ensure clk-matching
>>>    Please speak up if this has a use case I failed to see!
>>>
>>>   drivers/mmc/host/sdhci-pltfm.c |    8 ++++----
>>>   drivers/mmc/host/sdhci-pltfm.h |    7 +++++++
>>>   2 files changed, 11 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pl=
tfm.c
>>> index e045e3c..095ca9d 100644
>>> --- a/drivers/mmc/host/sdhci-pltfm.c
>>> +++ b/drivers/mmc/host/sdhci-pltfm.c
>>> @@ -55,6 +55,7 @@ static int __devinit sdhci_pltfm_probe(struct platfor=
m_device *pdev)
>>>   	struct sdhci_pltfm_data *pdata =3D pdev->dev.platform_data;
>>>   	const struct platform_device_id *platid =3D platform_get_device_id(p=
dev);
>>>   	struct sdhci_host *host;
>>> +	struct sdhci_pltfm_host *pltfm_host;
>>>   	struct resource *iomem;
>>>   	int ret;
>>>
>>> @@ -71,16 +72,15 @@ static int __devinit sdhci_pltfm_probe(struct platf=
orm_device *pdev)
>>>   		dev_err(&pdev->dev, "Invalid iomem size. You may "
>>>   			"experience problems.\n");
>>>
>>> -	if (pdev->dev.parent)
>>> -		host =3D sdhci_alloc_host(pdev->dev.parent, 0);
>>> -	else
>>> -		host =3D sdhci_alloc_host(&pdev->dev, 0);
>>> +	host =3D sdhci_alloc_host(&pdev->dev, sizeof(*pltfm_host));
>>>
>>>   	if (IS_ERR(host)) {
>>>   		ret =3D PTR_ERR(host);
>>>   		goto err;
>>>   	}
>>>
>>> +	pltfm_host =3D sdhci_priv(host);
>>> +
>>>   	host->hw_name =3D "platform";
>>>   	if (pdata&&   pdata->ops)
>>>   		host->ops =3D pdata->ops;
>>> diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pl=
tfm.h
>>> index 900f329..93a0319 100644
>>> --- a/drivers/mmc/host/sdhci-pltfm.h
>>> +++ b/drivers/mmc/host/sdhci-pltfm.h
>>> @@ -11,8 +11,15 @@
>>>   #ifndef _DRIVERS_MMC_SDHCI_PLTFM_H
>>>   #define _DRIVERS_MMC_SDHCI_PLTFM_H
>>>
>>> +#include<linux/clk.h>
>>> +#include<linux/types.h>
>>>   #include<linux/sdhci-pltfm.h>
>>>
>>> +struct sdhci_pltfm_host {
>>> +	struct clk *clk;
>>> +	u32 scratchpad; /* to handle quirks across io-accessor calls */
>>> +};
>>> +
>>>   extern struct sdhci_pltfm_data sdhci_cns3xxx_pdata;
>>>
>>>   #endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
>
