From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC PATCH] mmc: block: Support the fixed index for mmcblk with
 aliases nodes
Date: Wed, 06 Apr 2016 11:00:24 +0900
Message-ID: <57046DB8.5000107@samsung.com>
References: <56FA5C56.9080009@samsung.com> <20160329184920.29a240fc@xhacker>
 <56FB1AA2.8050005@rock-chips.com> <5701CCAF.4090102@samsung.com>
 <CAPDyKFqOJ1+ngcSjnyS4ysYJHBGvuOQLCD5oVcB3t-QrTN3b=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:53201 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbcDFCAf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2016 22:00:35 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O5602M01W8PMRC0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 06 Apr 2016 11:00:25 +0900 (KST)
In-reply-to: <CAPDyKFqOJ1+ngcSjnyS4ysYJHBGvuOQLCD5oVcB3t-QrTN3b=g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Jisheng Zhang <jszhang@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 04/04/2016 09:14 PM, Ulf Hansson wrote:
> On 4 April 2016 at 04:08, Jaehoon Chung <jh80.chung@samsung.com> wrot=
e:
>> Hi All,
>>
>> Are there any other opinion for this RFC patch?
>>
>> Best Regards,
>> Jaehoon Chung
>>
>> On 03/30/2016 09:15 AM, Shawn Lin wrote:
>>> =E5=9C=A8 2016/3/29 18:49, Jisheng Zhang =E5=86=99=E9=81=93:
>>>> Hi Jaehoon,
>>>>
>>>> On Tue, 29 Mar 2016 19:43:34 +0900 Jaehoon Chung wrote:
>>>>
>>>>> This patch is just RFC. I want to know opinions.
>>>>>
>>>>> Now, index of mmcblk is allocated in accordance with probing time=
=2E
>>>>> If want to use the mmcblk1 for some device, it can use alias.
>>>>>
>>>>> aliases {
>>>>>     mmc0 =3D &mmc0;    /* mmcblk0 for eMMC */
>>>>>     mmc1 =3D &mmc2;    /* mmcblk1 for SD */
>>>>>     mmc2 =3D &mmc1;    /* mmcblk2 for SDIO*/
>>>>> };
>>>>
>>>> I like this feature and we do need it. In the past, we have to put=
 emmc dt node
>>>> before the sd node, but on our platform, the register base of sdhc=
 host for emmc
>>>> is higher than the one for sd, putting emmc dt node before sd look=
s a bit
>>>> strange, but we have no better solutions.
>>>>
>>>
>>> :) That is also what I suffered currently. I have to prepare two
>>> seperate firmware with two diff fstab files to assign the mount poi=
nt
>>> since sometime I need to boot from sd, but sometimes from emmc....
>>> With this patch, I only need to dtc a new dtb... quite simple.
>>>
>>>> Thanks,
>>>> Jisheng
>=20
> I am not immediately opposed to this patch, although let me think a
> bit more about it.
>=20
> What I would like to understand is why UUID/PARTUUID isn't working fo=
r
> your case. Did you try to use that?

I have used with UUID/PARTUUID/PARTLABEL and etc.. I think it's not pro=
blem.
But that is why some guys wants to use the fixed index.
(Almost all SoCs are still using "root=3Dmmcblk0pX" in bootloader.)

I'm considering more what is better. :)

Best Regards,
Jaehoon Chung

>=20
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20

