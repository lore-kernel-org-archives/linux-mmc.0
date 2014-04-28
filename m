From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mmc: rtsx: Revert "mmc: rtsx: add support for pre_req
 and post_req"
Date: Mon, 28 Apr 2014 13:29:18 +0100
Message-ID: <20140428122918.GG21279@lee--X1>
References: <1398670584-26687-1-git-send-email-micky_ching@realsil.com.cn>
 <20140428105350.GM21279@lee--X1>
 <CAPDyKFr6kNjfE+adx_j05wes0Y1fg=zD-AwciWy0vQdw=DbOrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:55770 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932275AbaD1M3Y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Apr 2014 08:29:24 -0400
Received: by mail-wi0-f172.google.com with SMTP id hi2so5571336wib.17
        for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2014 05:29:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPDyKFr6kNjfE+adx_j05wes0Y1fg=zD-AwciWy0vQdw=DbOrg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: micky <micky_ching@realsil.com.cn>, Chris Ball <chris@printf.net>, Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@oracle.com>, devel@linuxdriverproject.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Roger <rogerable@realtek.com>, Wei WANG <wei_wang@realsil.com.cn>

> >> From: Micky Ching <micky_ching@realsil.com.cn>
> >>
> >> This reverts commit c42deffd5b53c9e583d83c7964854ede2f12410d.
> >
> > Why was this patch even merged without an MFD Ack?
> >
> >> commit <mmc: rtsx: add support for pre_req and post_req> did use
> >> mutex_unlock() in tasklet, but mutex_unlock() can't used in
> >> tasklet(atomic context). The driver need use mutex to avoid concur=
rency,
> >> so we can't use tasklet here, the patch need to be removed.
> >>
> >> The spinlock host->lock and pcr->lock may deadlock, one way to sol=
ve the
> >> deadlock is remove host->lock in sd_isr_done_transfer(), but if us=
ing
> >> workqueue the we can avoid using the spinlock and also avoid the p=
roblem.
> >>
> >> Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
> >> ---
> >>  drivers/mfd/rtsx_pcr.c            |  132 ++++--------
> >>  drivers/mmc/host/rtsx_pci_sdmmc.c |  418 ++++++------------------=
-------------
> >>  include/linux/mfd/rtsx_common.h   |    1 -
> >>  include/linux/mfd/rtsx_pci.h      |    6 -
> >>  4 files changed, 109 insertions(+), 448 deletions(-)
> >
> > This patch should be sent to the -rcs as soon as possible:
>=20
> Do you mind helping out doing it here Lee? Not sure how busy Chris is
> at the moment.

I don't mind. I just need a maintainer Ack from one of you guys.

> >
> > Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
