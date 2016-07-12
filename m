From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] Update dw-mmc controller - regression!?
Date: Tue, 12 Jul 2016 12:13:11 +0200
Message-ID: <CAPDyKFrCuuYZVvpGYUVJ5E9iOFn5e4rDm28sce4bhB+OofSH5A@mail.gmail.com>
References: <CAPDyKFrvoVFoTAudJjvmAoE2M8bmgaPpoYyE0FG5Z2W7MSQXAg@mail.gmail.com>
 <CGME20160712085618epcas1p2bf74985623b363d6ffe109f178d8d9c4@epcas1p2.samsung.com>
 <262302f4-e463-239f-e97b-78dcf5c61c39@rock-chips.com> <5784BAB9.4020202@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35815 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbcGLKNO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2016 06:13:14 -0400
Received: by mail-wm0-f43.google.com with SMTP id f65so94903515wmi.0
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2016 03:13:13 -0700 (PDT)
In-Reply-To: <5784BAB9.4020202@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jerome Forissier <jerome.forissier@linaro.org>, "sw0312.kim@samsung.com" <sw0312.kim@samsung.com>, Doug Anderson <dianders@chromium.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Jae hoon Chung <jh80.chung@gmail.com>

On 12 July 2016 at 11:39, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 07/12/2016 05:55 PM, Shawn Lin wrote:
>> =E5=9C=A8 2016/7/12 16:28, Ulf Hansson =E5=86=99=E9=81=93:
>>> On 6 July 2016 at 18:19, Ulf Hansson <ulf.hansson@linaro.org> wrote=
:
>>>> On 29 June 2016 at 03:42, Jaehoon Chung <jh80.chung@samsung.com> w=
rote:
>>>>> Dear Ulf,
>>>>>
>>>>> Could you pull these patches into your repository (next branch)?
>>>>>
>>>>> Best Regards,
>>>>> Jaehoon Chung
>>>>>
>>>>> The following changes since commit 466780648db4aed7722de91e9d9749=
c6c5969327:
>>>>>
>>>>>   mmc: sh_mmcif: Use a 10s timeout in the error recovery path (20=
16-06-27 11:19:29 +0200)
>>>>>
>>>>> are available in the git repository at:
>>>>>
>>>>>   https://github.com/jh80chung/dw-mmc.git for-ulf
>>>>>
>>>>> for you to fetch changes up to 545585efee538cac5202b415a3d0c12b45=
56e96f:
>>>>>
>>>>>   mmc: dw_mmc: fix unmap sg twice when finding data err (2016-06-=
29 10:39:05 +0900)
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> Ben Dooks (1):
>>>>>       mmc: dw_mmc: fix 32bit little-endian access of des1 field
>>>>>
>>>>> Doug Anderson (2):
>>>>>       mmc: dw_mmc: Consider HLE errors to be data and command err=
ors
>>>>>       mmc: dw_mmc: Wait for data transfer after response errors.
>>>>>
>>>>> Jaehoon Chung (4):
>>>>>       mmc: dw_mmc: exynos: fix the NULL pointer dereference error
>>>>>       mmc: dw_mmc: remove the quirks flags
>>>>>       mmc: dw_mmc: add the card write threshold for HS400 mode
>>>>>       mmc: dw_mmc: prevent to set the wrong value
>>>>>
>>>>> J=C3=A9r=C3=B4me Forissier (1):
>>>>>       mmc: dw_mmc: k3: add MMC_CAP_CMD23
>>>>>
>>>>> Seung-Woo Kim (1):
>>>>>       mmc: dw_mmc: remove UBSAN warning in dw_mci_setup_bus()
>>>>>
>>>>> Shawn Lin (3):
>>>>>       mmc: dw_mmc: remove redundant of set_bit and clear_bit
>>>>>       mmc: dw_mmc: check card present before starting request
>>>>>       mmc: dw_mmc: fix unmap sg twice when finding data err
>>>>>
>>>>>  drivers/mmc/host/dw_mmc-exynos.c   |   2 +-
>>>>>  drivers/mmc/host/dw_mmc-k3.c       |   7 ++
>>>>>  drivers/mmc/host/dw_mmc-rockchip.c |   3 -
>>>>>  drivers/mmc/host/dw_mmc.c          | 157 ++++++++++++++++++++++-=
--------------
>>>>>  drivers/mmc/host/dw_mmc.h          |  10 +--
>>>>>  include/linux/mmc/dw_mmc.h         |   9 ---
>>>>>  6 files changed, 108 insertions(+), 80 deletions(-)
>>>>
>>>> Thanks Jaehoon, pulled into my next branch!
>>>
>>>
>>> Reported by kernelci, It seems like some of these patches are causi=
ng
>>> the exynos5250-arndale to fail to boot.
>>> I looked briefly at the logs and the bisect report (which isn't
>>> complete) and it turns out that the eMMC card at mmc0 isn't detecte=
d
>>> properly.
>>>
>>> Here's the boot summary (it turns out there are more boards failing=
,
>>> don't know if all are related to dw_mmc, yet):
>>> https://kernelci.org/boot/all/job/ulfh/kernel/v4.7-rc5-92-g4e01b578=
ade9/
>>
>> I quickly look at the failed bootlogs of your reports.
>> My three patches don't touch the behaviour for which I search dw_mmc
>> code to find whether it will generate some possible to make mmc-core
>> got -EINVAL. It's a little difficult for me to point out the root ca=
use
>> without more debug log or geting the real failed board.
>>
>>
>> It will be great if Jaehoon have a exynos5250-* board to debug?
>> Or Ulf, could you revert the commit 97f659a2e (mmc: dw_mmc: prevent =
to set the wrong value) to see if we could boot up exynos5250-arndale
>> successfully?
>
> Right, when i have debugged, this commit 97f659a2e (mmc: dw_mmc: prev=
ent to set the wrong value) is problem.
> If Ulf can revert it, otherwise i needs to modify the dts file of arn=
dale baord.
>
> In future, I will fix more exactly. Sorry for this.

