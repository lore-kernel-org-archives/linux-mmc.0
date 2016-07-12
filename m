From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [GIT PULL] Update dw-mmc controller - regression!?
Date: Tue, 12 Jul 2016 16:55:53 +0800
Message-ID: <262302f4-e463-239f-e97b-78dcf5c61c39@rock-chips.com>
References: <CAPDyKFrvoVFoTAudJjvmAoE2M8bmgaPpoYyE0FG5Z2W7MSQXAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:57384 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbcGLI4K (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2016 04:56:10 -0400
In-Reply-To: <CAPDyKFrvoVFoTAudJjvmAoE2M8bmgaPpoYyE0FG5Z2W7MSQXAg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: shawn.lin@rock-chips.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jerome Forissier <jerome.forissier@linaro.org>, "sw0312.kim@samsung.com" <sw0312.kim@samsung.com>, Doug Anderson <dianders@chromium.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Jae hoon Chung <jh80.chung@gmail.com>

=E5=9C=A8 2016/7/12 16:28, Ulf Hansson =E5=86=99=E9=81=93:
> On 6 July 2016 at 18:19, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 29 June 2016 at 03:42, Jaehoon Chung <jh80.chung@samsung.com> wro=
te:
>>> Dear Ulf,
>>>
>>> Could you pull these patches into your repository (next branch)?
>>>
>>> Best Regards,
>>> Jaehoon Chung
>>>
>>> The following changes since commit 466780648db4aed7722de91e9d9749c6=
c5969327:
>>>
>>>   mmc: sh_mmcif: Use a 10s timeout in the error recovery path (2016=
-06-27 11:19:29 +0200)
>>>
>>> are available in the git repository at:
>>>
>>>   https://github.com/jh80chung/dw-mmc.git for-ulf
>>>
>>> for you to fetch changes up to 545585efee538cac5202b415a3d0c12b4556=
e96f:
>>>
>>>   mmc: dw_mmc: fix unmap sg twice when finding data err (2016-06-29=
 10:39:05 +0900)
>>>
>>> ----------------------------------------------------------------
>>> Ben Dooks (1):
>>>       mmc: dw_mmc: fix 32bit little-endian access of des1 field
>>>
>>> Doug Anderson (2):
>>>       mmc: dw_mmc: Consider HLE errors to be data and command error=
s
>>>       mmc: dw_mmc: Wait for data transfer after response errors.
>>>
>>> Jaehoon Chung (4):
>>>       mmc: dw_mmc: exynos: fix the NULL pointer dereference error
>>>       mmc: dw_mmc: remove the quirks flags
>>>       mmc: dw_mmc: add the card write threshold for HS400 mode
>>>       mmc: dw_mmc: prevent to set the wrong value
>>>
>>> J=C3=A9r=C3=B4me Forissier (1):
>>>       mmc: dw_mmc: k3: add MMC_CAP_CMD23
>>>
>>> Seung-Woo Kim (1):
>>>       mmc: dw_mmc: remove UBSAN warning in dw_mci_setup_bus()
>>>
>>> Shawn Lin (3):
>>>       mmc: dw_mmc: remove redundant of set_bit and clear_bit
>>>       mmc: dw_mmc: check card present before starting request
>>>       mmc: dw_mmc: fix unmap sg twice when finding data err
>>>
>>>  drivers/mmc/host/dw_mmc-exynos.c   |   2 +-
>>>  drivers/mmc/host/dw_mmc-k3.c       |   7 ++
>>>  drivers/mmc/host/dw_mmc-rockchip.c |   3 -
>>>  drivers/mmc/host/dw_mmc.c          | 157 ++++++++++++++++++++++---=
------------
>>>  drivers/mmc/host/dw_mmc.h          |  10 +--
>>>  include/linux/mmc/dw_mmc.h         |   9 ---
>>>  6 files changed, 108 insertions(+), 80 deletions(-)
>>
>> Thanks Jaehoon, pulled into my next branch!
>
>
> Reported by kernelci, It seems like some of these patches are causing
> the exynos5250-arndale to fail to boot.
> I looked briefly at the logs and the bisect report (which isn't
> complete) and it turns out that the eMMC card at mmc0 isn't detected
> properly.
>
> Here's the boot summary (it turns out there are more boards failing,
> don't know if all are related to dw_mmc, yet):
> https://kernelci.org/boot/all/job/ulfh/kernel/v4.7-rc5-92-g4e01b578ad=
e9/

I quickly look at the failed bootlogs of your reports.
My three patches don't touch the behaviour for which I search dw_mmc
code to find whether it will generate some possible to make mmc-core
got -EINVAL. It's a little difficult for me to point out the root cause
without more debug log or geting the real failed board.


It will be great if Jaehoon have a exynos5250-* board to debug?
Or Ulf, could you revert the commit 97f659a2e (mmc: dw_mmc: prevent to=20
set the wrong value) to see if we could boot up exynos5250-arndale
successfully?

>
> Here's the bootlog:
> https://storage.kernelci.org/ulfh/v4.7-rc5-92-g4e01b578ade9/arm-multi=
_v7_defconfig+CONFIG_EFI=3Dy/lab-baylibre-seattle/boot-exynos5250-arnda=
le.txt
>
> Please, could any of you dw_mmc experts have a look at this as soon a=
s
> possible!?
>
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--=20
Best Regards
Shawn Lin

