From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: use the dev_pm_ops for dw_mmc controller
Date: Fri, 02 Dec 2011 10:01:22 +0900
Message-ID: <4ED82362.9060405@samsung.com>
References: <4ED6C765.5010909@samsung.com> <4ED75007.6030009@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:65399 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012Ab1LBBB3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2011 20:01:29 -0500
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LVJ00NL0XIG4L40@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 02 Dec 2011 10:01:28 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LVJ00HPYXID5S30@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 02 Dec 2011 10:01:25 +0900 (KST)
In-reply-to: <4ED75007.6030009@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>

Thanks, James..

I will check your comment and resend the patch..

Best Regards,
Jaehoon Chung

On 12/01/2011 06:59 PM, James Hogan wrote:

> Thanks,
>=20
> Couple more things
>=20
> On 12/01/2011 12:16 AM, Jaehoon Chung wrote:
>> Dw_mmc controller didn't use dev_pm_ops.
>> This patch modified to use the dev_mp_ops for dw_mmc controller
>=20
> I think you mean dev_pm_ops.
>=20
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> Changelog v2:
>> 	- Use the Macro for dev_pm_ops
>>
>>  drivers/mmc/host/dw_mmc.c |   15 ++++++++-------
>>  1 files changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 3aaeb08..2ba1a96 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2066,10 +2066,10 @@ static int __exit dw_mci_remove(struct platf=
orm_device *pdev)
>>  /*
>>   * TODO: we should probably disable the clock to the card in the su=
spend path.
>>   */
>> -static int dw_mci_suspend(struct platform_device *pdev, pm_message_=
t mesg)
>> +static int dw_mci_suspend(struct device *dev)
>>  {
>>  	int i, ret;
>> -	struct dw_mci *host =3D platform_get_drvdata(pdev);
>> +	struct dw_mci *host =3D dev_get_drvdata(dev);
>> =20
>>  	for (i =3D 0; i < host->num_slots; i++) {
>>  		struct dw_mci_slot *slot =3D host->slot[i];
>> @@ -2092,10 +2092,10 @@ static int dw_mci_suspend(struct platform_de=
vice *pdev, pm_message_t mesg)
>>  	return 0;
>>  }
>> =20
>> -static int dw_mci_resume(struct platform_device *pdev)
>> +static int dw_mci_resume(struct device *dev)
>>  {
>>  	int i, ret;
>> -	struct dw_mci *host =3D platform_get_drvdata(pdev);
>> +	struct dw_mci *host =3D dev_get_drvdata(dev);
>> =20
>>  	if (host->vmmc)
>>  		regulator_enable(host->vmmc);
>> @@ -2103,7 +2103,7 @@ static int dw_mci_resume(struct platform_devic=
e *pdev)
>>  	if (host->dma_ops->init)
>>  		host->dma_ops->init(host);
>> =20
>> -	if (!mci_wait_reset(&pdev->dev, host)) {
>> +	if (!mci_wait_reset(dev, host)) {
>>  		ret =3D -ENODEV;
>>  		return ret;
>>  	}
>> @@ -2133,12 +2133,13 @@ static int dw_mci_resume(struct platform_dev=
ice *pdev)
>>  #define dw_mci_resume	NULL
>>  #endif /* CONFIG_PM */
>> =20
>> +SIMPLE_DEV_PM_OPS(dw_mci_pmops, dw_mci_suspend, dw_mci_resume);
>=20
> This could be static (e.g. see drivers/input/keyboard/gpio_keys.c).
>=20
> I get:
> drivers/mmc/host/dw_mmc.c:2069: warning: =91dw_mci_suspend=92 defined=
 but
> not used
> drivers/mmc/host/dw_mmc.c:2095: warning: =91dw_mci_resume=92 defined =
but not
> used
>=20
> when CONFIG_PM=3Dy and CONFIG_PM_SLEEP=3Dn (CONFIG_SUSPEND=3Dn), beca=
use the
> #ifdef above needs to change to CONFIG_PM_SLEEP (see
> SET_SYSTEM_SLEEP_PM_OPS in include/linux/pm.h).
>=20
>> +
>>  static struct platform_driver dw_mci_driver =3D {
>>  	.remove		=3D __exit_p(dw_mci_remove),
>> -	.suspend	=3D dw_mci_suspend,
>> -	.resume		=3D dw_mci_resume,
>>  	.driver		=3D {
>>  		.name		=3D "dw_mmc",
>> +		.pm		=3D &dw_mci_pmops,
>>  	},
>>  };
>> =20
>=20
> Cheers
> James
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


