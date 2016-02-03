From: Mason <slash.tmp@free.fr>
Subject: Re: arasan,sdhci.txt "compatibility" DT binding
Date: Wed, 3 Feb 2016 09:31:52 +0100
Message-ID: <56B1BAF8.2050907@free.fr>
References: <56B07BA5.4060407@free.fr> <56B166F1.5080605@rock-chips.com>
 <56B1AA44.1010108@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:46173 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756381AbcBCIcH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 3 Feb 2016 03:32:07 -0500
In-Reply-To: <56B1AA44.1010108@xilinx.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: Michal Simek <monstr@monstr.eu>, Anton Vorontsov <anton@enomsg.org>, Xiaobo Xie <x.xie@freescale.com>, Suman Tripathi <stripathi@apm.com>, soren.brinkmann@xilinx.com

On 03/02/2016 08:20, Michal Simek wrote:

> Hi,
>=20
> On 3.2.2016 03:33, Shawn Lin wrote:
>> + Michal, S=F6ren Brinkmann
>>
>> On 2016/2/2 17:49, Mason wrote:
>>> Hello everyone,
>>>
>>> Documentation/devicetree/bindings/mmc/arasan,sdhci.txt states:
>>>
>>> Required Properties:
>>>    - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' =
or
>>>                  'arasan,sdhci-4.9a' or 'arasan,sdhci-5.1'
>>>
>>> What do 8.9a, 4.9a, and 5.1 refer to?
>>>
>>
>> Good question.
>>
>> Michal told me that 8.9a and 4.9a came from Xilinx
>> databook which define their available arasan controller to be versio=
n
>> 4.9a and 8.9a.
>=20
> Our version is coming from here.
> http://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-70=
00-TRM.pdf
> page 28
>=20
> Datasheets from 2012 and 2010 doesn't look too recent and I expect th=
at
> Arasan did a lot of work from that time that's why I am not surprised
> that you are not able to see that versions.

Hello Michal,

I'm even more confused.

Arasan's 2010-02-19 data sheet is titled
SD3.0 / SDIO3.0 / eMMC4.4 AHB Host Controller

Page 28 of the Xilinx data sheet mentions
SD2.0 / SDIO2.0 / MMC3.31 AHB Host Controller
Version 8.9A_apr02nd_2010

It does not make sense that Arasan would support SD3.0 in February,
then go back to SD 2.0 in April.

I do note eMMC4.4 vs MMC3.31 =3D> perhaps these are two *different*
IP blocks?

Do your data sheets come with revision history?

Regards.

