From: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>
Subject: Re: [PATCH 0/6] SD/MMC driver for MX25/35/51
Date: Wed, 13 Oct 2010 10:15:04 +0200
Message-ID: <4CB56A88.2040101@eukrea.com>
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de> <87aamjxe00.fsf@lechat.rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 68.mail-out.ovh.net ([91.121.185.69]:58481 "HELO
	68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753078Ab0JMIPN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Oct 2010 04:15:13 -0400
In-Reply-To: <87aamjxe00.fsf@lechat.rtp-net.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Zhu Richard-R65037 <r65037@freescale.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

Le 13/10/2010 00:06, Arnaud Patard (Rtp) a =E9crit :
> Wolfram Sang<w.sang@pengutronix.de>  writes:
>> Here is the hopefully final (famous last words) version of my patch =
series. The
>> first four are still updates/improvements for sdhci and sdhci-pltfm =
and are of
>> generic interest, too. Thanks to Eric for the tests on MX25/35. Look=
ing forward
>> to comments/applied-to-mmc-next-messages ;)
>>
>> The series is based on mmc-next as of today and also available at
>>
>> 	git://git.pengutronix.de/git/wsa/linux-2.6.git pcm043-mmc
>
> I've tried it on a efika mx (to2 version) and I've a problem with the
> write-protect. It's on a GPIO and I don't see any way to configure th=
e
> esdhc-imx driver to use it. Any idea on how it should be done ?
>
it's actually not yet supported by the driver. There is a wp_gpio in
struct esdhc_platform_data (arch/arm/plat-mxc/include/mach/esdhc.h)
but it's not yet used by the driver.
Also card detect using a GPIO is not implemented and card detect if=20
actually done by polling.

Eric
