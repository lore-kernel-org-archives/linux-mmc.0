From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] mmc: mmc: do not use CMD13 to get status after speed
 mode switch
Date: Fri, 13 May 2016 10:42:23 +0800
Message-ID: <1463107343.26133.6.camel@mhfsdcap03>
References: <1462344872-6448-1-git-send-email-chaotian.jing@mediatek.com>
 <5732E43E.8070800@intel.com> <1463036431.11653.3.camel@mhfsdcap03>
 <57345B14.7030308@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <57345B14.7030308-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Thu, 2016-05-12 at 13:29 +0300, Adrian Hunter wrote:
> On 12/05/16 10:00, Chaotian Jing wrote:
> > On Wed, 2016-05-11 at 10:50 +0300, Adrian Hunter wrote:
> >> On 04/05/16 09:54, Chaotian Jing wrote:
> >>> Per JEDEC spec, it is not recommended to use CMD13 to get card status
> >>> after speed mode switch. below are two reason about this:
> >>> 1. CMD13 cannot be guaranteed due to the asynchronous operation.
> >>> Therefore it is not recommended to use CMD13 to check busy completion
> >>> of the timing change indication.
> >>> 2. After switch to HS200, CMD13 will get response of 0x800, and even the
> >>> busy signal gets de-asserted, the response of CMD13 is aslo 0x800.
> >>>
> >>> this patch drops CMD13 when doing speed mode switch, if host do not
> >>> support MMC_CAP_WAIT_WHILE_BUSY and there is no ops->card_busy(),
> >>> then the only way is to wait a fixed timeout.
> >>
> >> This looks like it should be 3 patches:
> >> 	1. Change __mmc_switch
> >> 	2. Change HS200 and HS400 selection
> >> 	3. Change HS selection
> >>
> >> However there is another problem: card_busy is not the same as busy signal -
> >> see below.  So that needs to be sorted out first.
> >>
> > We should make that card_busy() is the same with busy signal asserted.
> > as you know, if card was not in busy state, all data pins should be high
> > level as it is pull-up by default. so that's no conflict to check card
> > busy signal by DAT0 or DAT0 ~ DAT3.
> 
> Potentially SDIO uses DAT1 for card interrupt, so that is a conflict right
> there.
> 
> Also SDHCI does it backwards (don't ask me why) and considers 0000 to be
> busy, so there's another conflict.
> 
> Some of the language in the SD and SDHCI specifications seems to indicate
> that checking all 4 DAT lines during voltage switch is optional i.e. only 1
> of the lines must be checked.  If that is true then we could change all the
> drivers over to check just DAT0, and expect that to work for both busy
> signalling and SD voltage switch checks.
> 
> So it seems to me card_busy still needs to be sorted out first.

One thing must point out is that the __mmc_switch() is only for MMC
card. SD/SDIO will never use this interface.
by the way, Per JEDEC SD3.0 spec, below is the quote from spec:
"Completion of voltage switch sequence is checked by high level of
DAT[3:0]. Any bit of DAT[3:0] can be checked depends on ability of the
host."
So that the implement of ops->card_busy() can be changed from check
DAT[3:0] to only check DAT[0].

In fact, for SD/SDIO voltage switch, if switch success, all DAT pins are
high level and if switch failed, all data pins are low level.
> 
