From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: [RFC PATCH 00/11] [FS, MM, block,      MMC]: eMMC High Priority
 Interrupt Feature
Date: Wed, 09 Jan 2013 10:15:39 +0200
Message-ID: <50ED272B.4000004@codeaurora.org>
References: <1334730332-22244-1-git-send-email-svenkatr@ti.com>    <3a028a6583c7fac372c8711930fc1874.squirrel@www.codeaurora.org>    <loom.20130108T185414-599@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:64337 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756051Ab3AIIPn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Jan 2013 03:15:43 -0500
In-Reply-To: <loom.20130108T185414-599@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergey Priporov <spriporov@gmail.com>
Cc: linux-mmc@vger.kernel.org, Maya Erez <merez@codeaurora.org>

Hello Sergey,

I'm working on the same flow - to reduce read latency hit (as a result=20
of big aggregated writes). I plan to send all relevant patches to the=20
mailing list soon and it will be great if you can test them on your sys=
tem.

There are requirements for this flow is:
  - eMMC 4.5 supported by card (this means HPI)
  - host controller shoud implement stop request api (that is be able=20
correctly stop DMA & all internal state and be ready for next read=20
transaction.

Right now, please look at this patches as reference:

1. [RFC/PATCH 0/2] Handling urgent and new request notifications.
2. [RFC/PATCH 1/2] mmc: Urgent data request flow.

This is old changes, just for the solution overview.

Thanks,

> Hi Venkat,
>
> I was looking for some explanations of eMMC behavior in products we  =
are
> developing now and found your comments around eMMC here. Our observat=
ion
> shows
> that that eMMC performance vary significantly and depends on volume o=
f
> data to
> write during time slot and temperature. After a heavy write test was =
run
> for
> some time for a good performance eMMC (showing 10-12MB/s of the write
> performance on big blocks) its write performance degraded to the 4-5M=
B/s.
> We even observed performance lowest level as 65KB/s!
> There are a lot of Write type of operations necessary into dedicated =
eMMC
> partition by requirements.
> The side effect is that long write operations block  Application UI t=
o
> redraw
> the  views  because it requires Read operations.
> Visually we see =C3=A2=C2=80=C2=9CBlank Dark Screen=C3=A2=C2=80=C2=9D=
 for few seconds and even ANRs. So
> HMI may
> help us.
>
> Question:  Did you finish research with HPI to try ?  Which type of e=
MMC
> did
> you use?
>
> P.S. We use TI BSP for OMAP3630 for Android
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
