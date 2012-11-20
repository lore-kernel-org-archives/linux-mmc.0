From: viresh kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 237/493] mmc: remove use of __devinit
Date: Tue, 20 Nov 2012 08:39:48 +0530
Message-ID: <CAOh2x=mjF7fuptahGhSfbaonTMSDLg3VFYxxmG=K8yCbUcezuA@mail.gmail.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
	<1353349642-3677-237-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1353349642-3677-237-git-send-email-wfp5p@virginia.edu>
Sender: linux-omap-owner@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, Ludovic Desroches <ludovic.desroches@atmel.com>, Chris Ball <cjb@laptop.org>, Manuel Lauss <manuel.lauss@gmail.com>, =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, Venkatraman S <svenkatr@ti.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Bruce Chang <brucechang@via.com.tw>, Harald Welte <HaraldWelte@viatech.com>, Pierre Ossman <pierre@ossman.eu>, linux-mmc@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, spear-devel@list.st.com
List-Id: linux-mmc@vger.kernel.org

On Mon, Nov 19, 2012 at 11:53 PM, Bill Pemberton <wfp5p@virginia.edu> w=
rote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Manuel Lauss <manuel.lauss@gmail.com>
> Cc: "Micha=C5=82 Miros=C5=82aw" <mirq-linux@rere.qmqm.pl>
> Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>
> Cc: Venkatraman S <svenkatr@ti.com>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Ian Molton <ian@mnementh.co.uk>
> Cc: Bruce Chang <brucechang@via.com.tw>
> Cc: Harald Welte <HaraldWelte@viatech.com>
> Cc: Pierre Ossman <pierre@ossman.eu>
> Cc: linux-mmc@vger.kernel.org
> Cc: uclinux-dist-devel@blackfin.uclinux.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: spear-devel@list.st.com
> ---
>  drivers/mmc/host/sdhci-spear.c     |  8 +++-----

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
