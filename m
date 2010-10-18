From: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>
Subject: Re: [PATCH 0/6] SD/MMC driver for MX25/35/51
Date: Mon, 18 Oct 2010 13:51:04 +0200
Message-ID: <4CBC34A8.6020409@eukrea.com>
References: <20101013082930.GA11286@pengutronix.de> <8762x6xx00.fsf@lechat.rtp-net.org> <A88EF4D64D8447468743DC1503C0B6CA0D557C@zch01exm22.fsl.freescale.net> <20101013100632.GC11286@pengutronix.de> <4CB58565.5020806@eukrea.com> <A88EF4D64D8447468743DC1503C0B6CA0D557D@zch01exm22.fsl.freescale.net> <20101013102055.GD11286@pengutronix.de> <20101015102729.GB4276@pengutronix.de> <A88EF4D64D8447468743DC1503C0B6CA0D581A@zch01exm22.fsl.freescale.net> <4CBC1528.40907@eukrea.com> <20101018113836.GB15440@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 63.mail-out.ovh.net ([91.121.185.56]:42684 "HELO
	63.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750768Ab0JRLvJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Oct 2010 07:51:09 -0400
In-Reply-To: <20101018113836.GB15440@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Zhu Richard-R65037 <r65037@freescale.com>, linux-arm-kernel@lists.infradead.org, Guo Shawn-R65073 <R65073@freescale.com>, linux-mmc@vger.kernel.org, Arnaud Patard <arnaud.patard@rtp-net.org>

Le 18/10/2010 13:38, Wolfram Sang a =E9crit :
>> you seems to be right, the attached patch seems to fix it (tested on=
 our
>> board using a Linaro rootfs on a Transcend SDHC card and I didn't ge=
t
>> errors after applying this patch but I'm stopped by udev errors now =
with
>> this rootfs).
>
> Is this needed on MX35, too?
>
will test asap and send a formal patch once tested.

Eric
