From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [GIT PULL] Update dw-mmc controller - regression!?
Date: Tue, 12 Jul 2016 18:39:05 +0900
Message-ID: <5784BAB9.4020202@samsung.com>
References: <CAPDyKFrvoVFoTAudJjvmAoE2M8bmgaPpoYyE0FG5Z2W7MSQXAg@mail.gmail.com>
 <CGME20160712085618epcas1p2bf74985623b363d6ffe109f178d8d9c4@epcas1p2.samsung.com>
 <262302f4-e463-239f-e97b-78dcf5c61c39@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:57298 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235AbcGLJjH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2016 05:39:07 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0OA701IZE455XR90@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 12 Jul 2016 18:39:05 +0900 (KST)
In-reply-to: <262302f4-e463-239f-e97b-78dcf5c61c39@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jerome Forissier <jerome.forissier@linaro.org>, "sw0312.kim@samsung.com" <sw0312.kim@samsung.com>, Doug Anderson <dianders@chromium.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Jae hoon Chung <jh80.chung@gmail.com>

On 07/12/2016 05:55 PM, Shawn Lin wrote:
> =E5=9C=A8 2016/7/12 16:28, Ulf Hansson =E5=86=99=E9=81=93:
>> On 6 July 2016 at 18:19, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> On 29 June 2016 at 03:42, Jaehoon Chung <jh80.chung@samsung.com> wr=
ote:
>>>> Dear Ulf,
>>>>
>>>> Could you pull these patches into your repository (next branch)?
>>>>
>>>> Best Regards,
>>>> Jaehoon Chung
>>>>
>>>> The following changes since commit 466780648db4aed7722de91e9d9749c=
6c5969327:
>>>>
>>>>   mmc: sh_mmcif: Use a 10s timeout in the error recovery path (201=
6-06-27 11:19:29 +0200)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>   https://github.com/jh80chung/dw-mmc.git for-ulf
>>>>
>>>> for you to fetch changes up to 545585efee538cac5202b415a3d0c12b455=
6e96f:
>>>>
>>>>   mmc: dw_mmc: fix unmap sg twice when finding data err (2016-06-2=
9 10:39:05 +0900)
>>>>
>>>> ----------------------------------------------------------------
>>>> Ben Dooks (1):
>>>>       mmc: dw_mmc: fix 32bit little-endian access of des1 field
>>>>
>>>> Doug Anderson (2):
>>>>       mmc: dw_mmc: Consider HLE errors to be data and command erro=
rs
>>>>       mmc: dw_mmc: Wait for data transfer after response errors.
>>>>
>>>> Jaehoon Chung (4):
>>>>       mmc: dw_mmc: exynos: fix the NULL pointer dereference error
>>>>       mmc: dw_mmc: remove the quirks flags
>>>>       mmc: dw_mmc: add the card write threshold for HS400 mode
>>>>       mmc: dw_mmc: prevent to set the wrong value
>>>>
>>>> J=C3=A9r=C3=B4me Forissier (1):
>>>>       mmc: dw_mmc: k3: add MMC_CAP_CMD23
>>>>
>>>> Seung-Woo Kim (1):
>>>>       mmc: dw_mmc: remove UBSAN warning in dw_mci_setup_bus()
>>>>
>>>> Shawn Lin (3):
>>>>       mmc: dw_mmc: remove redundant of set_bit and clear_bit
>>>>       mmc: dw_mmc: check card present before starting request
>>>>       mmc: dw_mmc: fix unmap sg twice when finding data err
>>>>
>>>>  drivers/mmc/host/dw_mmc-exynos.c   |   2 +-
>>>>  drivers/mmc/host/dw_mmc-k3.c       |   7 ++
>>>>  drivers/mmc/host/dw_mmc-rockchip.c |   3 -
>>>>  drivers/mmc/host/dw_mmc.c          | 157 ++++++++++++++++++++++--=
-------------
>>>>  drivers/mmc/host/dw_mmc.h          |  10 +--
>>>>  include/linux/mmc/dw_mmc.h         |   9 ---
>>>>  6 files changed, 108 insertions(+), 80 deletions(-)
>>>
>>> Thanks Jaehoon, pulled into my next branch!
>>
>>
>> Reported by kernelci, It seems like some of these patches are causin=
g
>> the exynos5250-arndale to fail to boot.
>> I looked briefly at the logs and the bisect report (which isn't
>> complete) and it turns out that the eMMC card at mmc0 isn't detected
>> properly.
>>
>> Here's the boot summary (it turns out there are more boards failing,
>> don't know if all are related to dw_mmc, yet):
>> https://kernelci.org/boot/all/job/ulfh/kernel/v4.7-rc5-92-g4e01b578a=
de9/
>=20
> I quickly look at the failed bootlogs of your reports.
> My three patches don't touch the behaviour for which I search dw_mmc
> code to find whether it will generate some possible to make mmc-core
> got -EINVAL. It's a little difficult for me to point out the root cau=
se
> without more debug log or geting the real failed board.
>=20
>=20
> It will be great if Jaehoon have a exynos5250-* board to debug?
> Or Ulf, could you revert the commit 97f659a2e (mmc: dw_mmc: prevent t=
o set the wrong value) to see if we could boot up exynos5250-arndale
> successfully?

Right, when i have debugged, this commit 97f659a2e (mmc: dw_mmc: preven=
t to set the wrong value) is problem.
If Ulf can revert it, otherwise i needs to modify the dts file of arnda=
le baord.

In future, I will fix more exactly. Sorry for this.

When i have checked,

Before reverting,
[    2.757696] mmc_host mmc0: vqmmc not available.(Skip the switching v=
oltage)
[    2.757713] mmc0: error -22 whilst initialising MMC card

After reverted,
[    2.480755] mmc0: new DDR MMC card at address 0001
[    2.481723] mmcblk0: mmc0:0001 SDW16G 14.7 GiB
[    2.482218] mmcblk0boot0: mmc0:0001 SDW16G partition 1 4.00 MiB
[    2.482681] mmcblk0boot1: mmc0:0001 SDW16G partition 2 4.00 MiB
[    2.483345] mmcblk0rpmb: mmc0:0001 SDW16G partition 3 4.00 MiB
[    2.486493]  mmcblk0: p1 p2 p3 p4 < p5 p6 >

How about? revert? otherwise I will send to fix the patch.
I will accept Ulf's opinion. Sorry for this, again.

Best Regards,
Jaehoon Chung

>=20
>>
>> Here's the bootlog:
>> https://storage.kernelci.org/ulfh/v4.7-rc5-92-g4e01b578ade9/arm-mult=
i_v7_defconfig+CONFIG_EFI=3Dy/lab-baylibre-seattle/boot-exynos5250-arnd=
ale.txt
>>
>> Please, could any of you dw_mmc experts have a look at this as soon =
as
>> possible!?
>>
>> Kind regards
>> Uffe
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20
>=20

