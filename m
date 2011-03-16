From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH] arm: mmci: Add ARM variant with extended FIFO
Date: Wed, 16 Mar 2011 16:53:02 +0000
Message-ID: <1300294382.19700.12.camel@hornet.cambridge.arm.com>
References: <1299863887-15490-1-git-send-email-pawel.moll@arm.com>
	 <4D80E46C.3010103@canonical.com>
	 <20110316163448.GA16538@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from service87.mimecast.com ([94.185.240.25]:37107 "HELO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752335Ab1CPQxH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2011 12:53:07 -0400
In-Reply-To: <20110316163448.GA16538@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Matt Waddel <matt.waddel@canonical.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> > > New IO FPGA implementation for Versatile Express boards contain
> > > MMCI (PL180) cell with FIFO extended to 128 words (512 bytes).
> > >=20
> > > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> >=20
> > Tested-by: Matt Waddel <matt.waddel@linaro.org>
> >=20
> > This patch improves MMC performance on my vexpress system. Also
> > fixes "mmcblk0: error -5 transferring data" errors.
>=20
> You should use the patch I sent to do dynamic clocking if you're
> concerned about performance.  That patch improves performance by
> a factor of 8 compared to anything possible by increasing the FIFO
> depth.
>=20
> I am very much of the opinion that deepening the FIFOs is just a
> sticky plaster over the problem - and I said as much when it was
> first proposed, pointing out that there's other better solutions.

# cat /sys/devices/mb\:mmci/id                            =20
01041180
# cat /sys/module/mmci/parameters/fmax                    =20
12000000                                                               =
        =20
# dd if=3D/dev/mmcblk0 of=3D/dev/null bs=3D128k count=3D100       =20
100+0 records in                                                       =
        =20
100+0 records out                                                      =
        =20
13107200 bytes (13 MB) copied, 9.04218 s, 1.4 MB/s

Of course without the proper error handling, as introduced by your
patch, one will face the same problems with interrupt latency as
previously. But the peak performance seems to noticeably better...

Regards

Pawe=C5=82

PS. The FPGA with extended MMCI FIFO will be available on the next VE C=
D
update, which is going to be released next month.


