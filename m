From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3] mmc: sunxi: Handle the 'New Timing' mode
Date: Tue, 30 Aug 2016 18:26:13 +0200
Message-ID: <20160830162613.GG18605@lukather>
References: <20160813175611.79E0323C@mail.free-electrons.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JbKQpFqZXJ2T76Sg"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBJXHS27AKGQEJRJBK6Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20160813175611.79E0323C-gkR8zOBocaguO6hRkyHJVMk87cqNqjZ2@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--JbKQpFqZXJ2T76Sg
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Sat, Aug 13, 2016 at 06:41:45PM +0200, Jean-Francois Moine wrote:
> Some MMC devices as mmc2 in the A83T or mmc1 and mmc2 in the H3 have
> a 'New Timing' mode.
> When aware about this capability, and when this is possible (clock
> rate great enough), the clock driver switches the MMC clock to the
> 'new mode', meaning that the phase delays are defined in the MMC
> registers instead of in the clock registers.
> To alert the MMC driver about this switch, the clock driver returns
> the error code EPERM on calling clk_set_phase().
> 
> This patch makes the MMC driver to handle this returned code and to
> activate or not the 'New Timing' mode on the MMC side.
> 
> Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
> ---
> Some explanations:
> In the old timing, the phase delays are set in the clock only
> (that's why there is a function clk_set_phase() which is called from
> the MMC side).
> In the new timing, the delays are in the MMC register SDXC_REG_NTSR
> only.
> The new timing works only when the clock rate is greater or equal
> to 50MHz.
> 
> There are 2 flags saying that the new timing is used:
> - the bit 'mode select' in the clock register, and
> - the bit 'new timing' in the MMC register.
> Both bits must be set/reset at the same time, otherwise the device
> does not work (tested with wifi and eMMC in H3 and A83T boards).
> So, some synchronization must exist.
> 
> The previous versions was using a DT property for the MMC and a flag
> in the clock driver. This did work with a correct configuration
> on both sides, but experiment showed that it was easy to do an error.

I still believe that we will need a property, at least to identify on
which we can try the new mode, and on which clocks it's irrelevant (at
least for the A33 and A83T).

However, I also believe we should make that mode switching explicit
through a function call, instead of relying on some side effect (of
some non-upstream code).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--JbKQpFqZXJ2T76Sg--
