From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH] mmc: block: Support the fixed index for mmcblk with
 aliases nodes
Date: Mon, 4 Apr 2016 14:14:47 +0200
Message-ID: <CAPDyKFqOJ1+ngcSjnyS4ysYJHBGvuOQLCD5oVcB3t-QrTN3b=g@mail.gmail.com>
References: <56FA5C56.9080009@samsung.com>
	<20160329184920.29a240fc@xhacker>
	<56FB1AA2.8050005@rock-chips.com>
	<5701CCAF.4090102@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33265 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbcDDMOt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2016 08:14:49 -0400
Received: by mail-lf0-f49.google.com with SMTP id p188so140332035lfd.0
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2016 05:14:48 -0700 (PDT)
In-Reply-To: <5701CCAF.4090102@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jisheng Zhang <jszhang@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 4 April 2016 at 04:08, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi All,
>
> Are there any other opinion for this RFC patch?
>
> Best Regards,
> Jaehoon Chung
>
> On 03/30/2016 09:15 AM, Shawn Lin wrote:
>> =E5=9C=A8 2016/3/29 18:49, Jisheng Zhang =E5=86=99=E9=81=93:
>>> Hi Jaehoon,
>>>
>>> On Tue, 29 Mar 2016 19:43:34 +0900 Jaehoon Chung wrote:
>>>
>>>> This patch is just RFC. I want to know opinions.
>>>>
>>>> Now, index of mmcblk is allocated in accordance with probing time.
>>>> If want to use the mmcblk1 for some device, it can use alias.
>>>>
>>>> aliases {
>>>>     mmc0 =3D &mmc0;    /* mmcblk0 for eMMC */
>>>>     mmc1 =3D &mmc2;    /* mmcblk1 for SD */
>>>>     mmc2 =3D &mmc1;    /* mmcblk2 for SDIO*/
>>>> };
>>>
>>> I like this feature and we do need it. In the past, we have to put =
emmc dt node
>>> before the sd node, but on our platform, the register base of sdhc =
host for emmc
>>> is higher than the one for sd, putting emmc dt node before sd looks=
 a bit
>>> strange, but we have no better solutions.
>>>
>>
>> :) That is also what I suffered currently. I have to prepare two
>> seperate firmware with two diff fstab files to assign the mount poin=
t
>> since sometime I need to boot from sd, but sometimes from emmc....
>> With this patch, I only need to dtc a new dtb... quite simple.
>>
>>> Thanks,
>>> Jisheng

I am not immediately opposed to this patch, although let me think a
bit more about it.

What I would like to understand is why UUID/PARTUUID isn't working for
your case. Did you try to use that?

Kind regards
Uffe
