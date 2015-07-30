From: Holger Schurig <holgerschurig-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 0/6] mmc: imx: a few fixes and new feature
Date: Thu, 30 Jul 2015 11:44:52 +0200
Message-ID: <CAOpc7mHjUZeucxvDK6WxKX-tUFTtvsAT72h7BaOzqCwiQEK+Qw@mail.gmail.com>
References: <1438160637-28061-1-git-send-email-haibo.chen@freescale.com>
	<20150729091027.GC16916@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150729091027.GC16916-KgLukfWpBlCctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, aisheng.dong-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, johan.derycke-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Can you also fix the driver to NOT use mdelay(1) while in spinlock irqsafe?

A driver with such a design should have gotten a NAK in the first place ...
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
