From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH 5/9] sdhci-5:add the 32BIT_CMD_TRANS_COMBINATION quirk to
 support FSl eSDHC
Date: Wed, 1 Sep 2010 19:52:41 +0200
Message-ID: <AANLkTimHF4uS+ACLOKPmo86sd5Cvb77XdNB2jZNUDeU=@mail.gmail.com>
References: <1283334494-12678-1-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37324 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab0IARwo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Sep 2010 13:52:44 -0400
Received: by vws3 with SMTP id 3so6681304vws.19
        for <linux-mmc@vger.kernel.org>; Wed, 01 Sep 2010 10:52:43 -0700 (PDT)
In-Reply-To: <1283334494-12678-1-git-send-email-r65037@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

2010/9/1 Richard Zhu <r65037@freescale.com>:
> The FSL's eSDHC have one 32bit register that combine the two
> 16bit Transfer Mode and Command registers.
> Add this quirk to let SW driver to support FSL's eSDHC.

What happens if you do this for every SDHCI host? Is there one that
breaks if changing the two registers are combined into single 32-bit
write?

Best Regards,
Micha=B3 Miros=B3aw
