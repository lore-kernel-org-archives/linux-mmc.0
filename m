From: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>
Subject: Re: [PATCH 2/2] sdhci-esdhc-imx: enable QUIRK_NO_MULTIBLOCK only
 for i.MX25 and i.MX35
Date: Fri, 22 Oct 2010 09:07:58 +0200
Message-ID: <4CC1384E.4000403@eukrea.com>
References: <4CC0A281.1010202@eukrea.com> <1287696028-27854-2-git-send-email-eric@eukrea.com> <20101022061803.GB5572@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 63.mail-out.ovh.net ([91.121.185.56]:54359 "HELO
	63.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752019Ab0JVHIF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Oct 2010 03:08:05 -0400
In-Reply-To: <20101022061803.GB5572@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.gsc@gmail.com, nicolas.pitre@linaro.org, r65037@freescale.com, amit.kucheria@linaro.org

Hi Wolfram,

Le 22/10/2010 08:18, Wolfram Sang a =E9crit :
> On Thu, Oct 21, 2010 at 11:20:28PM +0200, Eric B=E9nard wrote:
>> only these CPU's errata list this bug.
>
> So, it was not directly tested?
>
While I was testing the other quirk, I tested this one on 25, 35 & 51, =
but I=20
can't trigger the bug on any of these CPU (without the quirk : the bug =
suppose=20
there is an error reading one block and that the MMC layer then sends C=
MD12=20
which can't stop the AHB transfer and thus the controler stays blocked.=
 As I=20
didn't met an error to read a block, I wasn't able to trigger the bug.

Eric
