From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: [PATCH 0/4] Adding support for esdhc on mx35/51
Date: Fri, 24 Sep 2010 17:40:15 +0800
Message-ID: <A88EF4D64D8447468743DC1503C0B6CA0D4C19@zch01exm22.fsl.freescale.net>
References: <1285072210-10207-1-git-send-email-w.sang@pengutronix.de> <A88EF4D64D8447468743DC1503C0B6CA0D4BC5@zch01exm22.fsl.freescale.net> <20100924064310.GA30543@pengutronix.de> <A88EF4D64D8447468743DC1503C0B6CA0D4BFC@zch01exm22.fsl.freescale.net> <20100924085744.GA10334@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:56552 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338Ab0IXJkX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Sep 2010 05:40:23 -0400
Received: from mail45-tx2 (localhost.localdomain [127.0.0.1])	by
 mail45-tx2-R.bigfish.com (Postfix) with ESMTP id 713AE16880A7	for
 <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 09:40:22 +0000 (UTC)
Received: from TX2EHSMHS043.bigfish.com (unknown [10.9.14.254])	by
 mail45-tx2.bigfish.com (Postfix) with ESMTP id CC6A318C804E	for
 <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 09:40:21 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id o8O9eKxw029613	for
 <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 02:40:20 -0700 (MST)
Received: from zch01exm22.fsl.freescale.net (zch01exm22.ap.freescale.net
 [10.192.129.206])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 o8O9smju024996	for <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 04:54:49
 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <20100924085744.GA10334@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anton Vorontsov <cbouatmailru@gmail.com>

Hi Wolfram:
Sorry to bring the confusions to you.
I will use your git repos and make up the missing bits (i.e:the
HOST_CONROL and so on) and verify the func on MX51 BBG boards later.
BTW, Is the URL of your git repos the following one?
git://git.pengutronix.de/git/wsa/linux-2.6.git

Best Regards,
Richard Zhu
Freescale Semiconductor
Tel: +86-021-28937189
Email:Hong-Xing.Zhu@freescale.com 


-----Original Message-----
From: Wolfram Sang [mailto:w.sang@pengutronix.de] 
Sent: Friday, 24 September, 2010 16:58
To: Zhu Richard-R65037
Cc: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
Anton Vorontsov
Subject: Re: [PATCH 0/4] Adding support for esdhc on mx35/51

On Fri, Sep 24, 2010 at 03:08:52PM +0800, Zhu Richard-R65037 wrote:
> Hi Wolfram:
> See my comments.

BTW can't you get your mailer to quote like all others do? It is
inconvenient to read this way.

> > It would bring the conveniences to maintain stuff in the future if 
> > we separate them.
> 
> If you can name these conveniences and they are convincing, we can 
> keep them seperate. At the moment, I don't see them (what doesn't mean

> they don't exist) [<Zhu Richard-r65037>] As Anton's description 
> different eSDHC IP on the i.MX and the PPC may have the different IC 
> bugs or limitations.

Sure thing. I don't see any problem with that as I don't want to merge
them completely, but just to share the common parts. Fixups can be done
in the specific part.

> As I know that although in the i.MX SOC family, there are a few 
> differences between different SOCs. And the behaviors of SW driver may

> be impacted by these differences.

If you have even more incarnations of a similar core in the future to
come, that is another reason to share those parts which are in common.
Smaller differences can easily be handled in sdhci-esdhc-imx.c, I think.
For example, if stuff like

	if (cpu_is_mx35())
		quirks |= SDHCI_QUIRKS_NO_MULTIBLOCK;

will do, why would you want to duplicate all the code covering the
non-standard register layouts? Check the imx-spi driver how to handle
variations of a similar core.

> I'm afraid that the differences of eSDHC IP module between i.MX and 
> PPC maybe bigger and bigger in future.

If the core of a future IMX99 might be too different, we can have a
custom driver then, but for now, I think a common driver is the way to
go.

> BTW, the block size of the i.MX eSDHC is not forced to 2K size. Up to 
> now, the default 512byes per sector is used in FSL i.MX Linux BSP.

It is forced to 2K, because it would be otherwise set to 4K (according
to the cap-register) which is not conform to the spec 2.0. What is the
advantage of 512 byte?

> > And there is already one set of eSDHC driver for all the i.MX SOCs.
> 
> I am confused: which set do you mean?
> [<Zhu Richard-r65037>] The driver used for i.MX eSDHC. The one used by
> i.MX35 in Linux kernel now, and the coming MX51 and so on.
> It is better that one driver supports all i.MX SOC's eSDHC modules in 
> future (MX25, MX35, MX51, MX53...).

? Now I am totally confused. That is what I am aiming for :D My driver
was mainly tested on MX35 back then, but was clearly intended to be for
MX51. It was clearly mentioned in the subject "[PATCH 0/4] Adding
support for esdhc on mx35/51". Frankly, I was hoping for a patchset from
you adding the stuff you need for you MX51-board on top of mine, and not
a completely new series. Will have a look at that now...

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang
|
Industrial Linux Solutions                 | http://www.pengutronix.de/
|

