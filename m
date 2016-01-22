From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH RFC 11/15] ARM: dts: sun8i: sina33: Enable
 hardware reset and HS-DDR for eMMC
Date: Fri, 22 Jan 2016 21:42:58 +0100
Message-ID: <20160122204258.GD3682@lukather>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
 <1453354002-28366-12-git-send-email-wens@csie.org>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBZFIRK2QKGQE2NCKOBQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1453354002-28366-12-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Thu, Jan 21, 2016 at 01:26:38PM +0800, Chen-Yu Tsai wrote:
> mmc2 has a special pin for eMMC hardware reset, which is controllable
> from the controller. Add the "mmc-cap-hw-reset" property to denote that
> this controller supports this function, and the pins are actually used.
> 
> Also increase the signal drive strength for mmc2 pins, for HS-DDR mode
> support.
> 
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

Applied, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--uxuisgdDHaNETlh8--
