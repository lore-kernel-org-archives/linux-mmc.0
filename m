From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH] mmc: Add architecture dependency for Marvell SoC controller
Date: Wed, 15 Sep 2010 19:20:38 +0800
Message-ID: <AANLkTi=fsntfyAoFygrTrksVARvQpuxie6tFxCcuLtVR@mail.gmail.com>
References: <1284366279-17140-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20100914190549.GA21918@void.printf.net>
	<20100915094006.GA21620@sirena.org.uk>
	<FCBE654890C0334289D0AD3AF4EF009FD18EE74AA8@IL-MB01.marvell.com>
	<20100915110001.GA4254@rakim.wolfsonmicro.main>
	<FCBE654890C0334289D0AD3AF4EF009FD18EE74AC7@IL-MB01.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60115 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab0IOLUk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Sep 2010 07:20:40 -0400
In-Reply-To: <FCBE654890C0334289D0AD3AF4EF009FD18EE74AC7@IL-MB01.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saeed Bishara <saeed@marvell.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Sep 15, 2010 at 6:06 PM, Saeed Bishara <saeed@marvell.com> wrot=
e:
>
>>Which CPUs does the driver actually support? =A0The Kconfig and
>>commit log
>>just say "Marvell" so I went for the conservative option and included
>>all Marvell CPUs I was aware of.
> The Marvell Dove SoC includes this device, this SoC defined by ARCH_D=
OVE
> I guess it found also only on mmp (defined by ARCH_MMP), Haojian, can=
 you confirm?
> saeed

As I know, MG1 is also using this IP. Although MG1 isn't supported in
mainline, it's planned to be added into ARCH_PXA or one new ARCH. So
PLAT_PXA is preferred.

Best Regards
Haojian
