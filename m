From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: [PATCH 0/4] Adding support for esdhc on mx35/51
Date: Fri, 24 Sep 2010 15:08:52 +0800
Message-ID: <A88EF4D64D8447468743DC1503C0B6CA0D4BFC@zch01exm22.fsl.freescale.net>
References: <1285072210-10207-1-git-send-email-w.sang@pengutronix.de> <A88EF4D64D8447468743DC1503C0B6CA0D4BC5@zch01exm22.fsl.freescale.net> <20100924064310.GA30543@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:16022
	"EHLO DB3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751963Ab0IXHJB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 24 Sep 2010 03:09:01 -0400
Received: from mail17-db3 (localhost.localdomain [127.0.0.1])	by
 mail17-db3-R.bigfish.com (Postfix) with ESMTP id 0B89F1050391	for
 <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 07:19:34 +0000 (UTC)
Received: from DB3EHSMHS005.bigfish.com (unknown [10.3.81.248])	by
 mail17-db3.bigfish.com (Postfix) with ESMTP id 58DF5800050	for
 <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 07:19:33 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id o8O78vaW010111	for
 <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 00:08:57 -0700 (MST)
Received: from zch01exm22.fsl.freescale.net (zch01exm22.ap.freescale.net
 [10.192.129.206])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
 o8O7OQip007209	for <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 02:24:27
 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <20100924064310.GA30543@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anton Vorontsov <cbouatmailru@gmail.com>

Hi Wolfram:
See my comments.

Best Regards,
Richard Zhu
Freescale Semiconductor
Tel: +86-021-28937189
Email:Hong-Xing.Zhu@freescale.com 


-----Original Message-----
From: Wolfram Sang [mailto:w.sang@pengutronix.de] 
Sent: Friday, 24 September, 2010 14:43
To: Zhu Richard-R65037
Cc: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
Anton Vorontsov
Subject: Re: [PATCH 0/4] Adding support for esdhc on mx35/51

Hi Richard,

> * About the share between i.MX and PPC eSDHC.
> Why configure a few parts be shared between the i.MX eSDHC and PPC 
> eSDHC? Can they be separated into two independent systems?

The rule of thumb is to avoid code-duplication. Assume the PPC driver
gets fixed an off-by-one error in the freq-calculation, you surely want
to have that fix on imx, too.

> It would bring the conveniences to maintain stuff in the future if we 
> separate them.

If you can name these conveniences and they are convincing, we can keep
them seperate. At the moment, I don't see them (what doesn't mean they
don't exist)
[<Zhu Richard-r65037>] As Anton's description different eSDHC IP on the
i.MX and the PPC may have the different IC bugs or limitations.
As I know that although in the i.MX SOC family, there are a few
differences between different SOCs. And the behaviors of SW driver may
be impacted by these differences.
I'm afraid that the differences of eSDHC IP module between i.MX and PPC
maybe bigger and bigger in future.

BTW, the block size of the i.MX eSDHC is not forced to 2K size. Up to
now, the default 512byes per sector is used in FSL i.MX Linux BSP.

> And there is already one set of eSDHC driver for all the i.MX SOCs.

I am confused: which set do you mean?
[<Zhu Richard-r65037>] The driver used for i.MX eSDHC. The one used by
i.MX35 in Linux kernel now, and the coming MX51 and so on.
It is better that one driver supports all i.MX SOC's eSDHC modules in
future (MX25, MX35, MX51, MX53...).

> As we know that i.MX and PPC are the disparate SOC families.

Well, if the eSDHC-core itself is the same or very similar, that doesn't
really matter IMO. Especially as the of-platform-bus might disappear
somewhen in the future, the PPC and imx-drivers could become more
similar.

> * About the driver name of i.MX eSDHC driver, I think that use the imx

> to identify it is better than esdhc.

I picked up Anton's suggestion 'sdhci-esdhc-imx.c' so far. Although I am
still not sure if 'sdhci-esdhc-pltfm.c' would be more precise.

> As I know that the eSDHC name wouldn't be used anymore in next 
> generation SOCs of i.MX family.
> So the name of imx would be much clear and exact.

Not really, because all _existing_ implementations are called eSDHC, no?
:) If some future incarnations have a different name, but behave the
same or very similar, this is usually no problem. Check for example the
I2C eeprom driver which is named 'at24' but support basically all
EEPROMs and not only Atmel ones. Same goes for a couple of RTC-drivers,
etc...
[<Zhu Richard-r65037>] :), ok.

Kind regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang
|
Industrial Linux Solutions                 | http://www.pengutronix.de/
|

