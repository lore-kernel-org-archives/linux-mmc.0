From: Carlo Caione <carlo@caione.org>
Subject: Re: [PATCH v4] mmc: meson: Add driver for the SD/MMC host found on
 Amlogic MesonX SoCs
Date: Mon, 1 Feb 2016 23:05:31 +0100
Message-ID: <CAOQ7t2afXxStCsj=M-FX7eMep1gLt4jkyXDiLas_SQ1UwHc0=Q@mail.gmail.com>
References: <1448988109-32630-1-git-send-email-carlo@caione.org>
	<CAPDyKFp=buvJ8Li3XC8XSUAUO7BsE+U6vEQH2xTrgcHAkdG8bQ@mail.gmail.com>
	<CAOQ7t2aJAPWd3Xmvu7n0EWL-KC8ZriM3KryfsYEh556uXhuR+g@mail.gmail.com>
	<CAPDyKFpcsKihuOiF5=RwoWrF0Jf7hRsXVSU5uV8qZf1mUsa-iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34626 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524AbcBAWFc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Feb 2016 17:05:32 -0500
Received: by mail-wm0-f67.google.com with SMTP id p63so11067632wmp.1
        for <linux-mmc@vger.kernel.org>; Mon, 01 Feb 2016 14:05:32 -0800 (PST)
In-Reply-To: <CAPDyKFpcsKihuOiF5=RwoWrF0Jf7hRsXVSU5uV8qZf1mUsa-iQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-meson@googlegroups.com, linux@endlessm.com

On Tue, Dec 8, 2015 at 9:35 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

Hi Ulf,
(old thread, I know)

>> I have actually a problem and a question related to this value. On the
>> boards I'm currently using to test this driver I have no CD GPIO. In
>> this case do I have to specify the MMC as "non-removable"? Also if I
>
> "non-removable" is intended to be used for eMMC or other cards
> (SD/SDIO) that is not possible to remove/insert at runtime.
>
>> try to change an SD card at runtime I have to wait 3 times the timeout
>> before being able to do it successfully.
>
> I guess you are using the "broken-cd" binding, which will enable
> MMC_CAP_NEEDS_POLL and thus the mmc core will poll to detect cards
> being inserted or removed.

I still fail to see what the correct behaviour should be.
Using the v4 of this driver with a "broken-cd" binding and a timeout
of 10s my SD card takes 30s to be identified as removed after I take
it out from the SD slot.
Also, if I take it out and insert it again, I still have to wait 30s
to be able to access it again. Is this a limitation / bug of my driver
or is this the expected behaviour when we do not have a dedicated GPIO
for card detection?

Cheers,

-- 
Carlo Caione
