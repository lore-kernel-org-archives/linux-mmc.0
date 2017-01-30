From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/6] mmc: core: Enable mmc hosts to specify support for
 eMMC DDR 3.3V
Date: Mon, 30 Jan 2017 11:05:46 +0100
Message-ID: <CAPDyKFpXRf1uGwDDb32iCLC7-R=wtsbp0PGuRjfJvSHS1ya+5g@mail.gmail.com>
References: <1485357143-23280-1-git-send-email-ulf.hansson@linaro.org> <452fe897-6747-b929-f868-ef08c038b83c@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37478 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdA3KPC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2017 05:15:02 -0500
Received: by mail-wm0-f50.google.com with SMTP id v77so40456827wmv.0
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2017 02:15:01 -0800 (PST)
In-Reply-To: <452fe897-6747-b929-f868-ef08c038b83c@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Fabio Estevam <festevam@gmail.com>, Jan Glauber <jan.glauber@caviumnetworks.com>

On 30 January 2017 at 10:13, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Am 25.01.2017 um 16:12 schrieb Ulf Hansson:
>> It's been reported that some mmc hosts don't support a VCCQ (signal voltage) of
>> 1.8V for eMMC DDR mode, but instead only 3.3V. According to the JEDEC spec, an
>> eMMC card must support both if any, which makes the mmc host being the
>> potential limitation. Therefore, let's invent a new mmc cap, MMC_CAP_3_3V_DDR,
>> and a new corresponding DT binding, which tells whether 3.3V is supported for
>> the VCCQ.
>>
>> In the context of these changes, I took the opportunity to make some clean-ups
>> of some related code.
>
> I know this series has already been merged, but i want to mention that
> it works fine with mxs-mmc on a i.MX28.

Thanks! I have added your tested by tag.

Kind regards
Uffe
