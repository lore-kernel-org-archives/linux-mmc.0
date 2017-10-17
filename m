From: Liming Sun <lsun@mellanox.com>
Subject: RE: [PATCH 0/9] Enable dw-mmc multi-card support
Date: Tue, 17 Oct 2017 15:52:03 +0000
Message-ID: <AM2PR05MB07533A822C7CCBA7111FD58FA14C0@AM2PR05MB0753.eurprd05.prod.outlook.com>
References: <cover.1507315433.git.lsun@mellanox.com>
 <8e433531-8f67-d575-635e-c6ced29f6804@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-eopbgr20065.outbound.protection.outlook.com ([40.107.2.65]:65209
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932946AbdJQPwH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Oct 2017 11:52:07 -0400
In-Reply-To: <8e433531-8f67-d575-635e-c6ced29f6804@rock-chips.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Chris Metcalf <cmetcalf@mellanox.com>

>> Hrm.... it's so unlucky that your patchset comes a little late. As your =
patch 8 and 9 said, you need them to fix problem for multi-card support, so=
 definitely there was no such use case, and even the code was buggy to supp=
ort it right? That makes the code hard to read and maintain, so we decide t=
o remove it.

Thanks for the feedback. Yes, earlier the multi-card support was buggy inde=
ed. We spent some time to debug it and got it working.

>> Havn'e check the databook for details yet, but I think it's ok to re-int=
roduce multi-slot support if a real user benefits from it. But you need a n=
ew patch to silent the log "num-slots property not found, assuming 1 slot i=
s available" as we removed all the num-slots from DT at that time.

The " num-slots property not found..." log message has already been removed=
 by 8a629d26f back in 2016. Looks like we're good on this one. In dw_mci_pr=
obe (), it has code to check pdata->num_slots. If 0, the host->num_slots wi=
ll be set to 1. So the logic of setting default num_slots seems already the=
re. But correct me if I am wrong.

Thanks,
Liming

-----Original Message-----
From: Shawn Lin [mailto:shawn.lin@rock-chips.com]=20
Sent: Monday, October 16, 2017 9:36 PM
To: Liming Sun <lsun@mellanox.com>; Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>; Rob Herring <robh+dt@kernel.org>;=
 Mark Rutland <mark.rutland@arm.com>; Kukjin Kim <kgene@kernel.org>; Krzysz=
tof Kozlowski <krzk@kernel.org>; shawn.lin@rock-chips.com; linux-mmc@vger.k=
ernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-=
arm-kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 0/9] Enable dw-mmc multi-card support


On 2017/10/7 3:21, Liming Sun wrote:
> This series of commits enables the multi-card support for the dw-mmc=20
> controller. It includes two parts as below.
>=20
> The first part (patches 1-7) reverts the series of recent commits that=20
> removed the multi-card support with comments saying there was no such=20
> use case in the real world. Actually this feature is being used in=20
> Mellanox Bluefield SoC and has been requested by customers.

Hrm.... it's so unlucky that your patchset comes a little late. As your pat=
ch 8 and 9 said, you need them to fix problem for multi-card support, so de=
finitely there was no such use case, and even the code was buggy to support=
 it right? That makes the code hard to read and maintain, so we decide to r=
emove it.

>=20
> The second part (patches 8-9) fixes the DesignWare multi-card support=20
> according to the dw-mmc databook (synnopsys: DesignWare Cores Mobile=20
> Storage Host Databook, 2.70a). It has changes to set the card number=20
> into the CMD register to multiplex requests to different cards when=20
> working in SD_MMC_CEATA mode, set the CTYPE / CLKENA / CDTHRCTL=20
> registers properly according to the spec, and parse the per-card=20
> configuration to match the Linux Documentation=20
> (bindings/mmc/synopsys-dw-mshc.txt).

Havn'e check the databook for details yet, but I think it's ok to re-introd=
uce multi-slot support if a real user benefits from it. But you need a new =
patch to silent the log "num-slots property not found, assuming 1 slot is a=
vailable" as we removed all the num-slots from DT at that time.


>=20
> Liming Sun (9):
>    Revert "Documentation: dw-mshc: deprecate num-slots"
>    Revert "mmc: dw_mmc: remove the unnecessary slot variable"
>    Revert "mmc: dw_mmc: use the 'slot' instead of 'cur_slot'"
>    Revert "mmc: dw_mmc: remove the 'id' arguments about functions
>      relevant to slot"
>    Revert "mmc: dw_mmc: change the array of slots"
>    Revert "mmc: dw_mmc: remove the loop about finding slots"
>    Revert "mmc: dw_mmc: deprecated the "num-slots" property"
>    mmc: dw_mmc: Support two SD_MMC_CE-ATA cards
>    mmc: dw_mmc: Parse slot-specific configuration
>=20
>   .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  16 +-
>   drivers/mmc/host/dw_mmc-exynos.c                   |   4 +-
>   drivers/mmc/host/dw_mmc.c                          | 277 ++++++++++++++=
++-----
>   drivers/mmc/host/dw_mmc.h                          |  17 +-
>   4 files changed, 236 insertions(+), 78 deletions(-)
>=20

