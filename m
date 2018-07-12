From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] mmc: sunxi: Use new timing mode for A64
 eMMC controller
Date: Thu, 12 Jul 2018 09:19:59 +0200
Message-ID: <20180712071959.fi4rhgwv2iuoelbl@flea>
References: <20180712030225.15681-1-wens@csie.org>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qbf5hasrycpeytaz"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBIECTTNAKGQEZFH6WRI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20180712030225.15681-1-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--qbf5hasrycpeytaz
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

Hi,

On Thu, Jul 12, 2018 at 11:02:25AM +0800, Chen-Yu Tsai wrote:
> The eMMC controller is also a new timing mode controller, but it doesn't
> have the timing mode switch. It does however have signal delay and
> calibration controls, typical of Allwinner MMC controllers that support
> the new timing mode.
> 
> Enable the new timing mode setting for the A64 eMMC controller. This
> also enables MMC HS-DDR modes, which gives higher throughput for eMMC
> chips that support it, and can deliver such throughput.
> 
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

That doesn't look right. The datasheet explicitly mentions that this
bit doesn't apply to the eMMC controller, and the BSP is doing the same:
https://github.com/longsleep/linux-pine64/blob/lichee-dev-v3.10.65/drivers/mmc/host/sunxi-mmc-sun50iw1p1-1.c

vs
https://github.com/longsleep/linux-pine64/blob/lichee-dev-v3.10.65/drivers/mmc/host/sunxi-mmc-sun50iw1p1-2.c

And I definitely remember having HS-DDR working back when I added the
a64 eMMC support.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
--qbf5hasrycpeytaz--
