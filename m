From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 0/3] OMAP: HSMMC: cleanup and runtime pm
Date: Tue, 05 Jul 2011 10:43:57 -0700
Message-ID: <87zkkssjvm.fsf@ti.com>
References: <1309538376-23260-1-git-send-email-balajitk@ti.com>
	<8762nlzy1d.fsf@ti.com>
	<CANrkHUb-i4cQmGzrDjcooZPRvyQLSd0+kqLMA04hGzgVjCT+=A@mail.gmail.com>
	<CANfBPZ-A8WMqjkNspvtXK1FSE1BRG_PE6JKKqmLWQerzn=h2Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:54182 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752431Ab1GERoD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 5 Jul 2011 13:44:03 -0400
In-Reply-To: <CANfBPZ-A8WMqjkNspvtXK1FSE1BRG_PE6JKKqmLWQerzn=h2Xw@mail.gmail.com>
	(Venkatraman S.'s message of "Mon, 4 Jul 2011 23:35:31 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: "T Krishnamoorthy, Balaji" <balajitk@ti.com>, Chris Ball <cjb@laptop.org>, Madhusudhan <madhu.cr@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Benoit Cousson <b-cousson@ti.com>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>

"S, Venkatraman" <svenkatr@ti.com> writes:

>> From: Kevin Hilman <khilman@ti.com>
>> Date: Fri, Jul 1, 2011 at 11:24 PM
>> Subject: Re: [PATCHv4 0/3] OMAP: HSMMC: cleanup and runtime pm
>> To: cjb@laptop.org
>> Cc: Balaji T K <balajitk@ti.com>, linux-omap@vger.kernel.org,
>> linux-mmc@vger.kernel.org, tony@atomide.com, madhu.cr@ti.com,
>> b-cousson@ti.com, paul@pwsan.com, kishore.kadiyala@ti.com
>>
>>
>> Chris,
>>
>> Balaji T K <balajitk@ti.com> writes:
>>
>>> Removing the custom state machine - lazy disable framework in
>>> omap_hsmmc to make way for runtime pm to handle host controller pow=
er
>>> states.
>>>
>>> This allows mmc_host_enable/mmc_host_disable to be replaced
>>> by runtime get_sync and put_sync at host controller driver.
>>>
>>> Enable runtime PM in omap_hsmmc
>>>
>>> Rebased to MMC tree : mmc-next branch
>>> Tested on OMAP4430SDP, OMAP3430SDP, OMAP2430SDP
>>
>> Reviewed-by: Kevin Hilman <khilman@ti.com>
>> Tested-by: Kevin Hilman <khilman@ti.com>
>>
>> Could you queue this series for the v3.1 merge window? =C2=A0Or, wit=
h your
>> ack, we are happy to take this through the OMAP tree along with the
>> other dependecies mentioned below.
>>
>> I've also tested this on OMAP4430/Blaze, OMAP3630/Zoom3 and
>> OMAP3430/n900.
>>
>> We have OMAP PM core code changes queued for v3.1 which require the =
MMC
>> driver to correctly use runtime PM or we can get hangs if MMC is use=
d
>> during boot.
>>
>> Kevin
>
> Kevin,
>   Another series from Per Forlin [1] is also modifying the same file,
> and might result in merge conflict if this series is queued under OMA=
P
> and the other is queued by Chris.

OK, then Chris should take this series through his tree.

Thanks,

Kevin

> Chris,
>   If you intend to queue [1] into mmc-next, Balaji / myself can repos=
t
> this series on
> top of it or you'd like to practice some git merge ? Let me know if
> there is anything that I can do to help.
>
> [1] https://lkml.org/lkml/2011/7/1/303
>
>>
>>> MMC runtime patch has dependency on
>>> [PATCH 0/6] OMAP2+: hwmod framework fixes [1]
>>> for MMC1/MMC2 clock to get ungated after idle in OMAP4.
>>>
>>> Without [1] patches, MMC1/MMC2 fails to get detected on OMAP4.
>>>
>>> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg51457=
=2Ehtml
>>>
>>> Balaji T K (3):
>>> =C2=A0 MMC: OMAP: HSMMC: Remove lazy_disable
>>> =C2=A0 MMC: OMAP: HSMMC: add runtime pm support
>>> =C2=A0 MMC: OMAP: HSMMC: Remove unused iclk
>>>
>>> =C2=A0drivers/mmc/host/omap_hsmmc.c | =C2=A0365 +++++++------------=
----------------------
>>> =C2=A01 files changed, 57 insertions(+), 308 deletions(-)
>>
