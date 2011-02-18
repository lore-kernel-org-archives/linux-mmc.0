From: Philip Rakity <prakity@marvell.com>
Subject: Fwd: [PATCH 00/12] add support for sd host controller v3.00
Date: Fri, 18 Feb 2011 08:53:14 -0800
Message-ID: <C00245A6-FBCE-47BC-B3DD-8A9FC0D7CD73@marvell.com>
References: <6C03668EAF45B747AF947A1603D1B300DCDF034C@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:38985 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932234Ab1BRRAq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 18 Feb 2011 12:00:46 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>



Begin forwarded message:

> From: "Nath, Arindam" <Arindam.Nath@amd.com>
> Date: February 16, 2011 10:52:50 PM PST
> To: Philip Rakity <prakity@marvell.com>
> Cc: "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>
> Subject: RE: [PATCH 00/12] add support for sd host controller v3.00
>=20
> Good catch Philip. Thanks for the review. I will fix it. BTW, you can=
 put this comment on the community too.
>=20
> Thanks,
> Arindam
>=20
>> -----Original Message-----
>> From: Philip Rakity [mailto:prakity@marvell.com]
>> Sent: Thursday, February 17, 2011 12:07 PM
>> To: Nath, Arindam
>> Subject: Re: [PATCH 00/12] add support for sd host controller v3.00
>>=20
>>=20
>> code review
>> set_clock
>>=20
>> clk is not set to 0 at the start
>>=20
>> static void sdhci_set_clock(struct sdhci_host *host, unsigned int
>> clock)
>> {
>> 	int div =3D 0; /* Initialized for compiler warning */
>> 	u16 clk;
>> 	unsigned long timeout;
>>=20
>>=20
>> used further on
>>=20
>> if (!(ctrl & SDHCI_CTRL_PRESET_VAL_ENABLE)) {
>> 				for (div =3D 1; div <=3D 1024; div++) {
>> 					if (((host->max_clk * host->clk_mul) /
>> 					      div) <=3D clock)
>> 						break;
>> 				}
>> 				/*
>> 				 * Set Programmable Clock Mode in the Clock
>> 				 * Control register.
>> 				 */
>> 				clk |=3D SDHCI_PROG_CLOCK_MODE;
>> 				div--;
>>=20
>>=20
>> and at the end reset
>>=20
>>=20
>> 	clk =3D (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
>> 	clk |=3D ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
>> 		<< SDHCI_DIVIDER_HI_SHIFT;
>>=20
>>=20
>> Philip
>>=20
>>=20
>> On Feb 16, 2011, at 9:32 PM, Nath, Arindam wrote:
>>=20
>>> Please find the file attached.
>>>=20
>>> Thanks,
>>> Arindam
>>>=20
>>>> -----Original Message-----
>>>> From: Philip Rakity [mailto:prakity@marvell.com]
>>>> Sent: Thursday, February 17, 2011 8:02 AM
>>>> To: Nath, Arindam
>>>> Subject: Re: [PATCH 00/12] add support for sd host controller v3.0=
0
>>>>=20
>>>>=20
>>>> Don't feel right -- that is why wanted to see the code first !
>>>>=20
>>>>=20
>>>> On Feb 16, 2011, at 6:22 PM, Nath, Arindam wrote:
>>>>=20
>>>>> OK Philip, I will send the file from office. BTW, you can go ahea=
d
>>>> and post your comments on the community too, if you feel right.
>>>>>=20
>>>>> Thanks,
>>>>> Arindam
>>>>>=20
>>>>>> -----Original Message-----
>>>>>> From: Philip Rakity [mailto:prakity@marvell.com]
>>>>>> Sent: Thursday, February 17, 2011 7:42 AM
>>>>>> To: Nath, Arindam
>>>>>> Subject: Re: [PATCH 00/12] add support for sd host controller
>> v3.00
>>>>>>=20
>>>>>>=20
>>>>>> Please send sdhci.c  I have comments you may want to have for V2
>>>>>>=20
>>>>>> On Feb 16, 2011, at 6:03 PM, Nath, Arindam wrote:
>>>>>>=20
>>>>>>> Hi Chris,
>>>>>>>=20
>>>>>>>> -----Original Message-----
>>>>>>>> From: Chris Ball [mailto:cjb@laptop.org]
>>>>>>>> Sent: Thursday, February 17, 2011 2:25 AM
>>>>>>>> To: Nath, Arindam
>>>>>>>> Cc: linux-mmc@vger.kernel.org; Su, Henry; Lu, Aaron;
>>>>>>>> anath.amd@gmail.com
>>>>>>>> Subject: Re: [PATCH 00/12] add support for sd host controller
>>>> v3.00
>>>>>>>>=20
>>>>>>>> Hi Arindam,
>>>>>>>>=20
>>>>>>>> On Tue, Feb 15, 2011 at 03:04:58PM +0530, Arindam Nath wrote:
>>>>>>>>> The patches below add support for Host Controller v3.00 as pe=
r
>>>> the
>>>>>>>>> spec v3.00. It also adds support for UHS-I cards as per
>> Physical
>>>>>>>>> Layer Specification v3.01.
>>>>>>>>=20
>>>>>>>> Could you base v2 of the patchset on top of my mmc-next branch=
=B9,
>>>>>>>> please?
>>>>>>>> I'm not sure what v1 was prepared against, but patch [2/12]
>>>> onwards
>>>>>>>> don't apply successfully here.
>>>>>>>=20
>>>>>>> My patches have been created against Linus' git tree. I will ma=
ke
>>>>>> sure to rebase it against mmc-next for V2. Thanks for the
>> patience.
>>>>>>>=20
>>>>>>> Regards,
>>>>>>> Arindam
>>>>>>>=20
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe linux=
-
>>>> mmc"
>>>>>> in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-
>> info.html
>>>>>>=20
>>>>>=20
>>>>>=20
>>>>=20
>>>=20
>>> <sdhci.c>
>>=20
>=20
>=20

