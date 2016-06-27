From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: add auto bkops support
Date: Mon, 27 Jun 2016 11:08:17 +0200
Message-ID: <CAPDyKFoxTH_-U_Aj0jHWPKbwd+4OoOYBTdOeD-6SpG4XyM=3AA@mail.gmail.com>
References: <1465182439-27963-1-git-send-email-shawn.lin@rock-chips.com>
 <F4A75DD4-FE64-4417-AFD4-FA9ABD8EE915@sandisk.com> <d5c75760-e8b4-1784-a7de-3d78eeca1d0e@rock-chips.com>
 <7078F2B9-63B6-4170-BFA1-5AC370F0D4DD@sandisk.com> <29966a6f-eb14-0307-08cc-f91a97f50382@rock-chips.com>
 <B7133967-23A7-46AF-9013-417BD282E005@sandisk.com> <23729258-7a6b-80ac-6c90-b48eed64e0ea@rock-chips.com>
 <576B7211.2030208@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38193 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbcF0JIe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jun 2016 05:08:34 -0400
Received: by mail-wm0-f50.google.com with SMTP id r201so105179778wme.1
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jun 2016 02:08:20 -0700 (PDT)
In-Reply-To: <576B7211.2030208@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Alex Lemberg <Alex.Lemberg@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>

[...]

>>> If I am not wrong, in current implementation of runtime suspend,
>>> the driver stops BKOPS (send HPI) just before sending sleep command=
,
>>> see _mmc_suspend(), depends on =E2=80=9CMMC_CAP_AGGRESSIVE_PM=E2=80=
=9D flag.
>>> In this case, the eMMC device will not have enough time to perform =
internal
>>> BKOPS in both =E2=80=93 Manual and Auto BKOPS configurations.
>>>
>>
>> ye, so it seems a pre-exiting issue before introducing auto bkops?
>> I think we can push another patch to improve it but not handling
>> it for this $SUBJECT, does it sound ok to you?
>
> Runtime suspend for eMMC has a default auto-suspend delay of 3 second=
s
> (refer mmc_blk_probe()).  Isn't that when auto bkops would happen?

That's correct.

So perhaps we should extend the default auto-suspend delay?

The SD case actually have the same issue, as I some background
operations exists there as well.

[...]

Kind regards
Uffe
