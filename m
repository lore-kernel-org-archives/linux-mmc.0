From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH] ARM: dts: fix MMC2 regulators for Exynos5420 Arndale Octa board
Date: Wed, 8 Oct 2014 08:29:16 -0700
Message-ID: <CAD=FV=VB_eK9pSmmTBRHoQmkORweHzT-OFaMWA6haFYnQuQaUQ@mail.gmail.com>
References: <2750153.I3nVqzmXTP@amdc1032>
	<3871564.7PhRGhHd6U@wuerfel>
	<CAPDyKFowKK2UbwQ3uUmX7yzgsyFVxQ+sKb=dh+a0_T5K4agYGw@mail.gmail.com>
	<1998495.eXa2FjeVGo@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1998495.eXa2FjeVGo@wuerfel>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, "cpgs ." <cpgs@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Seung-Won Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Sonny Rao <sonnyrao@chromium.org>, Tomasz Figa <tomasz.figa@gmail.com>, SUNIL JOSHI <joshi@samsung.com>, PRASHANTH GODREHAL <prashanth.g@samsung.com>, ALIM AKHTAR <alim.akhtar@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Abhilash Kesavan <a.kesavan@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Oct 8, 2014 at 8:20 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> Why does it cause a regression though? Does this mean you are breaking
> any boot with an old DT file and a new kernel? That would be very
> bad, the driver is supposed to keep working with an existing dtb.

The old dts file specified completely the wrong regulator.  It
happened that the old code didn't really care, but when the code was
fixed to care then things broke.  If we need to keep old dts files
working then the most sensible place to do it would be in a "fixup old
broken device trees" stage somewhere in kernel boot.

-Doug
