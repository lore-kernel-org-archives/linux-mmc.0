From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc:sdhci: handle busy-end interrupt during command
Date: Fri, 29 Aug 2014 13:18:42 +0200
Message-ID: <CAPDyKFrgu04FTWeSkWz1-YeHqSUe+9BE1Jk4wqBugVK4Ze90mw@mail.gmail.com>
References: <1408585989-1084-1-git-send-email-chanho.min@lge.com>
	<CAPDyKFoeONs8OXZ3=2ZT54Nfdq_dLqgatMcq2DyZ=rs1r0x+dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:51495 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbaH2LSo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Aug 2014 07:18:44 -0400
Received: by mail-lb0-f177.google.com with SMTP id z11so2386790lbi.22
        for <linux-mmc@vger.kernel.org>; Fri, 29 Aug 2014 04:18:42 -0700 (PDT)
In-Reply-To: <CAPDyKFoeONs8OXZ3=2ZT54Nfdq_dLqgatMcq2DyZ=rs1r0x+dg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chanho Min <chanho.min@lge.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hankyung Yu <hankyung.yu@lge.com>, Gwendal Grignou <gwendal@chromium.org>

On 21 August 2014 09:26, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 21 August 2014 03:53, Chanho Min <chanho.min@lge.com> wrote:
>> It is fully legal for a controller to start handling busy-end interrupt
>> before it has signaled that the command has completed. So make sure
>> we do things in the proper order, Or it results that command interrupt
>> is ignored so it can cause unexpected operations. This is founded at some
>> toshiba emmc with the bellow warning.
>>
>> "mmc0: Got command interrupt 0x00000001 even though
>> no command operation was in progress."
>>
>> This issue has been also reported by Youssef TRIKI:
>> It is not specific to Toshiba devices, and happens with eMMC devices
>> as well as SD card which support Auto-CMD12 rather than CMD23.
>>
>> Also, similar patch is submitted by:
>> Gwendal Grignou <gwendal@chromium.org>
>>
>> Signed-off-by: Hankyung Yu <hankyung.yu@lge.com>
>> Signed-off-by: Chanho Min <chanho.min@lge.com>
>> Tested-by: Youssef TRIKI <youssef.triki@st.com>
>
> Hi Chanho,
>
> This patch has been around for quite some time, sorry for lack of
> response. Appreciate if we could get this tested on a few more
> variants of sdhci, I am not able to test myself.
>
> I plan to queue this for 3.18, unless someone objects soon.

Hi Chanho,

I was about to apply this one, but I am hitting a conflict. Even if
wasn't too hard for me to resolve it, I think it might need an extra
round of testing. Could you please re-spin and send a new version?

Kind regards
Uffe
