From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [MXS MMC 4/5] Check the return codes of clk_enable() and
 mxs_reset_block()
Date: Wed, 7 Dec 2011 20:33:05 +0800
Message-ID: <20111207123304.GN5550@S2100-06.ap.freescale.net>
References: <cover.1323177907.git.LW@KARO-electronics.de>
 <b4779523002ceef3e95887bbcf7ed570cdd93a95.1323177907.git.LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:25325 "EHLO
	TX2EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755529Ab1LGMUV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Dec 2011 07:20:21 -0500
Content-Disposition: inline
In-Reply-To: <b4779523002ceef3e95887bbcf7ed570cdd93a95.1323177907.git.LW@KARO-electronics.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Tue, Dec 06, 2011 at 02:41:29PM +0100, Lothar Wa=DFmann wrote:
> Add an int return value to mxs_mmc_reset(), so that the return code o=
f
> mxs_reset_block() can be promoted to the caller.
> Also check the return code of clk_enable() in the probe function.
>=20
> Signed-off-by: Lothar Wa=DFmann <LW@KARO-electronics.de>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

--=20
Regards,
Shawn

