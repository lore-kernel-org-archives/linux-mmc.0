From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mmc: rtsx: Revert "mmc: rtsx: add support for pre_req
 and post_req"
Date: Mon, 28 Apr 2014 11:53:50 +0100
Message-ID: <20140428105350.GM21279@lee--X1>
References: <1398670584-26687-1-git-send-email-micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63319 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753989AbaD1Kx4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Apr 2014 06:53:56 -0400
Received: by mail-wg0-f44.google.com with SMTP id m15so6089737wgh.15
        for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2014 03:53:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398670584-26687-1-git-send-email-micky_ching@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: micky_ching@realsil.com.cn
Cc: chris@printf.net, ulf.hansson@linaro.org, sameo@linux.intel.com, gregkh@linuxfoundation.org, dan.carpenter@oracle.com, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, rogerable@realtek.com, wei_wang@realsil.com.cn

> From: Micky Ching <micky_ching@realsil.com.cn>
>=20
> This reverts commit c42deffd5b53c9e583d83c7964854ede2f12410d.

Why was this patch even merged without an MFD Ack?

> commit <mmc: rtsx: add support for pre_req and post_req> did use
> mutex_unlock() in tasklet, but mutex_unlock() can't used in
> tasklet(atomic context). The driver need use mutex to avoid concurren=
cy,
> so we can't use tasklet here, the patch need to be removed.
>=20
> The spinlock host->lock and pcr->lock may deadlock, one way to solve =
the
> deadlock is remove host->lock in sd_isr_done_transfer(), but if using
> workqueue the we can avoid using the spinlock and also avoid the prob=
lem.
>=20
> Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
> ---
>  drivers/mfd/rtsx_pcr.c            |  132 ++++--------
>  drivers/mmc/host/rtsx_pci_sdmmc.c |  418 ++++++---------------------=
----------
>  include/linux/mfd/rtsx_common.h   |    1 -
>  include/linux/mfd/rtsx_pci.h      |    6 -
>  4 files changed, 109 insertions(+), 448 deletions(-)

This patch should be sent to the -rcs as soon as possible:

Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
