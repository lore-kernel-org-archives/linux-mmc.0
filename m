From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH  v2 4/4] mmc: sdhci-s3c: remove the duplicated calling
 sequence
Date: Fri, 30 Aug 2013 12:01:22 +0900
Message-ID: <52200B02.9080105@samsung.com>
References: <51FBBD7E.2090700@samsung.com> <87wqn4vtze.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:39738 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab3H3DBK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Aug 2013 23:01:10 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSB00B7JPPN9MI0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 30 Aug 2013 12:01:08 +0900 (KST)
In-reply-to: <87wqn4vtze.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, =?windows-1252?Q?Heiko_St=FC?= =?windows-1252?Q?bner?= <heiko@sntech.de>

Dear Chris.

On 08/30/2013 10:37 AM, Chris Ball wrote:
> Hi,
>=20
> On Fri, Aug 02 2013, Jaehoon Chung wrote:
>> Didn't need to call the sdhci_s3c_notify_change in setup_card_detect=
_gpio().
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <Kyungmin.park@samsung.com>
>> Acked-by: Heiko Stuebner <heiko@sntech.de>
>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>> Changelog v2:
>> 	- Added acked/tested by Heiko (on s3c2416)
>>
>>  drivers/mmc/host/sdhci-s3c.c |   26 ++++++++++++--------------
>>  1 file changed, 12 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s=
3c.c
>> index f974778..c4ea802 100644
>> --- a/drivers/mmc/host/sdhci-s3c.c
>> +++ b/drivers/mmc/host/sdhci-s3c.c
>> @@ -409,20 +409,18 @@ static void sdhci_s3c_setup_card_detect_gpio(s=
truct sdhci_s3c *sc)
>>  	if (devm_gpio_request(dev, pdata->ext_cd_gpio, "SDHCI EXT CD") =3D=
=3D 0) {
>>  		sc->ext_cd_gpio =3D pdata->ext_cd_gpio;
>>  		sc->ext_cd_irq =3D gpio_to_irq(pdata->ext_cd_gpio);
>> -		if (sc->ext_cd_irq &&
>> -		    request_threaded_irq(sc->ext_cd_irq, NULL,
>> -					 sdhci_s3c_gpio_card_detect_thread,
>> -					 IRQF_TRIGGER_RISING |
>> -					 IRQF_TRIGGER_FALLING |
>> -					 IRQF_ONESHOT,
>> -					 dev_name(dev), sc) =3D=3D 0) {
>> -			int status =3D gpio_get_value(sc->ext_cd_gpio);
>> -			if (pdata->ext_cd_gpio_invert)
>> -				status =3D !status;
>> -			sdhci_s3c_notify_change(sc->pdev, status);
>> -		} else {
>> -			dev_warn(dev, "cannot request irq for card detect\n");
>> -			sc->ext_cd_irq =3D 0;
>> +		if (sc->ext_cd_irq) {
>> +			ret =3D request_threaded_irq(sc->ext_cd_irq, NULL,
>> +					sdhci_s3c_gpio_card_detect_thread,
>> +					IRQF_TRIGGER_RISING |
>> +					IRQF_TRIGGER_FALLING |
>> +					IRQF_ONESHOT,
>> +					dev_name(dev), sc);
>> +			if (ret) {
>> +				dev_warn(dev,
>> +					"cannot request irq for card detect\n");
>> +				sc->ext_cd_irq =3D 0;
>> +			}
>>  		}
>>  	} else {
>>  		dev_err(dev, "cannot request gpio for card detect\n");
>=20
> Jaehoon, this is really bad.  Heiko's ACK was conditional on fixing
> the error below:
>=20
> /home/cjb/git/mmc/drivers/mmc/host/sdhci-s3c.c: In function =91sdhci_=
s3c_setup_card_detect_gpio=92:
> /home/cjb/git/mmc/drivers/mmc/host/sdhci-s3c.c:422:4: error: =91ret=92=
 undeclared (first use in this function)
>=20
> But you reposted the same patch with his ACK and no fix.
Sorry.. I will check this.
>=20
> I don't mind the part where you probably didn't read his email
> carefully -- I'm much more concerned that you've now submitted a
> patch to me twice that you've apparently never compiled yourself.
> I need you to compile and test all of the patches you send me.
Ok..It's my mistake..

Best Regards,
Jaehoon Chung
>=20
> Thanks,
>=20
> - Chris.
>=20

