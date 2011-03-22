From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH] arm: mmci: Add ARM variant with extended FIFO
Date: Tue, 22 Mar 2011 15:19:07 +0000
Message-ID: <1300807147.3532.25.camel@hornet.cambridge.arm.com>
References: <1299863887-15490-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from service87.mimecast.com ([94.185.240.25]:43825 "HELO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753064Ab1CVPTO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Mar 2011 11:19:14 -0400
In-Reply-To: <1299863887-15490-1-git-send-email-pawel.moll@arm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi Chris,

> New IO FPGA implementation for Versatile Express boards contain
> MMCI (PL180) cell with FIFO extended to 128 words (512 bytes).
>=20
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

How about this change? Matt Waddel tested it and Linus Walleij doesn't
mind it ;-)

Cheers!

Pawe=C5=82


