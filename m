From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 5/10] dt: bindings: Add bindings for Marvell Xenon SD Host Controller
Date: Thu, 24 Nov 2016 11:04:36 +0100
Message-ID: <8756050.yoKoJPCyHz@wuerfel>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com> <8737ihmctr.fsf@free-electrons.com> <20161124104858.3604c11d@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161124104858.3604c11d-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jimmy Xu <zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Liuliu Zhao <zhaoliul-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Peng Zhu <zhupeng-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Doug Jones <dougj-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Wei(SOCP) Liu" <liuw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Xueping Liu <xpliu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Hilbert Zhang <zzhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shiwu Zhang <zhangshw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yu Cao <yucao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Sebastian
List-Id: linux-mmc@vger.kernel.org

On Thursday, November 24, 2016 10:48:58 AM CET Thomas Petazzoni wrote:
> Hello,
> 
> On Thu, 24 Nov 2016 10:44:48 +0100, Gregory CLEMENT wrote:
> 
> > "A single Xenon IP can support multiple slots.
> > Each slot acts as an independent SDHC. It owns independent resources, such
> > as register sets clock and PHY.
> > Each slot should have an independent device tree node."
> 
> I think this wording is still very confusing, and continues to cause
> confusion.
> 
> We should just state that each Xenon controller supports a single slot,
> and that's it.
> 
> The text still says "a single Xenon IP can support multiple slots",
> which continues to cause confusion.

Agreed. Ideally we'd find out why exactly the slot number must
be used for accessing some of the registers to have a better
explanation to put in there, aside from stating that only one
slot is supported but the number must be set.

Could it be that this is some form of pinmuxing, i.e. that each
controller could in theory be used for any of the slots but you
have to pick one of them?

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
