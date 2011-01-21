From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v2] sdio: skip initialization on powered resume
Date: Fri, 21 Jan 2011 04:07:23 -0500
Message-ID: <AANLkTinjpe8iGcOyru=09WrBq4f5PfBo2QcUs40OycXg@mail.gmail.com>
References: <1283391692-14150-1-git-send-email-bzhao@marvell.com>
	<alpine.LFD.2.00.1009021344430.19366@xanadu.home>
	<477F20668A386D41ADCC57781B1F704307D2F41B27@SC-VEXCH1.marvell.com>
	<alpine.LFD.2.00.1009021923171.19366@xanadu.home>
	<477F20668A386D41ADCC57781B1F704307D2FE4A0F@SC-VEXCH1.marvell.com>
	<alpine.LFD.2.00.1009072119210.19366@xanadu.home>
	<477F20668A386D41ADCC57781B1F704307D2FE4A52@SC-VEXCH1.marvell.com>
	<1284459351.2359.17.camel@stummala-linux.in.qualcomm.com>
	<477F20668A386D41ADCC57781B1F704307D30738F5@SC-VEXCH1.marvell.com>
	<alpine.LFD.2.00.1009152222400.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:32876 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab1AUJHZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Jan 2011 04:07:25 -0500
Received: by fxm20 with SMTP id 20so1527257fxm.19
        for <linux-mmc@vger.kernel.org>; Fri, 21 Jan 2011 01:07:24 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1009152222400.19366@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>, Bing Zhao <bzhao@marvell.com>
Cc: Sahitya Tummala <stummala@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Michal Miroslaw <mirqus@gmail.com>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, Maxim Levitsky <maximlevitsky@gmail.com>

On Wed, Sep 15, 2010 at 10:26 PM, Nicolas Pitre <nico@fluxnic.net> wrot=
e:
> On Wed, 15 Sep 2010, Bing Zhao wrote:
>
>> If CMD7 is sent _before_ client driver's resume handler is called,
>> while 8686 card is in sleep mode, it will fail. If CMD7 is sent
>> _after_ client driver's resume handler is called, it should succeed.
>
> Maybe that's what we should do in the powered suspend case then.
>
>> By the way, a patch "mmc: fix all hangs related to mmc/sd card
>> insert/removal during suspend/resume"
>> (4c2ef25fe0b847d2ae818f74758ddb0be1c27d8e by Maxim Levitsky) has
>> removed the call to mmc_detect_change() in mmc_resume_host().
>
> If a card is removed while the host is suspended, then this should be
> detected.
>
>
> Nicolas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Hi, Bing

Do you have any updated patch to skip mmc_sdio_init_card in resume back=
=2E
We need such patch in enable host sleep feature for mrvl8787.

Thanks a lot.
