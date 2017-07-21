From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 02/10] clk: sunxi-ng: Add MP_MMC clocks
 that support MMC timing modes switching
Date: Fri, 21 Jul 2017 09:19:48 +0200
Message-ID: <20170721071948.jofji4lwbq6s4ims@flea>
References: <20170720034452.15920-1-wens@csie.org>
 <20170720034452.15920-3-wens@csie.org>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qsfqqpu77stq6c7r"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBI6WY3FQKGQEN2T5LXI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170720034452.15920-3-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--qsfqqpu77stq6c7r
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Thu, Jul 20, 2017 at 11:44:44AM +0800, Chen-Yu Tsai wrote:
> +/* Special class of M-P clock that supports MMC timing modes */
> +
> +#define SUNXI_CCU_MP_MMC_WITH_MUX_GATE(_struct, _name, _parents, _reg,	\
> +				       _mshift, _mwidth,		\
> +				       _pshift, _pwidth,		\
> +				       _muxshift, _muxwidth,		\
> +				       _gate, _flags)			\
> +	struct ccu_mp _struct = {					\
> +		.enable	= _gate,					\
> +		.m	= _SUNXI_CCU_DIV(_mshift, _mwidth),		\
> +		.p	= _SUNXI_CCU_DIV(_pshift, _pwidth),		\
> +		.mux	= _SUNXI_CCU_MUX(_muxshift, _muxwidth),		\
> +		.common	= {						\
> +			.reg		= _reg,				\
> +			.features	= CCU_FEATURE_MMC_TIMING_SWITCH, \
> +			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
> +							      _parents, \
> +							      &ccu_mp_mmc_ops, \
> +							      _flags),	\
> +		}							\
> +	}
> +
> +extern const struct clk_ops ccu_mp_mmc_ops;
> +

I guess we can simplify a lot that macro, all the new-timings MMC
clocks have the same register layout.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--qsfqqpu77stq6c7r--
