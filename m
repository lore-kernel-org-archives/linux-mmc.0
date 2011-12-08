From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [MXS MMC v2 2/4] Some cleanups for the MMC driver
Date: Thu, 8 Dec 2011 17:17:02 +0800
Message-ID: <20111208091701.GC7913@S2100-06.ap.freescale.net>
References: <cover.1323328267.git.LW@KARO-electronics.de>
 <d935557e044d2ebc56b4e70487b519fe722e9017.1323328267.git.LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe003.messaging.microsoft.com ([213.199.154.206]:8893
	"EHLO AM1EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750716Ab1LHJEQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Dec 2011 04:04:16 -0500
Content-Disposition: inline
In-Reply-To: <d935557e044d2ebc56b4e70487b519fe722e9017.1323328267.git.LW@KARO-electronics.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Thu, Dec 08, 2011 at 09:17:45AM +0100, Lothar Wa=DFmann wrote:
>  - Remove bogus parens around numerical arguments in #define's
>  - When defining bit masks, use the #def for the shift count
>    instead of repeating the numbers
>  - Remove 'break' at end of switch statement
>=20
> Changes wrt v1:
>  - break long lines
>  - leave indentation as is
>=20
> Signed-off-by: Lothar Wa=DFmann <LW@KARO-electronics.de>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Not sure if Chris will ask you to add proper subject prefix though :)

--=20
Regards,
Shawn

