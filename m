From: Per Forlin <per.lkml@gmail.com>
Subject: Re: [PATCH v2 1/4]enable background operations for supported eMMC card
Date: Mon, 2 May 2011 21:53:31 +0200
Message-ID: <BANLkTimiDjrRy_3seDLBYah8MnJMWxNZ-w@mail.gmail.com>
References: <20101203121338.GB18655@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33293 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233Ab1EBTxd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 May 2011 15:53:33 -0400
In-Reply-To: <20101203121338.GB18655@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, cjb@laptop.org, akpm@linux-foundation.org, arjan@linux.intel.com, alan@linux.intel.com, kmpark@infradead.org

On Fri, Dec 3, 2010 at 1:13 PM, Chuanxiao Dong <chuanxiao.dong@intel.co=
m> wrote:
> From 984adc755cf2f7966a89e510a50f085e314fe347 Mon Sep 17 00:00:00 200=
1
> From: Chuanxiao Dong <chuanxiao.dong@intel.com>
> Date: Mon, 22 Nov 2010 16:31:12 +0800
> Subject: [PATCH 1/4] mmc: Enabled background operations feature if eM=
MC card supports
>
> Background operations is a new feature defined in eMMC4.41 standard.
> Since this feature is opertional for eMMC card, so driver only enable
> for those eMMC card which supports this feature
>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> ---
> =A0drivers/mmc/core/mmc.c =A0 | =A0 26 ++++++++++++++++++++++++++
> =A0include/linux/mmc/card.h | =A0 =A02 ++
> =A0include/linux/mmc/mmc.h =A0| =A0 =A03 +++
> =A03 files changed, 31 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 77f93c3..471ed82 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -310,6 +310,14 @@ static int mmc_read_ext_csd(struct mmc_card *car=
d)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd[EXT_CSD_SEC_FE=
ATURE_SUPPORT];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.trim_timeout =3D 300 *
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd[EXT_CSD_TRIM_M=
ULT];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* detect whether the eMMC card support=
 BKOPS */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x=
1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.bkops =3D=
 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.bkops_en =
=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd=
[EXT_CSD_BKOPS_EN];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (ext_csd[EXT_CSD_ERASED_MEM_CONT])
> @@ -484,6 +492,24 @@ static int mmc_init_card(struct mmc_host *host, =
u32 ocr,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/*
> + =A0 =A0 =A0 =A0* enable BKOPS if eMMC card supports.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (card->ext_csd.bkops) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!card->ext_csd.bkops_en) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card=
, EXT_CSD_CMD_SET_NORMAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_BKOPS_EN, 1);
Is it always wise to set BKOPS_EN to 1 if bkops is supported?
BKOPS_EN=3D1 will enable periodic background operations. The card will
somehow decide periodically when to start background operations. If
BKOPS_EN=3D0 the background operations need to be started manually. The
mmc framework could make the decision when to start background
operations.
Using dynamic clock control or suspend/resume may cause the periodic
internal operations to be delayed since it can't run without clocking
or power.
Do you have any test results comparing periodic and manual bkops?
On way forward is to add support for both periodic bkops and manual
bkops and let the device platform_data specify what to use?

Regards,
Per