No worries, these things happens and is the reason to why kernelci and
other automated build/boot tools exists! :-)

>
> When i have checked,
>
> Before reverting,
> [    2.757696] mmc_host mmc0: vqmmc not available.(Skip the switching=
 voltage)
> [    2.757713] mmc0: error -22 whilst initialising MMC card
>
> After reverted,
> [    2.480755] mmc0: new DDR MMC card at address 0001
> [    2.481723] mmcblk0: mmc0:0001 SDW16G 14.7 GiB
> [    2.482218] mmcblk0boot0: mmc0:0001 SDW16G partition 1 4.00 MiB
> [    2.482681] mmcblk0boot1: mmc0:0001 SDW16G partition 2 4.00 MiB
> [    2.483345] mmcblk0rpmb: mmc0:0001 SDW16G partition 3 4.00 MiB
> [    2.486493]  mmcblk0: p1 p2 p3 p4 < p5 p6 >
>
> How about? revert? otherwise I will send to fix the patch.
> I will accept Ulf's opinion. Sorry for this, again.

No revert needed, I have just dropped (through a re-base) from my next =
branch.

The changes are published now, so let's give kernelci some time to run
a new build/boot test!

To all involved, I appreciate your quick responsiveness in solving this=
 issue!

Kind regards
Uffe

>
> Best Regards,
> Jaehoon Chung
>
>>
>>>
>>> Here's the bootlog:
>>> https://storage.kernelci.org/ulfh/v4.7-rc5-92-g4e01b578ade9/arm-mul=
ti_v7_defconfig+CONFIG_EFI=3Dy/lab-baylibre-seattle/boot-exynos5250-arn=
dale.txt
>>>
>>> Please, could any of you dw_mmc experts have a look at this as soon=
 as
>>> possible!?
>>>
>>> Kind regards
>>> Uffe
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
>
