From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/3] mmc: sunxi: Set the 'New Timing'
 register for 8 bits DDR transfers
Date: Thu, 21 Jul 2016 10:56:15 +0200
Message-ID: <20160721085615.GG5993@lukather>
References: <cover.1469082481.git.moinejf@free.fr>
 <bc7b767cad6db159a44c4b98d5b1f3eb53c26bd3.1469082481.git.moinejf@free.fr>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1giRMj6yz/+FOIRq"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBME4YK6AKGQE2DMCQPI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <bc7b767cad6db159a44c4b98d5b1f3eb53c26bd3.1469082481.git.moinejf-GANU6spQydw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--1giRMj6yz/+FOIRq
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Wed, Jul 20, 2016 at 08:16:28PM +0200, Jean-Francois Moine wrote:
> The 'new timing mode' with 8 bits DDR works correctly when the NewTiming
> register is set.

What does that mode brings to the table?

> 
> Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
> ---
> Note about the 'new timing mode'.
> 
> This patch assumes that, when the new mode is used, the clock driver
> sets the mode select in the MMC clock and multiplies the clock rate
> by 2:
> - MMC side:
>   - with a timing 8 bits DDR at 50MHz, the MMC driver calls
>     clk_set_rate() with a rate 50*2 = 100MHz,
> - clock side:
>   - the clock driver sets the hardware MMC clock to 100*2 = 200MHz,
>   - setting the 'mode select' of the hardware MMC clock divides the
>     rate by 2,
> - MMC side:
>   - setting the MMC clock divider register to 1 divides the rate by 2.
> So, the final rate is 50MHz.

What happens if you actually want to set it to 100MHz?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--1giRMj6yz/+FOIRq--
