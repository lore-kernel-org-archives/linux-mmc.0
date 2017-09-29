From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] mmc: sdhci-xenon: Fix clock resource by adding an optional bus clock
Date: Fri, 29 Sep 2017 11:22:05 +0200
Message-ID: <87bmlthnb6.fsf@free-electrons.com>
References: <20170928150520.27616-1-gregory.clement@free-electrons.com>
        <20170929103943.3a6f2509@xhacker.debian>
        <87fub5hnqb.fsf@free-electrons.com>
        <20170929111550.065e7948@windsurf.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170929111550.065e7948-dFHcqWZE4nf+AlalS6MPSg@public.gmane.org> (Thomas Petazzoni's
        message of "Fri, 29 Sep 2017 11:15:50 +0200")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Jisheng Zhang <Jisheng.Zhang-Gq53QDLGkWKakBO8gow8eQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Omri Itach <omrii-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Igal Liberman <igall-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Hanna Hawa <hannah-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Hesselbarth <sebastia>
List-Id: linux-mmc@vger.kernel.org

Hi Thomas,
 
 On ven., sept. 29 2017, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> Hello,
>
> On Fri, 29 Sep 2017 11:13:00 +0200, Gregory CLEMENT wrote:
>
>> >>  - clock-names:
>> >>    Array of names corresponding to clocks property.
>> >>    The input clock for Xenon IP core should be named as "core".
>> >> +  The input clock for the AXI bus must be named as "axi".  
>> >
>> > Is "bus" more suitable?  
>> 
>> I find bus too vague.
>
> Actually no, I believe "bus" is more common. Indeed, you could have the
> same IP, attached to a different interconnect I guess.
>
>> >>  	/*
>> >>  	 * Link Xenon specific mmc_host_ops function,
>> >> @@ -491,9 +493,20 @@ static int xenon_probe(struct platform_device *pdev)
>> >>  	if (err)
>> >>  		goto free_pltfm;
>> >>  
>> >> +	priv->axi_clk = devm_clk_get(&pdev->dev, "axi");
>> >> +	if (IS_ERR(priv->axi_clk)) {
>
> -EPROBE_DEFER handling ?


See
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-September/533510.html

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
