From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH v3 6/8] ARM: dts: add pbias-supply
Date: Thu, 21 Nov 2013 09:03:51 -0800
Message-ID: <20131121170351.GN10317@atomide.com>
References: <20130613174554.GB1403@sirena.org.uk>
 <1385043627-30439-1-git-send-email-balajitk@ti.com>
 <1385043627-30439-7-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:27342 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011Ab3KURDz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Nov 2013 12:03:55 -0500
Content-Disposition: inline
In-Reply-To: <1385043627-30439-7-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, broonie@kernel.org

* Balaji T K <balajitk@ti.com> [131121 06:21]:
> Add pbias-supply to mmc1/sd card.
...

> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -261,6 +261,7 @@
>  &mmc1 {
>  	status = "okay";
>  	vmmc-supply = <&ldo1_reg>;
> +	pbias-supply = <&pbias_regulator>;
>  	bus-width = <4>;
>  };

You may not need to patch this in at all. I think the PBIAS is there
only for the first slot and it's hardwired so it's always there. If
that's the case, then you can just always request it. Or use the
compatible flag if needed.

Regards,

Tony
