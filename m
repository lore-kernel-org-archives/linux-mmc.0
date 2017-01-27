From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/6] mmc: core: Enable mmc hosts to specify support for
 eMMC DDR 3.3V
Date: Fri, 27 Jan 2017 09:57:39 +0100
Message-ID: <CAPDyKFotcwkLFgFbsZO+YE_NdrO=31vQ_eOqAyPfVY23-tmYPg@mail.gmail.com>
References: <1485357143-23280-1-git-send-email-ulf.hansson@linaro.org> <2d3a5129-1514-1969-89df-1972427f7856@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38526 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754474AbdA0I6B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Jan 2017 03:58:01 -0500
Received: by mail-wm0-f46.google.com with SMTP id r144so125644350wme.1
        for <linux-mmc@vger.kernel.org>; Fri, 27 Jan 2017 00:57:40 -0800 (PST)
In-Reply-To: <2d3a5129-1514-1969-89df-1972427f7856@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Stefan Wahren <stefan.wahren@i2se.com>, Fabio Estevam <festevam@gmail.com>, Jan Glauber <jan.glauber@caviumnetworks.com>

On 27 January 2017 at 03:27, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> On 2017/1/25 23:12, Ulf Hansson wrote:
>>
>> It's been reported that some mmc hosts don't support a VCCQ (signal
>> voltage) of
>> 1.8V for eMMC DDR mode, but instead only 3.3V. According to the JEDEC
>> spec, an
>> eMMC card must support both if any, which makes the mmc host being the
>> potential limitation. Therefore, let's invent a new mmc cap,
>> MMC_CAP_3_3V_DDR,
>> and a new corresponding DT binding, which tells whether 3.3V is supported
>> for
>> the VCCQ.
>>
>> In the context of these changes, I took the opportunity to make some
>> clean-ups
>> of some related code.
>>
>
> This patchset looks good. Just a nit, maybe we could take this chance
> to improve the patch 3 as we touch it now:)
>
> s/mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180) == 0/
> !mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180), and so on:)

Good idea! I found three places in mmc_power_up() which I fixed up.

I postpone to send a new version, to wait for further comments. If
none, I will just amend the change in patch3/6.

>
> Anyway,
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks for reviewing!

[...]

Kind regards
Uffe
