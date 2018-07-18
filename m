From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] mmc: sunxi: Use new timing mode for A64
 eMMC controller
Date: Wed, 18 Jul 2018 17:22:03 +0200
Message-ID: <20180718152203.svrt6wmr2vwh4rb5@flea>
References: <20180712030225.15681-1-wens@csie.org>
 <20180712071959.fi4rhgwv2iuoelbl@flea>
 <CAGb2v65rE2nQbyeiSPAyTzw-n-EQsUwQABx3nrvXTu4JogFPBQ@mail.gmail.com>
 <20180717151558.wn7v33whtljqt53w@flea>
 <CAGb2v64NRVaWpbDqiX0JX7_6uvypUpNEecPUj-sSjaK5X-hdQA@mail.gmail.com>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w5qzajkkrnntaoum"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBHFWXXNAKGQEU4QIC4Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <CAGb2v64NRVaWpbDqiX0JX7_6uvypUpNEecPUj-sSjaK5X-hdQA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--w5qzajkkrnntaoum
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Tue, Jul 17, 2018 at 11:43:03PM +0800, Chen-Yu Tsai wrote:
> On Tue, Jul 17, 2018 at 11:15 PM, Maxime Ripard
> <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org> wrote:
> > On Thu, Jul 12, 2018 at 06:17:23PM +0800, Chen-Yu Tsai wrote:
> >> On Thu, Jul 12, 2018 at 3:19 PM, Maxime Ripard
> >> <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org> wrote:
> >> > Hi,
> >> >
> >> > On Thu, Jul 12, 2018 at 11:02:25AM +0800, Chen-Yu Tsai wrote:
> >> >> The eMMC controller is also a new timing mode controller, but it doesn't
> >> >> have the timing mode switch. It does however have signal delay and
> >> >> calibration controls, typical of Allwinner MMC controllers that support
> >> >> the new timing mode.
> >> >>
> >> >> Enable the new timing mode setting for the A64 eMMC controller. This
> >> >> also enables MMC HS-DDR modes, which gives higher throughput for eMMC
> >> >> chips that support it, and can deliver such throughput.
> >> >>
> >> >> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> >> >
> >> > That doesn't look right. The datasheet explicitly mentions that this
> >> > bit doesn't apply to the eMMC controller, and the BSP is doing the same:
> >> > https://github.com/longsleep/linux-pine64/blob/lichee-dev-v3.10.65/drivers/mmc/host/sunxi-mmc-sun50iw1p1-1.c
> >> >
> >> > vs
> >> > https://github.com/longsleep/linux-pine64/blob/lichee-dev-v3.10.65/drivers/mmc/host/sunxi-mmc-sun50iw1p1-2.c
> >>
> >> You mean the bit in SDXC_REG_SD_NTSR? Yes I know that doesn't exist
> >> for the eMMC controller. I mentioned this in the commit message. It
> >> doesn't exist, and writes to it become a no-op.
> >>
> >> Would a comment, or comments, help with making this clear?
> >
> > Ah right. Maybe we should move the calibration under can_calibrate
> > though, or create another boolean for this?
> >
> > Putting it under has_new_timings while the SoC doesn't use it looks
> > very confusing.
> 
> IIRC we don't support calibration anyway. This boolean simply signals
> the usage of the new timing mode, whether by choice, or because it is
> the only mode the controller supports.

This is not the semantic I had in mind when I introduced it. The
original intent was to set the new timing bit all the time for
SoCs. If we want to change that semantic, then we also need to make
sure what this bit means is documented properly.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
--w5qzajkkrnntaoum--
