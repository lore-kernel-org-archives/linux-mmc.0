From: Krishna Konda <kkonda@codeaurora.org>
Subject: Re: Fwd: [PATCH v3 0/5] mmc: Add access to RPMB partition
Date: Wed, 14 Nov 2012 13:14:08 -0800
Message-ID: <1352927648.5856.14.camel@kkonda-linux.qualcomm.com>
References: <1344265951-22437-1-git-send-email-loic.pallardy-ext@stericsson.com>
	 <CAJOk3oGMtZvrkw9ic306BKNSKCAzPQCYmJrvq5=zDi1pHjjQxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:36920 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423482Ab2KNVOQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Nov 2012 16:14:16 -0500
In-Reply-To: <CAJOk3oGMtZvrkw9ic306BKNSKCAzPQCYmJrvq5=zDi1pHjjQxg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: loic.pallardy-ext@stericsson.com, cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: linus.walleij@linaro.org, STEricsson_nomadik_linux@list.st.com, ulf.hansson@stericcson.com

On Wed, 2012-11-14 at 12:58 -0800, Krishna Konda wrote:

> From: Loic Pallardy <loic.pallardy-ext@stericsson.com>
> Date: Mon, Aug 6, 2012 at 8:12 AM
> Subject: [PATCH v3 0/5] mmc: Add access to RPMB partition
> To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>, STEricsson_nomadik_linux
> <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson
> <ulf.hansson@stericcson.com>, Loic Pallardy
> <loic.pallardy-ext@stericsson.com>
> 
> 
> The goal of this patchserie is to offer access to MMC RPMB
> (Replay Protected Memory Block) partition.
> The RPMB partition is used in general to store some secure data.
> It is accessible through a trusted mechanism described in
> JEDEC standard JESD84-A441.
> 
> This patchserie proposes following modifications:
> - detect RPMB capability and create RPMB block device if supported
> - extend MMC sysfs to provide access to RPMB partition size and
>   reliable write sector count (information needed by user space to
>   acces RPMB partition)
> - update IOCTL to support RPMB access. This includes automatic
> partition
>   switch and sending of Set Block Count (CMD23) message.
> 
> RPMB partition becomes accessible using standard IOCTL interface.
> Patches don't include trusted mechanism or any verification.
> It is user space or secure application responsability to provide the
> right
> command and the entire data frame as defined by JEDEC standard.
> ---
> Changes in v2:
> - Correction in patch 2: mmc: card: Do not scan RPMB partitions
>   Remove GENHD_FL_EXT_DEVT flag
> 
> Changes in v3:
> - Add acked-by and reviewed-by tags
> ---
> Loic Pallardy (5):
>   mmc: core: Expose access to RPMB partition
>   mmc: card: Do not scan RPMB partitions
>   mmc: core: Extend sysfs to ext_csd parameters for RPMB support
>   mmc: core: Add mmc_set_blockcount feature
>   mmc: card: Add RPMB support in IOCTL interface
> 
>  Documentation/mmc/mmc-dev-attrs.txt |  7 ++++
>  drivers/mmc/card/block.c            | 66
> +++++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/core.c             | 14 ++++++++
>  drivers/mmc/core/mmc.c              | 15 +++++++++
>  include/linux/mmc/card.h            |  2 ++
>  include/linux/mmc/core.h            |  2 ++
>  include/linux/mmc/mmc.h             |  2 ++
>  7 files changed, 108 insertions(+)
> 

Hi Loic, Chris, are there any plans to merge these patchsets? I did not
see this in mmc-next.


Thanks,
Krishna Konda
--
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
hosted by The Linux Foundation



