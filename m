From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH 0/6] mmc: dw_mmc: misc fixes and improvements
Date: Fri, 24 Jun 2011 15:53:36 +0100
Message-ID: <BANLkTi=0Xg_w54ZaUPeb9e+A-_pcTjTg+w@mail.gmail.com>
References: <4E0488A9.6050109@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58746 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057Ab1FXOxh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jun 2011 10:53:37 -0400
In-Reply-To: <4E0488A9.6050109@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, james@albanarts.com

On Fri, Jun 24, 2011 at 1:52 PM, James Hogan <james.hogan@imgtec.com> w=
rote:
> Misc improvements and fixes for the Synopsys DesignWare MMC driver:
>
> [PATCH 1/6] mmc: dw_mmc: clear TXDR/RXDR ints before enabling
> =A0 =A0 =A0 =A0fixes a failure to probe the next card after an unplug
> [PATCH 2/6] mmc: dw_mmc: fix race with request and removal
> =A0 =A0 =A0 =A0improves spinlock protection
> [PATCH 3/6] mmc: dw_mmc: convert card tasklet to workqueue
> =A0 =A0 =A0 =A0to allow platform callbacks to sleep
> [PATCH 4/6] mmc: dw_mmc: brackets in register access macros
> =A0 =A0 =A0 =A0just a small tidyup patch
> [PATCH 5/6] mmc: dw_mmc: don't hard code fifo depth, fix usage
> =A0 =A0 =A0 =A0improve detection of fifo depth
> [PATCH 6/6] mmc: dw_mmc: handle unaligned buffers and sizes
> =A0 =A0 =A0 =A0fix some mmc_test failures wrt unaligned buffer/sizes
>
> =A0drivers/mmc/host/dw_mmc.c =A0| =A0398 ++++++++++++++++++++++++++++=
++++++----------
> =A0drivers/mmc/host/dw_mmc.h =A0| =A0 17 +-
> =A0include/linux/mmc/dw_mmc.h | =A0 20 ++-
> =A03 files changed, 340 insertions(+), 95 deletions(-)

All these patches:

Acked-by: Will Newton <will.newton@imgtec.com>
