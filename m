From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-of-arasan: fix set_clock when a phy is supported
Date: Wed, 4 May 2016 13:14:31 +0200
Message-ID: <CAPDyKFrhxW2TeyuTuf5zRdUZAs=8-uCoG4M6_VLdy9XAbtf8vA@mail.gmail.com>
References: <1461832731-28422-1-git-send-email-shawn.lin@rock-chips.com>
	<CAPDyKFp8GmNjU_G9p5u3KFPB8h-BcqL9s6FUAUnAABt8g4Bw0w@mail.gmail.com>
	<1d3a9de8-9092-add5-078e-66ce4ce5f6f3@rock-chips.com>
	<1879484.KeYGv3HTkz@phil>
	<f4445717-c096-7f69-5ff2-879ed8b6af67@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36272 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757782AbcEDLOd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2016 07:14:33 -0400
Received: by mail-wm0-f51.google.com with SMTP id n129so183870485wmn.1
        for <linux-mmc@vger.kernel.org>; Wed, 04 May 2016 04:14:32 -0700 (PDT)
In-Reply-To: <f4445717-c096-7f69-5ff2-879ed8b6af67@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>

On 4 May 2016 at 11:24, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> =E5=9C=A8 2016/5/4 16:35, Heiko Stuebner =E5=86=99=E9=81=93:
>>
>> Am Mittwoch, 4. Mai 2016, 09:48:55 schrieb Shawn Lin:
>>>
>>> =E5=9C=A8 2016/4/28 18:38, Ulf Hansson =E5=86=99=E9=81=93:
>>>>
>>>> On 28 April 2016 at 10:38, Shawn Lin <shawn.lin@rock-chips.com> wr=
ote:
>>>>>
>>>>> commit 61b914eb81f8 ("mmc: sdhci-of-arasan: add phy support for
>>>>> sdhci-of-arasan") introduce phy support for arasan. According to
>>>>> the vendor's databook, we should make sure the phy is in poweroff
>>>>> status before we configure the clk stuff. Otherwise it may cause
>>>>> some IO sample timing issues from the test. And we don't need thi=
s
>>>>> extra operation while running in low performance mode since phy
>>>>> doesn't trigger sampling block.
>>>>>
>>>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>>
>>>>
>>>> Thanks, applied for next!
>>>
>>>
>>> Thanks for applying v2 but, could you please drop it and applied v3
>>> I just send :) .
>>> Because v2 introduces a bug. Set_clock callback will be
>>> called under the protection of spinlock in sdhci_do_set_ios. Howeve=
r
>>> PHY APIs need mutex which fails the kernel's debug check
>>>
>>> BUG: sleeping function called from invalid context at
>>> kernel/locking/mutex.c
>>
>>
>> I think in general you will need to provide a follow-up patch instea=
d of
>> replacing the old version, as Ulf might not want to restructure an a=
lready
>> published branch (depends on the maintainer), especially as already =
other
>> stuff is on top of your patch [0].
>>
>
> Aha.. yes I see other patches on top of mine now. Thanks for remindin=
g
> it.
>
> Ulf, would you mind that I send a new patch to fix it, or you are pro=
ne
> to restructure the next?

I re-base my next branch occasionally, as I prefer it to be as clean
as possible without obvious bisect issues.

In this case there were no conflict by just removing the patch, so I
did that, thanks!

Kind regards
Uffe
