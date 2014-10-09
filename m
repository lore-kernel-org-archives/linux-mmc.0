From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: dts: fix MMC2 regulators for Exynos5420 Arndale Octa board
Date: Thu, 09 Oct 2014 13:41:07 +0200
Message-ID: <2467727.SEhKNo5MJx@wuerfel>
References: <2750153.I3nVqzmXTP@amdc1032> <1819182.VPTrtc9d2P@wuerfel> <CAPDyKFoPBep287uAVDQWSXdFz-aoV4VmV7xgP_PEZ-c1q9Oz0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoPBep287uAVDQWSXdFz-aoV4VmV7xgP_PEZ-c1q9Oz0w@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, ALIM AKHTAR <alim.akhtar@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Seung-Won Jeon <tgih.jun@samsung.com>, PRASHANTH GODREHAL <prashanth.g@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Doug Anderson <dianders@google.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, "cpgs ." <cpgs@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, SUNIL JOSHI <joshi@samsung.com>, Chris Ball <cjb@laptop.org>, Sonny Rao <sonnyrao@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>
List-Id: linux-mmc@vger.kernel.org

On Thursday 09 October 2014 10:46:59 Ulf Hansson wrote:
> On 8 October 2014 20:28, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 08 October 2014 08:29:16 Doug Anderson wrote:
> >>
> >> On Wed, Oct 8, 2014 at 8:20 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > Why does it cause a regression though? Does this mean you are breaking
> >> > any boot with an old DT file and a new kernel? That would be very
> >> > bad, the driver is supposed to keep working with an existing dtb.
> >>
> >> The old dts file specified completely the wrong regulator.  It
> >> happened that the old code didn't really care, but when the code was
> >> fixed to care then things broke.  If we need to keep old dts files
> >> working then the most sensible place to do it would be in a "fixup old
> >> broken device trees" stage somewhere in kernel boot.
> >
> > Ok, got it. I guess it's better to apply this one first then.
> >
> >         Arnd
> 
> Thanks for your comments Arnd! I have applied this once to my mmc tree
> now. Please tell me soon if you want to carry this through arm-soc
> instead, thus I can drop it.

No, please take it yourself, Linus has already taken the arm-soc pull
requests.

	Arnd
