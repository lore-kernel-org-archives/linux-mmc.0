From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/5] MMC: mmci: Provide bindings for Device Tree
Date: Thu, 15 Mar 2012 15:44:21 +0000
Message-ID: <4F620E55.4000701@linaro.org>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org> <CAFEEs1kz+QT_4Yc6byS4se0EMZvqA5hp5CvLvvtNgC++AJboxA@mail.gmail.com> <4F6209DA.1080809@linaro.org> <201203151532.44363.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50907 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030466Ab2COPo7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 11:44:59 -0400
Received: by bkcik5 with SMTP id ik5so2225947bkc.19
        for <linux-mmc@vger.kernel.org>; Thu, 15 Mar 2012 08:44:57 -0700 (PDT)
In-Reply-To: <201203151532.44363.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Per Forlin <per.forlin@stericsson.com>, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, niklas.hernaeus@linaro.org, linux-mmc@vger.kernel.org

On 15/03/12 15:32, Arnd Bergmann wrote:
> On Thursday 15 March 2012, Lee Jones wrote:
>>> I would like to see what the minimal required change is to support =
DT
>>> for mmci without factorization.
>>> 1. Minimal change in mmci.
>>> 2. Add mmci_dt.c which contains the DT-populate code.
>>>
>>> The factorization could be done as step 2 I think.
>>>
>>> What do you say?
>>
>> I'm wondering what the difference is as the work has already been do=
ne.
>>
>> It was Arnd's suggestion to separate out the two types of variants, =
and
>> I'm quite fond of the new (fully featured) layout.
>=20
> Right, I usually prefer cleanups or other refactoring to be done firs=
t, and
> then features added on top.
>=20
> You could in theory add have just patches 3/4/5 all applied without
> the refactoring, but that I would be worried that this causes depende=
ncies
> between the mmci driver and ux500 specific functionality like the
> stedma40_filter function.

It's a possibility that we may have run into that even with this new
layout. Remember you suggested that the u300 variant may be better off
going into the ARM variant's file, but I wasn't quite sure, as it was a=
n
ST product. Well the afore mentioned function may still cause us some
trouble. I am in the mists of some regression testing now. I'll report
back when I know more.

Kind regards,
Lee


--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
