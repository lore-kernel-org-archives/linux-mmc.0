From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] mmc: rtsx: Revert "mmc: rtsx: modify error
 handleandremove smatch warnings"
Date: Thu, 8 May 2014 08:55:42 +0100
Message-ID: <20140508075542.GC5307@lee--X1>
References: <cover.1398735435.git.micky_ching@realsil.com.cn>
 <1076b1824732688774d223a14595ecf26a375d82.1398735435.git.micky_ching@realsil.com.cn>
 <CAPDyKFoZ2_H6Jh0+84zLBhayMb0=q1eJw=vC_m41iCsbz0siFw@mail.gmail.com>
 <536B1B05.6010604@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:57102 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbaEHHzu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 May 2014 03:55:50 -0400
Received: by mail-ie0-f182.google.com with SMTP id tp5so2237290ieb.13
        for <linux-mmc@vger.kernel.org>; Thu, 08 May 2014 00:55:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <536B1B05.6010604@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: micky <micky_ching@realsil.com.cn>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@oracle.com>, devel@linuxdriverproject.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Roger <rogerable@realtek.com>, Wei WANG <wei_wang@realsil.com.cn>

> It seems Chris is too busy to responding, so would you help to pick
> this patch for 3.15 fix.

Hmmmm... that's pretty bad timing.  I've literally just sent the
pull-request containing the MFD/MMC fixup branch to Linus.  I guess
Ulf will have to do it.

> >>>From: Micky Ching<micky_ching@realsil.com.cn>
> >>>
> >>>This reverts commit 1f7b581b3ffcb2a8437397a02f4af89fa6934d08.
> >>>
> >>>The patch depend on commit c42deffd5b53c9e583d83c7964854ede2f12410=
d
> >>><mmc: rtsx: add support for pre_req and post_req>, but the previou=
s
> >>>patch was discard. So we have to delete the patch.
> >>>
> >>>Signed-off-by: Micky Ching<micky_ching@realsil.com.cn>
> >Acked-by: Ulf Hansson<ulf.hansson@linaro.org>
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
