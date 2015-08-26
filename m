From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/4] mmc: mediatek: Add online-tuning support of EMMC/SD
Date: Wed, 26 Aug 2015 16:40:16 +0800
Message-ID: <1440578416.26912.12.camel@mhfsdcap03>
References: <1439367845-5891-1-git-send-email-chaotian.jing@mediatek.com>
 <1439367845-5891-2-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFpX4Pp1+U9eNBuGd83sBeBgLU17qysAJ-2V-ABZZHYAGQ@mail.gmail.com>
 <1439812888.5627.9.camel@mhfsdcap03>
 <CAPDyKFpGk9gcLLjBnN=+BD5WP-7dZ0+XHC1bcEEGGLvLbTyKHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAPDyKFpGk9gcLLjBnN=+BD5WP-7dZ0+XHC1bcEEGGLvLbTyKHw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, James Liao <jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Wenbin Mei <sin_wenbinmei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Hongzhou Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "Joe.C" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Bin Zhang =?UTF-8?Q?=28=E7=AB=A0=E6=96=8C=29?= <bin.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Liuquan Ji <liuquan.ji-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, srv_heupstream <srv_heupstrea>
List-Id: linux-mmc@vger.kernel.org

On Tue, 2015-08-25 at 14:07 +0200, Ulf Hansson wrote:
> On 17 August 2015 at 14:01, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > Hi Ulf,
> > Thanks, please see my comment:
> > On Mon, 2015-08-17 at 13:31 +0200, Ulf Hansson wrote:
> >> On 12 August 2015 at 10:24, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> >> > Schedule a workqueue to do tuning when CRC error
> >> > Call mmc_hw_reset to re-init card when data timeout
> >>
> >> Thanks to Adrian Hunter, the mmc core already supports re-tuning for
> >> the above scenarios through the mmc_retune_*() APIs.
> >>
> >> SDHCI driver has already adopted to use that feature, you should do
> >> that for the mtk-sd driver as well.
> >>
> >> Kind regards
> >> Uffe
> >>
> > I also noticed that the mmc core already supports re-tuning, but it is
> > not suitable for our host.
> > For EMMC, the CMD21 only support HS200/HS400 mode, for SD card, CMD19
> > only support SDR50/SDR104 mode, but in our host, even 50Mhz clock
> > frequency may also occur CRC error, Cannot find a parameter that can
> > cover all SD cards which running at 50Mhz, even 25Mhz, will occur CRC
> > error for stress test, DDR50 mode is worse.
> 
> I don't follow. You may run for example HS200 in lower speed, nothing
> will prevent tuning and re-tuning from happen for these scenarios.
> 
> Or you are talking about other speed modes than HS200/400 and
> SDR50/104? If so, which speed modes are these?
> 
Yes, I am talking about other speed modes.
For SD card, the speed mode is High Speed, for EMMC, the speed may be
High Speed or DDR mode.
If CRC error occurs at these speed modes, the MMC core layer will never
handler it. even propagate the -EILSEQ towards to the mmc core, it will
not start mmc_retune.
> BTW, there are currently a patch being discussed which is about adding
> tuning for DDR mode. Please have look.
> http://www.spinics.net/lists/arm-kernel/msg438434.html
> 
> Regarding re-tuning on CRC errors, that's already supported by the mmc
> core. More precisely when a host driver returns -EILSEQ for a request.
> 
> > By the way,there are too many tune parameters need try for response,
> > read data, write crc status CRC error, these parameters are
> > multidimensional, it is hard to find a best parameter, and, try
> > thousands of parameters will take long time.
> 
> As I see, it's your responsibility from the host driver to propagate
> the proper error code towards the mmc core. If you encounter an error
> that you want to trigger a retune, just return -EILSEQ.
> 
> Moreover, if you see a need to extend the tuning/re-tuning support in
> the mmc core to suit your need - I am definitely open to look into
> that. More importantly, I don't want to see host specific hacks trying
> to deal with this.
> 
In addition, the CMD21 is only valid for HS200 mode, do not support
HS400, So that there is no chance to tune the HS400 read/write data with
current mmc core layer codes.
As you see, in our platform, tune of HS200 and HS400 is different, but
if use the CMD21, it will never work at HS400 mode, even with
"prepare_hs400_tuning", but it prepare what ? what we need is that
running at HS400 mode and tune the read/write parameters, but not HS200,
because for data Rx path, the tune result of HS200 is meaningless for
HS400.
> Kind regards
> Uffe
