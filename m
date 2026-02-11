Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB8633E355;
	Wed, 11 Feb 2026 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770826676; cv=none; b=RmzcASVLdmEz9LtV5G9zpZQgCg80AxaKORtn519jFtwZueG7B58U/ZeKrlhh6bZ/idhUeIdzvm4KgsyqkDFYax7YHt5aHJkRWO5JAfZBIS27WOcfcXl8w4ZHOxjUscGEvNVvH0nLLAznPouAvsRnExfouprgK+GMggV1M5d874g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770826676; c=relaxed/simple;
	bh=18o8X62YvanS093uMPggd8PbG5ryv2EK9QMou/okpbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5OF47NCf9UdfvpQAXfnxSgFWQQ7jZIsa9r0ColR0DOEU5tuFDUZ6Xby75JlGQvxwe+fjijsinR/2M9nD/FjPHPGPy6wBT/aSgM1MuARdfYGBNQpqveT7XRXPB5pue4N8TLvIp4i0Gd7b+x/4yjQQsBoxF3ZJRFJGBu7iNxyG3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MB8We5Y6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MB8We5Y6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9726EC19423;
	Wed, 11 Feb 2026 16:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770826676;
	bh=18o8X62YvanS093uMPggd8PbG5ryv2EK9QMou/okpbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MB8We5Y6o1kt/kCfSmacIh7m1Ca7XBsgDXkhhPkmAn6zH7gvm7qfVzEB9CqjX7CW+
	 TSQPKpc9AhrWmh4MovqTvW+ui/DP+wzpZKcBXoAyxnCnfSQEVM2ZTluI9ttayJ90TV
	 iLuhZoFxUqqCjLJfh93CL+QhCsf08z6sklw8Y9p+m5ACFVWNbx4YVQx3VZJamvWWPM
	 IkT/1ozSBiPxqwRZ8vj+dJ0lmddC38e83LK3uhrQLPpYgPwUaV8Ln9s53E8+KXi9E+
	 bzta94dKj91dQacKCr1wCuL303N2uVpxXEM7cONqPPKtRHrNs1prTSOiPBTbR9T2ox
	 2vVOee6RL9gzg==
Date: Wed, 11 Feb 2026 21:47:52 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Vladimir Oltean <olteanv@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	linux-phy@lists.infradead.org, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] phy: renesas: rcar-gen3-usb2: Drop local
 devm_mux_state_get_optional()
Message-ID: <aYyrsPTH1923jV7y@vaman>
References: <67c8c4f9bf9f09fd0c13daedef27b82ff389ddfb.1770720452.git.geert+renesas@glider.be>
 <CAPDyKFpY2X8hephSfHq7rj_DaKX76ZSkWSCYXrGTEBUFHkvOzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFpY2X8hephSfHq7rj_DaKX76ZSkWSCYXrGTEBUFHkvOzg@mail.gmail.com>

On 10-02-26, 14:34, Ulf Hansson wrote:
> On Tue, 10 Feb 2026 at 11:53, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> >
> > Now the mux core provides devm_mux_state_get_optional():
> >
> >     drivers/phy/renesas/phy-rcar-gen3-usb2.c:944:1: error: static declaration of ‘devm_mux_state_get_optional’ follows non-static
> >      declaration
> >       944 | devm_mux_state_get_optional(struct device *dev, const char *mux_name)
> >           | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     In file included from drivers/phy/renesas/phy-rcar-gen3-usb2.c:20:
> >     include/linux/mux/consumer.h:64:19: note: previous declaration of ‘devm_mux_state_get_optional’ with type ‘struct mux_state *(struct device *, const char *)’
> >        64 | struct mux_state *devm_mux_state_get_optional(struct device *dev, const char *mux_name);
> >           |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Fix this by dropping the temporary local wrapper.
> >
> > Fixes: ad314348ceb4fe1f ("mux: Add helper functions for getting optional and selected mux-state")
> > Fixes: 8bb92fd7a0407792 ("phy: renesas: rcar-gen3-usb2: Use mux-state for phyrst management")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Thanks Geert for helping out!
> 
> > ---
> >   - ad314348ceb4fe1f is in mmc/next, and a PR has already been sent
> >     https://lore.kernel.org/20260209133441.556464-1-ulf.hansson@linaro.org
> >   - 8bb92fd7a0407792 is in phy/next
> 
> Vinod, do you want to pick up the $subject patch as a fix for 7.0-rc1
> or do you prefer me to handle it?

Should I drop the 8bb92fd7a0407792 and it makes things easier for
everyone and then we can pick fixed commit for 7.1 cycle..

Does that work for everyone. I was about to send PR, will hold off for a
bit.

Thanks
-- 
~Vinod
