From: Bough Chen <haibo.chen@nxp.com>
Subject: RE: [PATCH V5 00/13] mmc: Add Command Queue support
Date: Fri, 11 Aug 2017 10:33:52 +0000
Message-ID: <AM4PR0401MB2324BBE53EFCDCC73B7D7BA090890@AM4PR0401MB2324.eurprd04.prod.outlook.com>
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve1eur01on0045.outbound.protection.outlook.com ([104.47.1.45]:49600
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751545AbdHKKdz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 11 Aug 2017 06:33:55 -0400
In-Reply-To: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Adrian Hunter
> Sent: Thursday, August 10, 2017 8:08 PM
> To: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc <linux-mmc@vger.kernel.org>; Bough Chen
> <haibo.chen@nxp.com>; Alex Lemberg <alex.lemberg@sandisk.com>;
> Mateusz Nowak <mateusz.nowak@intel.com>; Yuliy Izrailov
> <Yuliy.Izrailov@sandisk.com>; Jaehoon Chung <jh80.chung@samsung.com>;
> Dong Aisheng <dongas86@gmail.com>; Das Asutosh
> <asutoshd@codeaurora.org>; Zhangfei Gao <zhangfei.gao@gmail.com>;
> Sahitya Tummala <stummala@codeaurora.org>; Harjani Ritesh
> <riteshh@codeaurora.org>; Venu Byravarasu <vbyravarasu@nvidia.com>;
> Linus Walleij <linus.walleij@linaro.org>; Shawn Lin <shawn.lin@rock-chips=
.com>
> Subject: [PATCH V5 00/13] mmc: Add Command Queue support
>=20
> Hi
>=20
> Here is V5 of the hardware command queue patches without the software
> command queue patches.
>=20
> HW CMDQ offers 25% - 50% better random multi-threaded I/O.  I see a sligh=
t 2%
> drop in sequential read speed but no change to sequential write.
>=20
>=20

Hi Adrian,

My work is based on 4.9 branch, I back port most mmc related patches, but n=
ot back port that much block layer related patches, so when I apply your V5=
 patches, I remove some code, such as "BLK_STS_IOERR" and "REQ_OP_DRV_IN" "=
REQ_OP_DRV_OUT", change to the old usage. No other change for your V5 patch=
es.

This V5 patches indeed fix the 32bit DMA issue, now my i.MX8 CMDQ can pass =
all the stress test.
=20
So I would like to add:
=20
Tested-by: Haibo Chen <haibo.chen@nxp.com>;

Best Regards
Haibo chen

> Changes since V4:
>       mmc: core: Add mmc_retune_hold_now()
> 	Add explanation to commit message.
>       mmc: host: Add CQE interface
> 	Add comments to callback declarations.
>       mmc: core: Turn off CQE before sending commands
> 	Add explanation to commit message.
>       mmc: core: Add support for handling CQE requests
> 	Add comments as requested by Ulf.
>       mmc: core: Remove unused MMC_CAP2_PACKED_CMD
> 	New patch.
>       mmc: mmc: Enable Command Queuing
> 	Adjust for removal of MMC_CAP2_PACKED_CMD.
> 	Add a comment about Packed Commands.
>       mmc: mmc: Enable CQE's
> 	Remove un-necessary check for MMC_CAP2_CQE
>       mmc: block: Use local variables in mmc_blk_data_prep()
> 	New patch.
>       mmc: block: Prepare CQE data
> 	Adjust due to "mmc: block: Use local variables in
> mmc_blk_data_prep()"
> 	Remove priority setting.
> 	Add explanation to commit message.
>       mmc: cqhci: support for command queue enabled host
> 	Fix transfer descriptor setting in cqhci_set_tran_desc() for 32-bit DMA
>=20
> Changes since V3:
> 	Adjusted ...blk_end_request...() for new block status codes
> 	Fixed CQHCI transaction descriptor for "no DCMD" case
>=20
> Changes since V2:
> 	Dropped patches that have been applied.
> 	Re-based
> 	Added "mmc: sdhci-pci: Add CQHCI support for Intel GLK"
>=20
> Changes since V1:
>=20
> 	"Share mmc request array between partitions" is dependent
> 	on changes in "Introduce queue semantics", so added that
> 	and block fixes:
>=20
> 	Added "Fix is_waiting_last_req set incorrectly"
> 	Added "Fix cmd error reset failure path"
> 	Added "Use local var for mqrq_cur"
> 	Added "Introduce queue semantics"
>=20
> Changes since RFC:
>=20
> 	Re-based on next.
> 	Added comment about command queue priority.
> 	Added some acks and reviews.
>=20
>=20
> Adrian Hunter (12):
>       mmc: core: Add mmc_retune_hold_now()
>       mmc: core: Add members to mmc_request and mmc_data for CQE's
>       mmc: host: Add CQE interface
>       mmc: core: Turn off CQE before sending commands
>       mmc: core: Add support for handling CQE requests
>       mmc: core: Remove unused MMC_CAP2_PACKED_CMD
>       mmc: mmc: Enable Command Queuing
>       mmc: mmc: Enable CQE's
>       mmc: block: Use local variables in mmc_blk_data_prep()
>       mmc: block: Prepare CQE data
>       mmc: block: Add CQE support
>       mmc: sdhci-pci: Add CQHCI support for Intel GLK
>=20
> Venkat Gopalakrishnan (1):
>       mmc: cqhci: support for command queue enabled host
>=20
>  drivers/mmc/core/block.c          |  238 +++++++-
>  drivers/mmc/core/block.h          |    7 +
>  drivers/mmc/core/bus.c            |    7 +
>  drivers/mmc/core/core.c           |  178 +++++-
>  drivers/mmc/core/host.c           |    6 +
>  drivers/mmc/core/host.h           |    1 +
>  drivers/mmc/core/mmc.c            |   42 +-
>  drivers/mmc/core/queue.c          |  273 ++++++++-
>  drivers/mmc/core/queue.h          |   42 +-
>  drivers/mmc/host/Kconfig          |   14 +
>  drivers/mmc/host/Makefile         |    1 +
>  drivers/mmc/host/cqhci.c          | 1154
> +++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/cqhci.h          |  240 ++++++++
>  drivers/mmc/host/sdhci-pci-core.c |  153 ++++-
>  include/linux/mmc/core.h          |   18 +-
>  include/linux/mmc/host.h          |   63 +-
>  include/trace/events/mmc.h        |   36 +-
>  17 files changed, 2412 insertions(+), 61 deletions(-)  create mode 10064=
4
> drivers/mmc/host/cqhci.c  create mode 100644 drivers/mmc/host/cqhci.h
>=20
>=20
> Regards
> Adrian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in t=
he
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
