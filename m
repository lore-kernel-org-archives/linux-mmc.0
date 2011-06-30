From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 1/2] MMC: PM: add suspend/resume in atmel-mci
Date: Thu, 30 Jun 2011 10:30:56 +0200
Message-ID: <4E0C3440.9010802@atmel.com>
References: <1ef60c032bc39531302c1603bfcb841d2d437ccc.1309366360.git.nicolas.ferre@atmel.com>
	<20110629160110.GD2760@legolas.emea.dhcp.ti.com>
	<201106292339.12402.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201106292339.12402.rjw@sisk.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, balbi@ti.com
Cc: linux-mmc@vger.kernel.org, kernel@avr32linux.org, linux-kernel@vger.kernel.org, =?ISO-8859-2?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, cjb@laptop.org, hans-christian.egtvedt@atmel.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Le 29/06/2011 23:39, Rafael J. Wysocki :
> On Wednesday, June 29, 2011, Felipe Balbi wrote:
>> Hi,
>>
>> On Wed, Jun 29, 2011 at 06:54:19PM +0200, Nicolas Ferre wrote:
>>> Take care of slots while going to suspend state.
>>>
>>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>>> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>>> ---
>>>  drivers/mmc/host/atmel-mci.c |   51 ++++++++++++++++++++++++++++++++++=
++++++++
>>>  1 files changed, 51 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
>>> index aa8039f..c414ebe 100644
>>> --- a/drivers/mmc/host/atmel-mci.c
>>> +++ b/drivers/mmc/host/atmel-mci.c
>>> @@ -1878,8 +1878,59 @@ static int __exit atmci_remove(struct platform_d=
evice *pdev)
>>>  	return 0;
>>>  }
>>>  =

>>> +#ifdef CONFIG_PM
>>> +static int atmci_suspend(struct platform_device *pdev, pm_message_t me=
sg)
>>> +{
>>> +	struct atmel_mci *host =3D platform_get_drvdata(pdev);
>>> +	struct atmel_mci_slot *slot;
>>> +	int i, ret;
>>> +
>>> +	 for (i =3D 0; i < ATMEL_MCI_MAX_NR_SLOTS; i++) {
>>> +		slot =3D host->slot[i];
>>> +		if (!slot)
>>> +			continue;
>>> +		ret =3D mmc_suspend_host(slot->mmc);
>>> +		if (ret < 0) {
>>> +			while (--i >=3D 0) {
>>> +				slot =3D host->slot[i];
>>> +				if (slot)
>>> +					mmc_resume_host(host->slot[i]->mmc);
>>> +			}
>>> +			return ret;
>>> +		}
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int atmci_resume(struct platform_device *pdev)
>>> +{
>>> +	struct atmel_mci *host =3D platform_get_drvdata(pdev);
>>> +	struct atmel_mci_slot *slot;
>>> +	int i, ret;
>>> +
>>> +	for (i =3D 0; i < ATMEL_MCI_MAX_NR_SLOTS; i++) {
>>> +		slot =3D host->slot[i];
>>> +		if (!slot)
>>> +			continue;
>>> +		ret =3D mmc_resume_host(slot->mmc);
>>> +		if (ret < 0)
>>> +			return ret;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +#else
>>> +#define atmci_suspend	NULL
>>> +#define atmci_resume	NULL
>>> +#endif
>>> +
>>> +
>>> +
>>>  static struct platform_driver atmci_driver =3D {
>>>  	.remove		=3D __exit_p(atmci_remove),
>>> +	.suspend	=3D atmci_suspend,
>>> +	.resume		=3D atmci_resume,
>>
>> should this be using dev_pm_ops instead ?
> =

> It should.  Also, please remember to initialize the hibernate callback
> pointers too, e.g. via the SIMPLE_DEV_PM_OPS() macro.

Felipe, Rafael,
Thanks for your feedback. I will implement this in a v2 patch.

BTW, should I use #ifdef CONFIG_PM or #ifdef CONFIG_PM_SLEEP?

Best regards,
-- =

Nicolas Ferre
