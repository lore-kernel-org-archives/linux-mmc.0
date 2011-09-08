From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [RFC/RFT] MMC: CORE: eMMC in Sleep mode before suspend
Date: Thu, 8 Sep 2011 21:31:18 +0530
Message-ID: <CANrkHUaEU2tydj5yoA7fB_Lic6dBhXgfcFTcxSSHTzmPO1ZGpw@mail.gmail.com>
References: <1310567787-14697-1-git-send-email-balajitk@ti.com>
	<CANfBPZ-dwv1e1JweRR5jFu2rLRxQCWd+ibuaN2RHv+gCZcQeOw@mail.gmail.com>
	<m21uxm9pym.fsf@bob.laptop.org>
	<4E28882A.2020405@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:60802 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752978Ab1IHXGN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Sep 2011 19:06:13 -0400
Received: by mail-ww0-f43.google.com with SMTP id 32so358193wwe.24
        for <linux-mmc@vger.kernel.org>; Thu, 08 Sep 2011 16:06:10 -0700 (PDT)
In-Reply-To: <4E28882A.2020405@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <cjb@laptop.org>, "S, Venkatraman" <svenkatr@ti.com>, linux-mmc@vger.kernel.org

On Fri, Jul 22, 2011 at 1:42 AM, Adrian Hunter <adrian.hunter@intel.com=
> wrote:
> On 19/07/2011 7:48 p.m., Chris Ball wrote:
>>
>> Hi,
>>
>> On Tue, Jul 19 2011, S, Venkatraman wrote:
>>>
>>> On Wed, Jul 13, 2011 at 8:06 PM, Balaji T K<balajitk@ti.com> =A0wro=
te:
>>>>
>>>> Put MMC to sleep if it supports SLEEP/AWAKE (CMD5)
>>>> in the mmc suspend to minimize power consumption.
>>>>
>>>> Signed-off-by: Balaji T K<balajitk@ti.com>
>>>
>>> Balaji,
>>> =A0 Would you mind reposting the patch without the RFC and s/CORE/c=
ore
>>> in subject line ?
>>> You can add my
>>> Acked-by: Venkatraman S<svenkatr@ti.com>
>>
>> No need to resend, thanks -- pushed to mmc-next with these changes a=
nd
>> the ACK.
>>
>> Anyone object to letting this soak in mmc-next for a release and mer=
ging
>> it in 3.2? =A0I'm worried that we'll find card or host quirks around=
 this,
>> and the 3.0 release is probably happening today.
>
> eMMC often have VccQ (logic) always on (or sharing the same power as =
SDRAM
> which comes to the same thing), but can switch off Vcc (NAND core).
> =A0However, turning off Vcc without first putting the card to sleep c=
an result
> in errors i.e. you are not allowed to do it.
>
> This patch seems to be covering the "VccQ always on" case but relies =
on CMD0
> to wake up the card.
>
> If that is what is going on, then some comments to that effect are ne=
eded,
> including within mmc_init_card to note that mmc_go_idle is needed for=
 cards
> that are asleep - if that is, in fact, correct.

Yes, current implementation depends on CMD0 in mmc_init_card to wakeup.
Specification allows eMMC card in sleep to respond to CMD0/CMD5
Will send an updated patch with comments added.

>
> Also, wouldn't it be nice to wake up the card with CMD5 which should =
be much
> faster than re-initialising?
>
>> - Chris.
>
>
