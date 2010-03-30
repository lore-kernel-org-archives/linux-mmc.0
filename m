From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH]omap hsmmc: fix incorrect capability reporting
Date: Wed, 31 Mar 2010 00:12:55 +0530
Message-ID: <618f0c911003301142w660f77afk3ced01187792fecc@mail.gmail.com>
References: <618f0c911003300737w5562c18as1bfcb21671919718@mail.gmail.com>
	 <002a01cad020$47be5fb0$544ff780@am.dhcp.ti.com>
	 <618f0c911003301111r3781661asa444dd35042772c3@mail.gmail.com>
	 <4BB2430A.80701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4BB2430A.80701@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
List-Id: linux-mmc@vger.kernel.org

Nishanth Menon <nm@ti.com> wrote:
> S, Venkatraman had written, on 03/30/2010 01:11 PM, the following:
> [..]
>>>>
>>>> diff --git a/drivers/mmc/host/omap_hsmmc.c
>>>> b/drivers/mmc/host/omap_hsmmc.c
>>>> index 83f0aff..dbf83a6 100644
>>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>>> @@ -2093,7 +2093,7 @@ static int __init omap_hsmmc_probe(struct
>>>> platform_device *pdev)
>>>>
>>>> =A0 =A0 =A0if (mmc_slot(host).wires >=3D 8)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_8_BIT_DATA;
>>>> - =A0 =A0 else if (mmc_slot(host).wires >=3D 4)
>>>> + =A0 =A0 if (mmc_slot(host).wires >=3D 4)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_4_BIT_DATA;
>>>>
>>> Since 8-bit is the max how about:
>>>
>>> =A0 =A0 =A0 if (mmc_slot(host).wires =3D=3D 8)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_8_BIT_DATA | MMC=
_CAP_4_BIT_DATA;
>>> =A0 =A0 =A0 if (mmc_slot(host).wires =3D=3D 4)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_4_BIT_DATA;
>>>
>>> This would be little easy to read the code.
>>
>> Sure. Works for me.
>
> nitpicky comment: might be better off using a switch(mmc_slot(host).w=
ires)
> statement instead of using =3D=3D if that is the intention here..

Too verbose for just 2 cases, with the 'case's and 'default's adding
nothing to readability. YMMV.

Thanks,
Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
