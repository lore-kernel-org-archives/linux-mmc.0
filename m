Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813B0138C;
	Sat, 25 May 2024 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716620418; cv=none; b=Bek/ic0A/teTvsHdliIlTDycV+fwBjHArGjAteGxFyb+0ENVXWW1jwSxtWSdZcdQNiMItMEGFC8Uuo11j27ratL4t0NfloNlTD4CHX3MeAMADkSxkRG4eFmt1qhPBGyZu9ToBSBKSei2rLH83QWbTyZiIMb9YY2Iv86uN8/q4Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716620418; c=relaxed/simple;
	bh=zZ4Z9htX4zC9singJrmMJUDyjOTFxoOpSU+SUW4zRMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CPkLYRtzqYBrKP6UmIeBYJhFifA4QaIQGp+GsImIastZqUx0ReimMHo3FhcEx1+C6nFgjTQ5jcHYBHMV3EFtYswBHFJgcNg8YPCxdzurxJni+I5cGT7ctwO5hqEkIsD/RfO11nhw3jQ7D6XXB9tNUAphON146jqMrT/FvMAlWWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=S+3HKbea; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="S+3HKbea"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1716620396; x=1717225196; i=wahrenst@gmx.net;
	bh=nIqWSc3ZaklDz+cAaEm24M8PzXmEYNEtLVLtIyG2WCE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=S+3HKbeaIDQM2KvndCVAk0XoUyNd65tKLv7tGEoLbS+SJGRU/zsRnlZSNxe2rDxN
	 ZFQi+miEt8NqBrnEkxff4vmbJ5mXD3dQSjZchBjtX5eC05Z3NWfYtASS9aXi8l98q
	 GImt5IcerQ6MRKmVQaQjhF2Hs0jFo4N7Kn3RqdFhfgmugSabd5LvkVszuek5TJagN
	 eSCytHCAW2QZJb1quNnr/uWpdth1ETXCN942LAekH3G3aq9kM4mosBKFzLDj5TwCB
	 k9mZ9eilOq29ZylRjjrcXPsdT8DvpmcxqhZL0hn8732qrSmSF9dI1P59P8RDmHjXV
	 PADEi2i77lXVY59Uog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.126] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N49h5-1saqyL2YYj-0104rZ; Sat, 25
 May 2024 08:59:56 +0200
Message-ID: <9ef2d8c2-621a-4e05-8afa-5d2b99a36caa@gmx.net>
Date: Sat, 25 May 2024 08:59:54 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] mmc: sdhci-brcmstb: Add BCM2712 support
To: Andrea della Porta <andrea.porta@suse.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Marc Zyngier <maz@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <cover.1716277695.git.andrea.porta@suse.com>
 <c413737f538d9bd403c30104a83a7fbb1ea7461d.1716277695.git.andrea.porta@suse.com>
 <f27aaf92-8109-4cad-94ba-6f72cd9bdabf@gmx.net> <ZlF5dQbNpZ921e66@apocalypse>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <ZlF5dQbNpZ921e66@apocalypse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5xZGo4wnACFwuy26GkUhX2rvxLsKoEsJ77Ch9n51a7NFLRACtOx
 NQS5WtbostbzDR/Vzbn2ipQdqOPoTHVz1PpkS7khxrzhA+If8HwE/WRtMBuqs7mt4YJ+DRA
 RQeSCVkS6o4uiXbtvNyBjS9zzUSUEg/rUqd/Xivti9NQLNk+hyfEuNH07C7+Klxdi9GaBHy
 OcP4KGd7j9y+JMhY8cs2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+4jXvxIqCvo=;pE6vlU6J684NpgZjySC/5Pf3iDv
 sfO9DFL1njcIttJ7k51Ez0c8Kn22XMgWAM0CvIDk/mG8mZl9GeDDFBkcPM9GSgLqqjgcNz7ev
 3AVryZC6zgOszxVF2UlZrdD/UBH2YC+bgOHP9adxSm3SzWdCt33ejHJUNZnijTPzy02HzGjVt
 WrNylzQ6yspRMO+/J9H+8404JpMMDejME/YqeqepAH6Hs8FR9lW5xxoK33fnK3kqVnqeRTC4+
 2EximiyCf/S02sshcqxyRj7oylxMDUaPPxKxxqycZLEwH5lhYcsUDqu6nIifRpAc9neVOFEYi
 9QVTcpdxK0LECjxVH6mbtXmUt/3RdVIzkqbLkHNXqvE1zPwhEKezLH2BUkgWOGkHpM4RggdDf
 aLGe6zUavCxIR2+MRUbG3cjlch15QI9zNrU39in4PKrugydFU10RPWEf8bZSPqsHUtb9Fx6m6
 //V+0jFCVf9jrQA3k8iyc42nkGww3Whb8GKSlXJapGebpWLFuM913TPlkrk1X5XopwfQizZeN
 lw+h4+Lg2WpMtPyKObjoCpGnxqZscwwtsjdZmWs/nj8rTh9GeJeVo6UHZlThZ0T856ygW52+u
 A3ieP7q9xfJ6n6nehB3Ld+BEjREMlZKQQV6sNPCM47nKg38l+FIkbeyzUx9Qpeh7QJ6GlzNY5
 AtxKRuTLA/JMb7IsFf0fUoM2SBEz5YBaCVg6zjNhtKErOtKmNjVQy3gozXsYt3LiFFv+95I69
 LJMrs4RUXkQiP8fuHlaPgjZXI5bRKy2P3Cx7IloYdTPkwGrDvE6o8KXZcBPUaFow+KEY1B33c
 TJ1WP6blC/hp8MDpCn/dMPvbVbqQDrqtgYrzHc1gILufc=

