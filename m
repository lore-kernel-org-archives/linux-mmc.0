From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Continuous SD IO causes hung task messages
Date: Wed, 28 Aug 2019 12:31:56 +0200
Message-ID: <CAPDyKFoJgT9kRnARcP+snZkqC7rrp3UCd=mA=n3GL_brr2SHBw@mail.gmail.com>
References: <20190827134337.GK13294@shell.armlinux.org.uk>
 <CAPDyKFp7e2OD_idam3-2sEd0wJU5OcP=H04G1OvHmAUo2Y-bYw@mail.gmail.com>
 <20190827143634.GL13294@shell.armlinux.org.uk>
 <20190827145216.GM13294@shell.armlinux.org.uk>
 <20190827150614.GN13294@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190827150614.GN13294@shell.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 27 Aug 2019 at 17:06, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Tue, Aug 27, 2019 at 03:52:17PM +0100, Russell King - ARM Linux admin wrote:
> > On Tue, Aug 27, 2019 at 03:36:34PM +0100, Russell King - ARM Linux admin wrote:
> > > On Tue, Aug 27, 2019 at 03:55:23PM +0200, Ulf Hansson wrote:
> > > > On Tue, 27 Aug 2019 at 15:43, Russell King - ARM Linux admin
> > > > <linux@armlinux.org.uk> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > While dd'ing the contents of a SD card, I get hung task timeout
> > > > > messages as per below.  However, the dd is making progress.  Any
> > > > > ideas?
> > > > >
> > > > > Presumably, mmc_rescan doesn't get a look-in while IO is progressing
> > > > > for the card?
> > > >
> > > > Is it a regression?
> > > >
> > > > There not much of recent mmc core and mmc block changes, that I can
> > > > think of at this point.
> > >
> > > No idea - I just repaired the SD socket after the D2 line became
> > > disconnected, and decided to run that command as a test.
> > >
> > > > > ARM64 host, Macchiatobin, uSD card.
> > > >
> > > > What mmc host driver is it? mmci?
> > >
> > > sdhci-xenon.
> > >
> > > I'm just trying with one CPU online, then I'll try with two.  My
> > > suspicion is that there's a problem in the ARM64 arch code where
> > > unlocking a mutex doesn't get noticed on other CPUs.
> > >
> > > Hmm, I thought I'd try bringing another CPU online, but it seems
> > > like the ARM64 CPU hotplug code is broken:
> > >
> > > [ 3552.029689] CPU1: shutdown
> > > [ 3552.031099] psci: CPU1 killed.
> > > [ 3949.835212] CPU1: failed to come online
> > > [ 3949.837753] CPU1: failed in unknown state : 0x0
> > >
> > > which means I can only take CPUs down, I can't bring them back
> > > online without rebooting.
> >
> > Okay, running on a single CPU shows no problems.
> >
> > Running on four CPUs (as originally) shows that the kworker thread
> > _never_ gets scheduled, so the warning is not false.
> >
> > With three CPUs, same problem.
> >
> > root@arm-d06300000000:~# ps aux | grep ' D '
> > root        34  0.0  0.0      0     0 ?        D    15:38   0:00 [kworker/1:1+events_freezable]
> > root@arm-d06300000000:~# cat /proc/34/sched
> > kworker/1:1 (34, #threads: 1)
> > -------------------------------------------------------------------
> > se.exec_start                                :        318689.992440
> > se.vruntime                                  :         37750.882357
> > se.sum_exec_runtime                          :             9.421240
> > se.nr_migrations                             :                    0
> > nr_switches                                  :                 1174
> > nr_voluntary_switches                        :                 1171
> > nr_involuntary_switches                      :                    3
> > se.load.weight                               :              1048576
> > se.runnable_weight                           :              1048576
> > se.avg.load_sum                              :                    6
> > se.avg.runnable_load_sum                     :                    6
> > se.avg.util_sum                              :                 5170
> > se.avg.load_avg                              :                    0
> > se.avg.runnable_load_avg                     :                    0
> > se.avg.util_avg                              :                    0
> > se.avg.last_update_time                      :         318689991680
> > se.avg.util_est.ewma                         :                   10
> > se.avg.util_est.enqueued                     :                    0
> > policy                                       :                    0
> > prio                                         :                  120
> > clock-delta                                  :                    0
> >
> > The only thing that changes there is "clock-delta".  When I kill the
> > dd, I get:
> >
> > root@arm-d06300000000:~# cat /proc/34/sched
> > kworker/1:1 (34, #threads: 1)
> > -------------------------------------------------------------------
> > se.exec_start                                :        574025.791680
> > se.vruntime                                  :         79996.657300
> > se.sum_exec_runtime                          :            10.916400
> > se.nr_migrations                             :                    0
> > nr_switches                                  :                 1403
> > nr_voluntary_switches                        :                 1400
> > nr_involuntary_switches                      :                    3
> > se.load.weight                               :              1048576
> > se.runnable_weight                           :              1048576
> > se.avg.load_sum                              :                   15
> > se.avg.runnable_load_sum                     :                   15
> > se.avg.util_sum                              :                15007
> > se.avg.load_avg                              :                    0
> > se.avg.runnable_load_avg                     :                    0
> > se.avg.util_avg                              :                    0
> > se.avg.last_update_time                      :         574025791488
> > se.avg.util_est.ewma                         :                   10
> > se.avg.util_est.enqueued                     :                    0
> > policy                                       :                    0
> > prio                                         :                  120
> > clock-delta                                  :                   40
> >
> > so the thread makes forward progress.
> >
> > Down to two CPUs:
> >
> > root@arm-d06300000000:~# ps aux | grep ' D '
> > root        34  0.0  0.0      0     0 ?        D    15:38   0:00 [kworker/1:1+events_freezable]
> >
> > Same symptoms.  dd and md5sum switch between CPU 0 and CPU1.
>
> Hmm.
>
> static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>                                     const struct blk_mq_queue_data *bd)
>
>         mq->in_flight[issue_type] += 1;
>         get_card = (mmc_tot_in_flight(mq) == 1);
>
>         if (get_card)
>                 mmc_get_card(card, &mq->ctx);
>
> mmc_get_card() gets the host lock according to the card.
>
> So, if we always have requests in flight (which is probably the case
> here) we never drop the host lock, and mmc_rescan() never gets a look
> in - hence blocking the kworker.

Ahh, you are right. However, this isn't a new problem I believe.

Even if we did some re-work of the locking mechanism while converting
to blk-mq, I still think the worker could starve the mmc_rescan work
before.

In practice this shouldn't be a problem though, unless I am
overlooking something. This is because it's not until there is an I/O
error, that causes the block worker to release the host, to it makes
sense to let mmc_rescan to claim the host to check for card removal.

>
> So this is a real issue with MMC, and not down to something in the
> arch.

Yep, thanks for running the test and providing more details!

>
> I suspect the reason that single-CPU doesn't show it is because it is
> unable to keep multiple requests in flight.

Yes, most likely.

Now, how to solve this problem I need to think more about....

FYI: The long term goal has been to try to remove the big fat host
lock altogether and slowly we have moved more an more things to be
executed as a part of the block worker, which is one of the needed
steps. Like the mmc ioctls for example...

Kind regards
Uffe
