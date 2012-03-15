From: Per Forlin <per.forlin@stericsson.com>
Subject: Re: [PATCH 0/5] MMC: mmci: Provide bindings for Device Tree
Date: Thu, 15 Mar 2012 16:06:40 +0100
Message-ID: <CAFEEs1kz+QT_4Yc6byS4se0EMZvqA5hp5CvLvvtNgC++AJboxA@mail.gmail.com>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53505 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030576Ab2COPGk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 11:06:40 -0400
Received: by gghe5 with SMTP id e5so3135952ggh.19
        for <linux-mmc@vger.kernel.org>; Thu, 15 Mar 2012 08:06:40 -0700 (PDT)
In-Reply-To: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, arnd@arndb.de, niklas.hernaeus@linaro.org, linux-mmc@vger.kernel.org

Hi,

I would like to see what the minimal required change is to support DT
for mmci without factorization.
1. Minimal change in mmci.
2. Add mmci_dt.c which contains the DT-populate code.

The factorization could be done as step 2 I think.

What do you say?

BR
Per

On Wed, Mar 14, 2012 at 3:19 PM, Lee Jones <lee.jones@linaro.org> wrote=
:
> This patch-set splits out ux500 and ARM specific variants from mmci
> core code, applies generic bindings for use by all variants, then
> enables the ux500 variant for use with Device Tree.
>
> =A0Documentation/devicetree/bindings/mmc/mmci.txt | =A0 27 +++
> =A0arch/arm/boot/dts/db8500.dtsi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A06 +-
> =A0arch/arm/boot/dts/snowball.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 30 +++-
> =A0arch/arm/mach-ux500/board-mop500.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
3 +-
> =A0drivers/mmc/host/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A02 +-
> =A0drivers/mmc/host/mmci-arm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 65 ++++++
> =A0drivers/mmc/host/mmci-ux500.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0260 ++++++++++++++++++++++++
> =A0drivers/mmc/host/mmci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0194 +++++-------------
> =A0drivers/mmc/host/mmci.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 37 ++++
> =A09 files changed, 473 insertions(+), 151 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
