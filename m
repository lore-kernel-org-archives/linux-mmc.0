From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 3/7] mmc: dw_mmc: add device tree support
Date: Thu, 17 May 2012 21:09:21 +0530
Message-ID: <CAJuYYwTf=+Nkw2Ox9MYLybovSH8dNttYQzV4-Gg2xvZnVffZXw@mail.gmail.com>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
	<1335935266-25289-4-git-send-email-thomas.abraham@linaro.org>
	<Pine.LNX.4.64.1205040047280.18111@axis700.grange>
	<CAJuYYwQj7gzZ9piJAJLcf7SiyJnQ6nZ63-X9ieQ-FCj6TNhQPQ@mail.gmail.com>
	<Pine.LNX.4.64.1205122117340.11826@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:42377 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364Ab2EQPjW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 May 2012 11:39:22 -0400
Received: by vbbff1 with SMTP id ff1so1739095vbb.19
        for <linux-mmc@vger.kernel.org>; Thu, 17 May 2012 08:39:21 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1205122117340.11826@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, patches@linaro.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, kgene.kim@samsung.com, cjb@laptop.org, linux-arm-kernel@lists.infradead.org

On 13 May 2012 01:01, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wro=
te:
> Sure. I think, my patch, that I mentioned above, shall be dropped, at
> least in its present form. But if at least in principle we do want to=
 have
> a common MMC OF parser for common bindings, some code from your patch
> would become redundant, I think. BTW, isn't this
>
> + =A0 =A0 =A0 gpio =3D of_get_named_gpio(np, "wp_gpios", 0);
>
> a typo? Shouldn't it be "wp-gpios" instead?

Yes, it is a typo. Thanks for your review. This is fixed now.

Regards,
Thomas.
