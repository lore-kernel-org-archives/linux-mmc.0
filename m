From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3 v6] mmc: sh_mmcif: add parent clk support
Date: Mon, 25 May 2015 10:44:26 +0200
Message-ID: <CAPDyKFrqZMv25rYEwGopNQAajUAsXbFucX3X4wmRveFtQfbZ6Q@mail.gmail.com>
References: <873840a4ch.wl%kuninori.morimoto.gx@renesas.com>
	<87617vpqy3.wl%kuninori.morimoto.gx@renesas.com>
	<CAPDyKFpi6NXx+s1eCJ0T9h_sxmQsXZRUxXi8=kmp5ohLJBHuwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34633 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbbEYIo0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 May 2015 04:44:26 -0400
Received: by qkgx75 with SMTP id x75so59757207qkg.1
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2015 01:44:26 -0700 (PDT)
In-Reply-To: <CAPDyKFpi6NXx+s1eCJ0T9h_sxmQsXZRUxXi8=kmp5ohLJBHuwA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, kobayashi <keita.kobayashi.ym@renesas.com>

On 22 May 2015 at 16:01, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 14 May 2015 at 09:20, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
>>
>> Hi Ulf, Simon
>>
>> These patches are v6 of sh_mmcif clock support.
>>
>> 1) - 2) : cleanup patches
>> 3)      : v6 patch for clk
>> 4) - 5) : DTS patch
>>
>> Simon
>>
>>  1) - 3) only : driver uses default clock
>>  4) - 5) only : driver uses it, but it is updated to default clock
>>  1) - 5) all  : it uses new method
>>
>> so, you can check 4) - 5) without thinking about 1) - 3).
>>
>> Kuninori Morimoto (5):
>>       1) mmc: sh_mmcif: add sh_mmcif_host_to_dev() macro and use it.
>>       2) mmc: sh_mmcif: use sh_mmcif_xxx prefix for all functions
>>       3) mmc: sh_mmcif: calculate best clock with parent clock
>>       4) ARM: shmobile: r8a7790: add MMCIF max-frequency
>>       5) ARM: shmobile: r8a7791: add MMCIF max-frequency
>>
>>  Documentation/devicetree/bindings/mmc/renesas,mmcif.txt |   3 ++
>>  arch/arm/boot/dts/r8a7790.dtsi                          |   2 +
>>  arch/arm/boot/dts/r8a7791.dtsi                          |   1 +
>>  drivers/mmc/host/sh_mmcif.c                             | 220 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------
>>  4 files changed, 161 insertions(+), 65 deletions(-)
>
> Thanks, applied patch 1->3. I leave 4->5 to Simon.

I realized the patch 3 caused a compiler warning. I have fixed it up,
so no worries!

Kind regards
Uffe
