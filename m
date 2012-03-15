From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/5] MMC: mmci: Provide bindings for Device Tree
Date: Thu, 15 Mar 2012 15:25:14 +0000
Message-ID: <4F6209DA.1080809@linaro.org>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org> <CAFEEs1kz+QT_4Yc6byS4se0EMZvqA5hp5CvLvvtNgC++AJboxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59277 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030466Ab2COPZQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 11:25:16 -0400
Received: by mail-bk0-f46.google.com with SMTP id ik5so2206829bkc.19
        for <linux-mmc@vger.kernel.org>; Thu, 15 Mar 2012 08:25:16 -0700 (PDT)
In-Reply-To: <CAFEEs1kz+QT_4Yc6byS4se0EMZvqA5hp5CvLvvtNgC++AJboxA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, arnd@arndb.de, niklas.hernaeus@linaro.org, linux-mmc@vger.kernel.org

Hi Per,

> I would like to see what the minimal required change is to support DT
> for mmci without factorization.
> 1. Minimal change in mmci.
> 2. Add mmci_dt.c which contains the DT-populate code.
>=20
> The factorization could be done as step 2 I think.
>=20
> What do you say?

I'm wondering what the difference is as the work has already been done.

It was Arnd's suggestion to separate out the two types of variants, and
I'm quite fond of the new (fully featured) layout.

Kind regards,
Lee

> On Wed, Mar 14, 2012 at 3:19 PM, Lee Jones <lee.jones@linaro.org> wro=
te:
>> This patch-set splits out ux500 and ARM specific variants from mmci
>> core code, applies generic bindings for use by all variants, then
>> enables the ux500 variant for use with Device Tree.
>>
>>  Documentation/devicetree/bindings/mmc/mmci.txt |   27 +++
>>  arch/arm/boot/dts/db8500.dtsi                  |    6 +-
>>  arch/arm/boot/dts/snowball.dts                 |   30 +++-
>>  arch/arm/mach-ux500/board-mop500.c             |    3 +-
>>  drivers/mmc/host/Makefile                      |    2 +-
>>  drivers/mmc/host/mmci-arm.c                    |   65 ++++++
>>  drivers/mmc/host/mmci-ux500.c                  |  260 +++++++++++++=
+++++++++++
>>  drivers/mmc/host/mmci.c                        |  194 +++++--------=
-----
>>  drivers/mmc/host/mmci.h                        |   37 ++++
>>  9 files changed, 473 insertions(+), 151 deletions(-)
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