Hi Andrea,

Am 25.05.24 um 07:39 schrieb Andrea della Porta:
> On 14:26 Tue 21 May     , Stefan Wahren wrote:
>> Hi Andrea,
>>
>> Am 21.05.24 um 10:35 schrieb Andrea della Porta:
>>> Broadcom BCM2712 SoC has an SDHCI card controller using the SDIO CFG
>>> register block present on other STB chips. Add support for BCM2712
>>> SD capabilities of this chipset.
>>> The silicon is SD Express capable but this driver port does not curren=
tly
>>> include that feature yet.
>>> Based on downstream driver by raspberry foundation maintained kernel.
>>>
>>> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
>>> ---
>>>    drivers/mmc/host/sdhci-brcmstb.c | 65 +++++++++++++++++++++++++++++=
+++
>>>    1 file changed, 65 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci=
-brcmstb.c
>>> index 9053526fa212..b349262da36e 100644
>>> --- a/drivers/mmc/host/sdhci-brcmstb.c
>>> +++ b/drivers/mmc/host/sdhci-brcmstb.c
>>> @@ -30,6 +30,21 @@
>>>
>>>    #define SDHCI_ARASAN_CQE_BASE_ADDR		0x200
>>>
>>> +#define SDIO_CFG_CQ_CAPABILITY			0x4c
>>> +#define SDIO_CFG_CQ_CAPABILITY_FMUL		GENMASK(13, 12)
>>> +
>>> +#define SDIO_CFG_CTRL				0x0
>>> +#define SDIO_CFG_CTRL_SDCD_N_TEST_EN		BIT(31)
>>> +#define SDIO_CFG_CTRL_SDCD_N_TEST_LEV		BIT(30)
>>> +
>>> +#define SDIO_CFG_MAX_50MHZ_MODE			0x1ac
>>> +#define SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE	BIT(31)
>>> +#define SDIO_CFG_MAX_50MHZ_MODE_ENABLE		BIT(0)
>>> +
>>> +#define MMC_CAP_HSE_MASK	(MMC_CAP2_HSX00_1_2V | MMC_CAP2_HSX00_1_8V)
>>> +/* Select all SD UHS type I SDR speed above 50MB/s */
>>> +#define MMC_CAP_UHS_I_SDR_MASK	(MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR10=
4)
>>> +
>>>    struct sdhci_brcmstb_priv {
>>>    	void __iomem *cfg_regs;
>>>    	unsigned int flags;
>>> @@ -38,6 +53,7 @@ struct sdhci_brcmstb_priv {
>>>    };
>>>
>>>    struct brcmstb_match_priv {
>>> +	void (*cfginit)(struct sdhci_host *host);
>>>    	void (*hs400es)(struct mmc_host *mmc, struct mmc_ios *ios);
>>>    	struct sdhci_ops *ops;
>>>    	const unsigned int flags;
>>> @@ -168,6 +184,38 @@ static void sdhci_brcmstb_set_uhs_signaling(struc=
t sdhci_host *host,
>>>    	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>>>    }
>>>
>>> +static void sdhci_brcmstb_cfginit_2712(struct sdhci_host *host)
>>> +{
>>> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
>>> +	struct sdhci_brcmstb_priv *brcmstb_priv =3D sdhci_pltfm_priv(pltfm_h=
ost);
>>> +	u32 reg, base_clk_mhz;
>>> +
>>> +	/*
>>> +	 * If we support a speed that requires tuning,
>>> +	 * then select the delay line PHY as the clock source.
>>> +	 */
>>> +	if ((host->mmc->caps & MMC_CAP_UHS_I_SDR_MASK) || (host->mmc->caps2 =
& MMC_CAP_HSE_MASK)) {
>>> +		reg =3D readl(brcmstb_priv->cfg_regs + SDIO_CFG_MAX_50MHZ_MODE);
>>> +		reg &=3D ~SDIO_CFG_MAX_50MHZ_MODE_ENABLE;
>>> +		reg |=3D SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE;
>>> +		writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_MAX_50MHZ_MODE);
>>> +	}
>>> +
>>> +	if ((host->mmc->caps & MMC_CAP_NONREMOVABLE) ||
>>> +	    (host->mmc->caps & MMC_CAP_NEEDS_POLL)) {
>>> +		/* Force presence */
>>> +		reg =3D readl(brcmstb_priv->cfg_regs + SDIO_CFG_CTRL);
>>> +		reg &=3D ~SDIO_CFG_CTRL_SDCD_N_TEST_LEV;
>>> +		reg |=3D SDIO_CFG_CTRL_SDCD_N_TEST_EN;
>>> +		writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_CTRL);
>>> +	}
>>> +
>>> +	/* Guesstimate the timer frequency (controller base clock) */
>>> +	base_clk_mhz =3D max_t(u32, clk_get_rate(pltfm_host->clk) / (1000 * =
1000), 1);
>>> +	reg =3D SDIO_CFG_CQ_CAPABILITY_FMUL | base_clk_mhz;
>>> +	writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_CQ_CAPABILITY);
>> This part assumes the clock isn't changed afterwards, see below ...
>>> +}
>>> +
>>>    static void sdhci_brcmstb_dumpregs(struct mmc_host *mmc)
>>>    {
>>>    	sdhci_dumpregs(mmc_priv(mmc));
>>> @@ -200,6 +248,14 @@ static struct sdhci_ops sdhci_brcmstb_ops =3D {
>>>    	.set_uhs_signaling =3D sdhci_set_uhs_signaling,
>>>    };
>>>
>>> +static struct sdhci_ops sdhci_brcmstb_ops_2712 =3D {
>>> +	.set_clock =3D sdhci_set_clock,
>>> +	.set_power =3D sdhci_set_power_and_bus_voltage,
>>> +	.set_bus_width =3D sdhci_set_bus_width,
>>> +	.reset =3D sdhci_reset,
>>> +	.set_uhs_signaling =3D sdhci_set_uhs_signaling,
>>> +};
>>> +
>>>    static struct sdhci_ops sdhci_brcmstb_ops_7216 =3D {
>>>    	.set_clock =3D sdhci_brcmstb_set_clock,
>>>    	.set_bus_width =3D sdhci_set_bus_width,
>>> @@ -214,6 +270,11 @@ static struct sdhci_ops sdhci_brcmstb_ops_74165b0=
 =3D {
>>>    	.set_uhs_signaling =3D sdhci_brcmstb_set_uhs_signaling,
>>>    };
>>>
>>> +static const struct brcmstb_match_priv match_priv_2712 =3D {
>>> +	.cfginit =3D sdhci_brcmstb_cfginit_2712,
>>> +	.ops =3D &sdhci_brcmstb_ops_2712,
>>> +};
>>> +
>>>    static struct brcmstb_match_priv match_priv_7425 =3D {
>>>    	.flags =3D BRCMSTB_MATCH_FLAGS_NO_64BIT |
>>>    	BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
>>> @@ -238,6 +299,7 @@ static struct brcmstb_match_priv match_priv_74165b=
0 =3D {
>>>    };
>>>
>>>    static const struct of_device_id __maybe_unused sdhci_brcm_of_match=
[] =3D {
>>> +	{ .compatible =3D "brcm,bcm2712-sdhci", .data =3D &match_priv_2712 }=
,
>>>    	{ .compatible =3D "brcm,bcm7425-sdhci", .data =3D &match_priv_7425=
 },
>>>    	{ .compatible =3D "brcm,bcm7445-sdhci", .data =3D &match_priv_7445=
 },
>>>    	{ .compatible =3D "brcm,bcm7216-sdhci", .data =3D &match_priv_7216=
 },
>>> @@ -370,6 +432,9 @@ static int sdhci_brcmstb_probe(struct platform_dev=
ice *pdev)
>>>    	    (host->mmc->caps2 & MMC_CAP2_HS400_ES))
>>>    		host->mmc_host_ops.hs400_enhanced_strobe =3D match_priv->hs400es;
>>>
>>> +	if (match_priv->cfginit)
>>> +		match_priv->cfginit(host);
>>> +
>> I'm not sure this is the right place to call cfginit.
>> sdhci_brcmstb_cfginit_2712 retrives the current controller base clock,
>> but at the end of=C2=A0 sdhci_brcmstb_probe this clock frequency could =
be
>> adjusted by the device property "clock-frequency". So i'm not sure this
>> is intended.
> I've tried to interpret the meaning of those two clocks since unfortunat=
ely I don't
> own the datasheet for any of the platforms involved, so please take the =
following
> as the result of my own (possibly wrong) intuition and (mostly wild) gue=
ssing.
>
> The main clock is 'sw_sdio' while 'sdio_freq' is optional and the latter=
 seems to be
> orthogonal to the former.
> While sw_sdio is mostly used for SD storage card, sdio_freq seems more r=
elated to
> SDIO family of cards (wifi, gps, camera, etc) for which you could specif=
y a particular
> (and higher) base frequency.
> Unfortunately I wasn't able to find any reference to sdio_freq in curren=
t devicetree
> so it's probably only specific to custom appliances: to be honest I'm no=
t even sure
> that BCM2712 is supporting that improved clock source.  Also, from the f=
ollowing lines
> at the end of cfginit function:
>
> /* Guesstimate the timer frequency (controller base clock) */
> base_clk_mhz =3D max_t(u32, clk_get_rate(pltfm_host->clk) / (1000 * 1000=
), 1);
> reg =3D SDIO_CFG_CQ_CAPABILITY_FMUL | base_clk_mhz;
> writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_CQ_CAPABILITY);
>
> judging from the name of SDIO_CFG_CQ_CAPABILITY register, I'd guess that=
 it relates
> to some Command Queue (timeout?) setting so it's probably only important=
 if CQE is
> enabled specifying 'supports-cqe' property, which is not in current devi=
cetree (nor
> in  downstream one). If this is the case it's mostly a performance impro=
vement, and
> as such something that we are not necessarily interested in right now si=
nce this
> patchset adds just minimal boot support. I would then drop those lines, =
as we could
> just reintroduce them if they need be once we have a better understandin=
g of that
> specific register and/if the cqe support will be enabled. As a matter of=
 fact those
> lines are not working as expected in any case since pltfm_host->clk is s=
et at the
> very end of sdhci_brcmstb_probe() while the cfginit function is invoked =
much earlier.
> The result is that right now the value set ito SDIO_CFG_CQ_CAPABILITY re=
gister is always
> equal to 1MHz. Further testing reveals that it is indeed working fine ev=
en with those
> lines dropped, so I would deem that code as unnecessary for this early p=
atchset.
> Is it a viable solution?
I don't have any knowledge about this hardware, so my opinion based on
your good investigations. But i would be fine with this.

Just to make it clear, this works with and without U-Boot in the bootchain=
?

Thanks
>
> Many thanks,
> Andrea
>
>>>    	/*
>>>    	 * Supply the existing CAPS, but clear the UHS modes. This
>>>    	 * will allow these modes to be specified by device tree

