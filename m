From: Sergey Priporov <spriporov@gmail.com>
Subject: Re: [RFC PATCH 00/11] [FS, MM, block, MMC]: eMMC High Priority
 Interrupt Feature
Date: Wed, 9 Jan 2013 13:12:23 -0800
Message-ID: <CAF_zY_UqMC=S+XFxSyZ2VWLFKYegp9S8M8zt6nU_Sz48kTB07w@mail.gmail.com>
References: <1334730332-22244-1-git-send-email-svenkatr@ti.com>
	<3a028a6583c7fac372c8711930fc1874.squirrel@www.codeaurora.org>
	<loom.20130108T185414-599@post.gmane.org>
	<50ED272B.4000004@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ia0-f170.google.com ([209.85.210.170]:52097 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933689Ab3AIVMY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Jan 2013 16:12:24 -0500
Received: by mail-ia0-f170.google.com with SMTP id i1so1957161iaa.1
        for <linux-mmc@vger.kernel.org>; Wed, 09 Jan 2013 13:12:24 -0800 (PST)
In-Reply-To: <50ED272B.4000004@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, Maya Erez <merez@codeaurora.org>

Konstantin,

Thank you for update. We also are reviewing file IO operations
scheduler . Looks like for eMMC  current scheduler is not good
tailored (since eMMC is not hard drive :) )

Sergey

On Wed, Jan 9, 2013 at 12:15 AM, Konstantin Dorfman
<kdorfman@codeaurora.org> wrote:
> Hello Sergey,
>
> I'm working on the same flow - to reduce read latency hit (as a resul=
t of
> big aggregated writes). I plan to send all relevant patches to the ma=
iling
> list soon and it will be great if you can test them on your system.
>
> There are requirements for this flow is:
>  - eMMC 4.5 supported by card (this means HPI)
>  - host controller shoud implement stop request api (that is be able
> correctly stop DMA & all internal state and be ready for next read
> transaction.
>
> Right now, please look at this patches as reference:
>
> 1. [RFC/PATCH 0/2] Handling urgent and new request notifications.
> 2. [RFC/PATCH 1/2] mmc: Urgent data request flow.
>
> This is old changes, just for the solution overview.
>
> Thanks,
>
>> Hi Venkat,
>>
>> I was looking for some explanations of eMMC behavior in products we =
 are
>> developing now and found your comments around eMMC here. Our observa=
tion
>> shows
>> that that eMMC performance vary significantly and depends on volume =
of
>> data to
>> write during time slot and temperature. After a heavy write test was=
 run
>> for
>> some time for a good performance eMMC (showing 10-12MB/s of the writ=
e
>> performance on big blocks) its write performance degraded to the 4-5=
MB/s.
>> We even observed performance lowest level as 65KB/s!
>> There are a lot of Write type of operations necessary into dedicated=
 eMMC
>> partition by requirements.
>> The side effect is that long write operations block  Application UI =
to
>> redraw
>> the  views  because it requires Read operations.
>> Visually we see =E2=80=9CBlank Dark Screen=E2=80  for few seconds an=
d even ANRs. So
>> HMI may
>> help us.
>>
>> Question:  Did you finish research with HPI to try ?  Which type of =
eMMC
>> did
>> you use?
>>
>> P.S. We use TI BSP for OMAP3630 for Android
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
