From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/2] mmc: rtsx: revert support for mmc async request
Date: Tue, 29 Apr 2014 09:02:40 +0100
Message-ID: <20140429080240.GC29462@lee--X1>
References: <cover.1398735435.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:65155 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbaD2ICr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Apr 2014 04:02:47 -0400
Received: by mail-wg0-f51.google.com with SMTP id z12so6306309wgg.22
        for <linux-mmc@vger.kernel.org>; Tue, 29 Apr 2014 01:02:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1398735435.git.micky_ching@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: micky_ching@realsil.com.cn
Cc: chris@printf.net, ulf.hansson@linaro.org, sameo@linux.intel.com, gregkh@linuxfoundation.org, dan.carpenter@oracle.com, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, rogerable@realtek.com, wei_wang@realsil.com.cn

> From: Micky Ching <micky_ching@realsil.com.cn>
>=20
> The commit <mmc: rtsx: add support for pre_req and post_req> have som=
e problem,
> using mutex_unlock() in atomic context, spinlock deadlock, it is hard=
 to fix
> these problem, and better to use a new method. So just remove it.
>=20
> The commit <mmc: rtsx: modify error handle and remove smatch warnings=
> depends
> on the previous patch. And mainly fix some problem for the previous p=
atch. So
> need remove.
>=20
> Micky Ching (2):
>   mmc: rtsx: Revert "mmc: rtsx: modify error handle and remove smatch
>     warnings"
>   mmc: rtsx: Revert "mmc: rtsx: add support for pre_req and post_req"
>=20
>  drivers/mfd/rtsx_pcr.c            |  132 ++++-------
>  drivers/mmc/host/rtsx_pci_sdmmc.c |  459 +++++++--------------------=
----------
>  include/linux/mfd/rtsx_common.h   |    1 -
>  include/linux/mfd/rtsx_pci.h      |    6 -
>  4 files changed, 124 insertions(+), 474 deletions(-)

Just to clarify, what commit did you base these changes on? Have you
tested to ensure everything works as it should with these two
reversions?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
