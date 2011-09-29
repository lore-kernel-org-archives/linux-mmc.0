From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 0/2] arm: omap4: hsmmc: pbias fixes
Date: Thu, 29 Sep 2011 20:15:54 +0530
Message-ID: <CANrkHUbSRLZe+6QWOSE0Hz6r5NUkRxUH+RW2_CYiQ3wrWu-Pzw@mail.gmail.com>
References: <4e848386.2a1f440a.4d36.1824SMTPIN_ADDED@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:39366 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751692Ab1I2Op4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 29 Sep 2011 10:45:56 -0400
In-Reply-To: <4e848386.2a1f440a.4d36.1824SMTPIN_ADDED@mx.google.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, kishore.kadiyala@ti.com, vishp@ti.com

> From: Balaji T K <balajitk@ti.com>
Will resend this series as my email id is garbled.

>
> MMC1 pbias and speed control fix for SDMMC1 extended I/O cell
>
> Balaji T K (2):
> =A0arm: omap4: hsmmc: Fix Pbias configuration on regulator OFF
> =A0arm: omap4: hsmmc: configure SDMMC1_DR0 properly
>
> =A0arch/arm/mach-omap2/hsmmc.c | =A0 16 +++-------------
> =A01 files changed, 3 insertions(+), 13 deletions(-)
>
>
