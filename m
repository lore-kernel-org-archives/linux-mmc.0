From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: Re: [PATCH] mmc: core: Do not hold re-tuning during CMD6 commands
Date: Mon, 27 Mar 2017 09:35:00 +0800
Message-ID: <1490578500.22814.31.camel@mhfsdcap03>
References: <1490336341-22292-1-git-send-email-chaotian.jing@mediatek.com>
         <1490336341-22292-2-git-send-email-chaotian.jing@mediatek.com>
         <13a83728-0031-5683-c371-4b517df32299@intel.com>
         <1490344369.22814.10.camel@mhfsdcap03>
         <03d54000-9ced-1b31-df80-d254f02433db@intel.com>
         <1490348427.22814.19.camel@mhfsdcap03>
         <CAPDyKFoo5sJ2XtjyiW1DLjhFdJySbDK7+N05vrKpeiZsp25qrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([218.249.47.111]:46765 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751510AbdC0BfH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Mar 2017 21:35:07 -0400
In-Reply-To: <CAPDyKFoo5sJ2XtjyiW1DLjhFdJySbDK7+N05vrKpeiZsp25qrA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Matthias Brugger <matthias.bgg@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, srv_heupstream <srv_heupstream@mediatek.com>

On Fri, 2017-03-24 at 11:49 +0100, Ulf Hansson wrote:
> On 24 March 2017 at 10:40, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> > On Fri, 2017-03-24 at 11:19 +0200, Adrian Hunter wrote:
> >> On 24/03/17 10:32, Chaotian Jing wrote:
> >> > On Fri, 2017-03-24 at 09:52 +0200, Adrian Hunter wrote:
> >> >> On 24/03/17 08:19, Chaotian Jing wrote:
> >> >>> this patch is refine for 'commit c6dbab9cb58f ("mmc: core: Hold re-tuning
> >> >>> during switch commands")'
> >> >>> Since it has 3 retries at max for CMD6, if the first CMD6 got CRC error,
> >> >>> then should do re-tune before the next CMD6 was sent.
> >> >>>
> >> >>> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> >> >>> ---
> >> >>>  drivers/mmc/core/mmc_ops.c |    3 +--
> >> >>>  1 file changed, 1 insertion(+), 2 deletions(-)
> >> >>>
> >> >>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> >> >>> index fe80f26..6931927 100644
> >> >>> --- a/drivers/mmc/core/mmc_ops.c
> >> >>> +++ b/drivers/mmc/core/mmc_ops.c
> >> >>> @@ -534,8 +534,6 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
> >> >>>   bool use_r1b_resp = use_busy_signal;
> >> >>>   unsigned char old_timing = host->ios.timing;
> >> >>>
> >> >>> - mmc_retune_hold(host);
> >> >>> -
> >> >>>   /*
> >> >>>    * If the cmd timeout and the max_busy_timeout of the host are both
> >> >>>    * specified, let's validate them. A failure means we need to prevent
> >> >>> @@ -567,6 +565,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
> >> >>>           cmd.sanitize_busy = true;
> >> >>>
> >> >>>   err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
> >> >>> + mmc_retune_hold(host);
> >> >>
> >> >> That is not how mmc_retune_hold() works, you need mmc_retune_hold_now() as
> >> >> it is here:
> >> >>
> >> >>    https://marc.info/?l=linux-mmc&m=148940903816582
> >> >>
> >> >> But using "retries" with commands that have busy-waiting on the data line
> >> >> doesn't make much sense anyway.  Particularly with CRC errors, I would
> >> >> expect the card is actually busily doing the switch and we need only to wait
> >> >> for it.  The same can be true for timeout errors.  For some CMD6 we might
> >> >> need to send CMD12 if the card is busy after an error.  I would prefer an
> >> >> explicit attempt at recovery from CMD6 errors.
> >> >>
> >> >
> >> > It's the host driver's responsibility to ensure card is not in busy
> >> > state before issue the next R1B command, or the MMC core layer needs do
> >> > extra check/waiting before issue a R1B command.
> >>
> >> Better to deal with cards stuck in busy from the places where busy-waiting
> >> is expected.
> >>
> > Yes, if a R1B command got response CRC error, we can do busy-waiting in
> > the error hander funtion(mmc_wait_for_req_done())
> 
> That would introduce too big changes and I am sure it will cause/hide
> other problems.
> 
> If there is a problem in __mmc_switch(), let's try to fix it there first.
> 
Anyway, it is a bug of retry 3 times at max but without check current
card status and ensure it's in transfer state before next retry.
> >> > I think the purpose of "re-tune" is trying to cover particular case(eg.
> >> > voltage fluctuate or EMI or some glitch of host/device which caused CRC
> >> > error)
> >>
> >> No, re-tuning is to compensate for drift caused primarily by temperature change.
> >>
> > Yes, by JEDEC spec, temperature change cause timing drift of EMMC
> > device, but, as you mentioned, maybe I have a hardware problem of host,
> > but needs Software to cover it. so that we are doing our best to do
> > re-tune if got CRC error. if could recover it, then  it's better than
> > system hung.
> 
> Exactly in what cases do you get CRC errors for CMD6. We need a full
> cmd log to understand and to help.
> 
> >> > error) , but in such cases, too many cases are disable re-tune function
> >> > by mmc_retune_hold(), for example, in this case, if a response CRC error
> >> > got then we never have chance to recover it. then cause system cannot
> >> > access emmc or suspend/resume fail.
> >>
> >> Maybe you have a hardware problem.
> 
> There is no way I am going to accept patches touching this part of the
> mmc core, without providing real evidence for how it solves a problem.
> To me, it seems like you are applying a workaround for another issue.
> 
> Again, try to provide us with some more data and logs, then perhaps we
> can help narrow down the issues.
> 
> Kind regards
> Uffe

Below is the fail log of suspend fail.
the normal command tune result should be 0xffffff9ff, but some time, we
get the tune result of 0xffffffff, then we choose the 10 as the best
tune parameter, which is not stable.
I know that we should focus on why we get the result of 0xffffffff, this
may be result of device/host timing shifting while tuning. but what I
want to do is that when get a response CRC error, we can do re-tune to
recovery it, but not only return the -84 and cause suspend fail
eventually. if all hardware are perfect, then we don't need the re-tune
mechanism.

as Adrian's comment, if temperature change at here caused CMD6 response
CRC error, then how to recovery it ?

[  129.106622]  (0)[96:mmcqd/0]mtk-msdc 11230000.mmc: phase:
[map:fffff9ff] [maxlen:21] [final:21] -->current result is OK and 21 is
stable
[  129.109404]  (0)[96:mmcqd/0]mtk-msdc 11230000.mmc: phase:
[map:ffffe03f] [maxlen:19] [final:22]
--------------------> below is next resume and re-init card:
[  129.778454]  (0)[96:mmcqd/0]mtk-msdc 11230000.mmc: Regulator set
error -22: 3300000 - 3300000
[  130.016987]  (0)[96:mmcqd/0]mtk-msdc 11230000.mmc: phase:
[map:ffffffff] [maxlen:32] [final:10] --> this result if not OK and 10
is not stable.
[  130.019556]  (0)[96:mmcqd/0]mtk-msdc 11230000.mmc: phase:
[map:ffffc03f] [maxlen:18] [final:23]
[  130.124279]  (1)[1248:system_server]mmc0: cache flush error -84 
[  130.125058]  (1)[1248:system_server]dpm_run_callback():
mmc_bus_suspend+0x0/0x4c returns -84 
[  130.126104]  (1)[1248:system_server]PM: Device mmc0:0001 failed to
suspend: error -84 



