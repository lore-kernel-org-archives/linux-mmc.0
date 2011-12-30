From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 2/4] ARM: pxa168: Add SDHCI support
Date: Fri, 30 Dec 2011 08:36:33 +0800
Message-ID: <CAN1soZwG37noxK8CUe7zMtaNJPTWSok5ROUXj_YvZ+dLEVkomA@mail.gmail.com>
References: <CAN1soZwwPe1Xdh=EO-wdynihaBQ8DvWV=imjokJvDZVC+qqdSg@mail.gmail.com>
	<1325166236-18650-1-git-send-email-tanmay.upadhyay@einfochips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55251 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754955Ab1L3Age convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Dec 2011 19:36:34 -0500
Received: by vcbfk14 with SMTP id fk14so10412228vcb.19
        for <linux-mmc@vger.kernel.org>; Thu, 29 Dec 2011 16:36:34 -0800 (PST)
In-Reply-To: <1325166236-18650-1-git-send-email-tanmay.upadhyay@einfochips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Cc: eric.y.miao@gmail.com, jason.chagas@marvell.com, prakity@marvell.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 29, 2011 at 9:43 PM, Tanmay Upadhyay
<tanmay.upadhyay@einfochips.com> wrote:
> v2 - clock register for SDHCI are not common across all MMP SoCs.
> =A0 =A0 So, move PXA168 implementation to pxa168.c
>
> v3 - sdhci-pxav1 driver code is merged with sdhci-pxav2. So, change
> =A0 =A0 the device name accordingly
> =A0 - start sdhci device numbering from 1 as other PXA168 devices
> =A0 =A0 does that
>
> v4 - Use different names for SD clock registers for PXA168 instead
> =A0 =A0 of redefining them in pxa168.c. Suggested by Haojian Zhuang
>
> v5 - Have two different clock enable functions for clock block 1 & 2
> =A0 =A0 & don't change indentation in regs-apmu.h as suggested by Hao=
jian
> =A0 =A0 Zhuang
> =A0 - Use device name while adding clock as suggested by Russell King
>
> Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
> Reviewed-by: Philip Rakity <prakity@marvell.com>
> ---

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
