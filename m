From: Seung-Woo Kim <sw0312.kim@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: remove UBSAN warning in dw_mci_setup_bus()
Date: Fri, 17 Jun 2016 13:07:25 +0900
Message-ID: <5763777D.8040601@samsung.com>
References: <CGME20160608040654epcas1p2be228e3e02e35a640cb1e65228df79ad@epcas1p2.samsung.com>
 <1465358840-22826-1-git-send-email-sw0312.kim@samsung.com>
 <5759633E.7090706@samsung.com> <575A17F5.1050609@samsung.com>
 <576352CA.3080605@samsung.com>
Reply-To: sw0312.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <576352CA.3080605@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hello Jaehoon,

On 2016=EB=85=84 06=EC=9B=94 17=EC=9D=BC 10:30, Jaehoon Chung wrote:
> Hi Seung-Woo,
>=20
> On 06/10/2016 10:29 AM, Seung-Woo Kim wrote:
>> Hi Jaehoon,
>>
>> On 2016=EB=85=84 06=EC=9B=94 09=EC=9D=BC 21:38, Jaehoon Chung wrote:
>>> Hi Seung-Woo,
>>>
>>> On 06/08/2016 01:07 PM, Seung-Woo Kim wrote:
>>>> This patch removes following UBSAN warnings in dw_mci_setup_bus().
>>>> The warnings are caused because of shift with more than 31 on 32
>>>> bit variable, so this patch fixes to shift only for less than 32.
>>>>

<snip.>

>>>>
>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>>> index 2cc6123..dff045e 100644
>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>> @@ -1099,7 +1099,8 @@ static void dw_mci_setup_bus(struct dw_mci_s=
lot *slot, bool force_clkinit)
>>>> =20
>>>>  		div =3D (host->bus_hz !=3D clock) ? DIV_ROUND_UP(div, 2) : 0;
>>>> =20
>>>> -		if ((clock << div) !=3D slot->__clk_old || force_clkinit)
>>>> +		if (((div < 32) ? (clock << div) : 0) !=3D slot->__clk_old ||
>>>
>>> Well, we don't expect that clock is 0.
>>> if clock is 0, it should be passed to " if (!clock)"..
>>>
>>> During initializing card, clock is 400KHz or less..I understood wha=
t you want to fix.
>>> But I taught this is not correct.
>>
>> It seems slot->__clk_old is not really clock but a kind of value to
>> store both clock and div in one variable. And at least, my compiler
>> calculates right shift with more than 32 as 0. I am not sure there i=
s
>> other proper value for the case.
>>
>> By the way, in my test environment, clock is calculated as like
>> following steps:
>> mmc_host mmc0: Bus speed (slot 0) =3D 200000000Hz (slot req 400000Hz=
,
>> actual 400000HZ div =3D 250)
>> mmc_host mmc0: Bus speed (slot 0) =3D 200000000Hz (slot req 20000000=
0Hz,
>> actual 200000000HZ div =3D 0)
>> mmc_host mmc0: Bus speed (slot 0) =3D 200000000Hz (slot req 52000000=
Hz,
>> actual 50000000HZ div =3D 2)
>> mmc_host mmc0: Bus speed (slot 0) =3D 400000000Hz (slot req 52000000=
Hz,
>> actual 50000000HZ div =3D 4)
>> mmc_host mmc0: Bus speed (slot 0) =3D 400000000Hz (slot req 20000000=
0Hz,
>> actual 200000000HZ div =3D 1)
>>
>> and only the first case is reported as the warning. If you let me kn=
ow
>> any proper value, then I will fix with the value.
>=20
> I think that "clock << div" and__old_clock are used for checking whet=
her clock is changed.
> So it doesn't need to rotate with div.
>=20
> Could you check the below codes?
>=20
> if ((clock !=3D slot->clk_old) || force_clkinit)
> ...
>=20
> slot->__clk_old =3D clock;

=46rom the comment about alignment of slot->__clk_old, it says that "ke=
ep
the clock with reflecting clock dividor". So to me, it is better also
adding slot->__dlv with your suggestion. I will send patch like it, soo=
n.

Regards,
- Seung-Woo Kim

>=20
> Best Regards,
> Jaehoon Chung
>=20
>>
>> Thanks,
>> - Seung-Woo Kim
>>
>>
>>>
>>>
>>>> +		    force_clkinit)
>>>>  			dev_info(&slot->mmc->class_dev,
>>>>  				 "Bus speed (slot %d) =3D %dHz (slot req %dHz, actual %dHZ di=
v =3D %d)\n",
>>>>  				 slot->id, host->bus_hz, clock,
>>>> @@ -1129,7 +1130,7 @@ static void dw_mci_setup_bus(struct dw_mci_s=
lot *slot, bool force_clkinit)
>>>>  		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
>>>> =20
>>>>  		/* keep the clock with reflecting clock dividor */
>>>> -		slot->__clk_old =3D clock << div;
>>>> +		slot->__clk_old =3D (div < 32) ? (clock << div) : 0;

<snip.>

--=20
Seung-Woo Kim
Samsung Software R&D Center
--
