From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH v4 0/4]implement eMMC4.4 standard HW reset feature
Date: Tue, 7 Dec 2010 10:34:25 +0900
Message-ID: <AANLkTinrPd9p4ocmE+Krj7t4yV8SMPsDeDFuTByy2=Q4@mail.gmail.com>
References: <20101201124842.GA5421@intel.com>
	<5D8008F58939784290FAB48F54975198320B3E4A2D@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f180.google.com ([209.85.161.180]:59329 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138Ab0LGBe0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Dec 2010 20:34:26 -0500
In-Reply-To: <5D8008F58939784290FAB48F54975198320B3E4A2D@shsmsx502.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "arjan@linux.intel.com" <arjan@linux.intel.com>, "alan@linux.intel.com" <alan@linux.intel.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Mai, Leonard" <leonard.mai@intel.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <w.sang@pengutronix.de>

On Tue, Dec 7, 2010 at 1:03 AM, Dong, Chuanxiao
<chuanxiao.dong@intel.com> wrote:
> Hello all,
> How about these patches? It implemented HW reset feature. When card o=
ccurred a timeout error during reading/writing/erasing, these patches w=
ill allow driver to reset eMMC card by trigger a HW reset signal.
> Does anyone have any comments about the implementation of these patch=
es? Wolfram and Arnd already pointed out the unsuitable patch headers. =
Thanks! :)

Hi,
I'm not yet find a reason to use this feature. Now it uses the samsung
and sandisk v4.41 but still no problem.
I wonder what's the purpose and effect if it uses or not?

Thank you,
Kyungmin Park

>
>
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org
>> [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Chuanxiao Dong
>> Sent: Wednesday, December 01, 2010 8:49 PM
>> To: linux-mmc@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org; cjb@laptop.org; arjan@linux.intel.=
com;
>> alan@linux.intel.com; akpm@linux-foundation.org
>> Subject: [PATCH v4 0/4]implement eMMC4.4 standard HW reset feature
>>
>> Hi,
>> =A0 =A0 =A0 These are the version 4 patches to implement eMMC4.4 HW =
reset
>> =A0 =A0 =A0 feature. Host controller can use this feature by trigger=
 RST_n signal.
>> =A0 =A0 =A0 To enable this, byte 162 of EXT_CSD register should be s=
et.
>> =A0 =A0 =A0 HW reset is implemented in mmc core layer and sdhci host=
 layer, and it
>> =A0 =A0 =A0 will be used after each reading/writing/erasing timeout =
error occures.
>>
>> =A0 =A0 =A0 change-log:
>> =A0 =A0 =A0 This version change the way to detect timeout error cond=
itions. Added a
>> =A0 =A0 =A0 new routine mmc_handle_timeout_error to do this instead =
to do this in
>> =A0 =A0 =A0 mmc_wait_for_req. Each timeout read/write/erase command =
can use this
>> =A0 =A0 =A0 routine to do HW reset.
>>
>> =A0 =A0 =A0 patch1: enable HW reset capability if card support.
>>
>> =A0 =A0 =A0 patch2: add two new callback to implement HW reset in mm=
c core layer. In
>> =A0 =A0 =A0 this patch, routine mmc_handle_timeout_error was added.
>>
>> =A0 =A0 =A0 patch3: implement hardware_reset callback for sdhci host=
=2E A new callback
>> =A0 =A0 =A0 reset_emmc was defined which will be each sdhci host con=
troller to
>> =A0 =A0 =A0 implement separately.
>>
>> =A0 =A0 =A0 patch4: did a HW reset after each read/write/erase comma=
nd.
>>
>> Thanks
>> Chuanxiao
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
