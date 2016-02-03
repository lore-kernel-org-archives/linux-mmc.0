From: Mason <slash.tmp@free.fr>
Subject: Re: arasan,sdhci.txt "compatibility" DT binding
Date: Wed, 3 Feb 2016 16:33:47 +0100
Message-ID: <56B21DDB.6050708@free.fr>
References: <56B07BA5.4060407@free.fr> <56B166F1.5080605@rock-chips.com>
 <56B1AA44.1010108@xilinx.com> <56B1BAF8.2050907@free.fr>
 <56B1CF40.1030203@xilinx.com> <20160203152104.GP4215@xsjsorenbubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:50969 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756073AbcBCPd7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 3 Feb 2016 10:33:59 -0500
In-Reply-To: <20160203152104.GP4215@xsjsorenbubuntu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc <linux-mmc@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, Anton Vorontsov <anton@enomsg.org>, Xiaobo Xie <x.xie@freescale.com>, Suman Tripathi <stripathi@apm.com>

On 03/02/2016 16:21, S=C3=B6ren Brinkmann wrote:
> On Wed, 2016-02-03 at 10:58:24 +0100, Michal Simek wrote:
>> On 3.2.2016 09:31, Mason wrote:
>>> On 03/02/2016 08:20, Michal Simek wrote:
>>>
>>>> Hi,
>>>>
>>>> On 3.2.2016 03:33, Shawn Lin wrote:
>>>>> + Michal, S=C3=B6ren Brinkmann
>>>>>
>>>>> On 2016/2/2 17:49, Mason wrote:
>>>>>> Hello everyone,
>>>>>>
>>>>>> Documentation/devicetree/bindings/mmc/arasan,sdhci.txt states:
>>>>>>
>>>>>> Required Properties:
>>>>>>    - compatible: Compatibility string. Must be 'arasan,sdhci-8.9=
a' or
>>>>>>                  'arasan,sdhci-4.9a' or 'arasan,sdhci-5.1'
>>>>>>
>>>>>> What do 8.9a, 4.9a, and 5.1 refer to?
>>>>>>
>>>>>
>>>>> Good question.
>>>>>
>>>>> Michal told me that 8.9a and 4.9a came from Xilinx
>>>>> databook which define their available arasan controller to be ver=
sion
>>>>> 4.9a and 8.9a.
>>>>
>>>> Our version is coming from here.
>>>> http://www.xilinx.com/support/documentation/user_guides/ug585-Zynq=
-7000-TRM.pdf
>>>> page 28
>>>>
>>>> Datasheets from 2012 and 2010 doesn't look too recent and I expect=
 that
>>>> Arasan did a lot of work from that time that's why I am not surpri=
sed
>>>> that you are not able to see that versions.
>>>
>>> Hello Michal,
>>>
>>> I'm even more confused.
>>>
>>> Arasan's 2010-02-19 data sheet is titled
>>> SD3.0 / SDIO3.0 / eMMC4.4 AHB Host Controller
>>>
>>> Page 28 of the Xilinx data sheet mentions
>>> SD2.0 / SDIO2.0 / MMC3.31 AHB Host Controller
>>> Version 8.9A_apr02nd_2010
>>>
>>> It does not make sense that Arasan would support SD3.0 in February,
>>> then go back to SD 2.0 in April.
>>>
>>> I do note eMMC4.4 vs MMC3.31 =3D> perhaps these are two *different*
>>> IP blocks?
>>>
>>> Do your data sheets come with revision history?
>>
>> I don't have datasheet for this IP in my hand that's why I can't che=
ck it.
>> But I can't see any problem with it. Our zynq SoC supports SD2.0 and=
 it
>> was requirement at that time. Bugs can happen. Arasan fixed it and
>> create new version.
>> At the same time can have 3.0 versions but vendor is just decide not=
 to
>> use it for whatever reason.
>>
>> That's why timing of features and versions can upgrade any time and
>> unfortunately bugs happen.
>=20
> We have several Arasan data sheets here. The document names are:
> "SD2.0 / SDIO2.0 / MMC3.31 AHB Userguide" and the revisions are 9.2a,
> 4.4a and 5.4a. I have the feeling that the document revisions have
> been mistaken as the IP revision. I cannot find any other indicator
> for the IP revision though. Does the IP have a way to discover its
> revision?

To summarize, it looks to me like
4.9a and 8.9a are documentation revision numbers for this IP:
"SD2.0 / SDIO2.0 / MMC3.31 AHB Host Controller"

and 5.1 seems to be the eMMC standard, so one of these IP:
http://arasan.com/products/emmc51/sd3-emmc-5-1-host/
http://arasan.com/products/emmc51/emmc-5-1-sd-4-1-host/

Whereas my board is using still another IP:
"SD3.0 / SDIO3.0 / eMMC4.4 AHB Host Controller"


If that is correct, then I should be able to use the 8.9a
compatible string, and perhaps my hardware will work in
slightly degraded performance mode, from not using the
newest protocol gizmos available.

Does that look likely?

Regards.

