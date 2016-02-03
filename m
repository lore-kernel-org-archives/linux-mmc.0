From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: arasan,sdhci.txt "compatibility" DT binding
Date: Wed, 3 Feb 2016 10:58:24 +0100
Message-ID: <56B1CF40.1030203@xilinx.com>
References: <56B07BA5.4060407@free.fr> <56B166F1.5080605@rock-chips.com>
 <56B1AA44.1010108@xilinx.com> <56B1BAF8.2050907@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam02on0064.outbound.protection.outlook.com ([104.47.36.64]:31393
	"EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752183AbcBCJ6i (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 3 Feb 2016 04:58:38 -0500
In-Reply-To: <56B1BAF8.2050907@free.fr>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mason <slash.tmp@free.fr>, Michal Simek <michal.simek@xilinx.com>, Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: Michal Simek <monstr@monstr.eu>, Anton Vorontsov <anton@enomsg.org>, Xiaobo Xie <x.xie@freescale.com>, Suman Tripathi <stripathi@apm.com>, soren.brinkmann@xilinx.com

On 3.2.2016 09:31, Mason wrote:
> On 03/02/2016 08:20, Michal Simek wrote:
>=20
>> Hi,
>>
>> On 3.2.2016 03:33, Shawn Lin wrote:
>>> + Michal, S=F6ren Brinkmann
>>>
>>> On 2016/2/2 17:49, Mason wrote:
>>>> Hello everyone,
>>>>
>>>> Documentation/devicetree/bindings/mmc/arasan,sdhci.txt states:
>>>>
>>>> Required Properties:
>>>>    - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a'=
 or
>>>>                  'arasan,sdhci-4.9a' or 'arasan,sdhci-5.1'
>>>>
>>>> What do 8.9a, 4.9a, and 5.1 refer to?
>>>>
>>>
>>> Good question.
>>>
>>> Michal told me that 8.9a and 4.9a came from Xilinx
>>> databook which define their available arasan controller to be versi=
on
>>> 4.9a and 8.9a.
>>
>> Our version is coming from here.
>> http://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7=
000-TRM.pdf
>> page 28
>>
>> Datasheets from 2012 and 2010 doesn't look too recent and I expect t=
hat
>> Arasan did a lot of work from that time that's why I am not surprise=
d
>> that you are not able to see that versions.
>=20
> Hello Michal,
>=20
> I'm even more confused.
>=20
> Arasan's 2010-02-19 data sheet is titled
> SD3.0 / SDIO3.0 / eMMC4.4 AHB Host Controller
>=20
> Page 28 of the Xilinx data sheet mentions
> SD2.0 / SDIO2.0 / MMC3.31 AHB Host Controller
> Version 8.9A_apr02nd_2010
>=20
> It does not make sense that Arasan would support SD3.0 in February,
> then go back to SD 2.0 in April.
>=20
> I do note eMMC4.4 vs MMC3.31 =3D> perhaps these are two *different*
> IP blocks?
>=20
> Do your data sheets come with revision history?

I don't have datasheet for this IP in my hand that's why I can't check =
it.
But I can't see any problem with it. Our zynq SoC supports SD2.0 and it
was requirement at that time. Bugs can happen. Arasan fixed it and
create new version.
At the same time can have 3.0 versions but vendor is just decide not to
use it for whatever reason.

That's why timing of features and versions can upgrade any time and
unfortunately bugs happen.

Thanks,
Michal
