From: David Jander <david@protonic.nl>
Subject: SDHCI long sleep with interrupts off
Date: Thu, 17 Dec 2015 11:28:14 +0100
Message-ID: <20151217112814.6250a3b9@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org
Cc: Pierre Ossman <pierre@ossman.eu>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


Hi all, 

I was investigating the source of abnormal irq-latency spikes on an i.MX6
(ARM) board, and discovered this:

# tracer: preemptirqsoff
#
# preemptirqsoff latency trace v1.1.5 on 4.4.0-rc4+
# --------------------------------------------------------------------
# latency: 2068 us, #4/4, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0 #P:1)
#    -----------------
#    | task: mmcqd/0-92 (uid:0 nice:0 policy:0 rt_prio:0)
#    -----------------
#  => started at: _raw_spin_lock_irqsave
#  => ended at:   _raw_spin_unlock_irqrestore
#
#
#                  _------=> CPU#            
#                 / _-----=> irqs-off        
#                | / _----=> need-resched    
#                || / _---=> hardirq/softirq 
#                ||| / _--=> preempt-depth   
#                |||| /     delay            
#  cmd     pid   ||||| time  |   caller      
#     \   /      |||||  \    |   /         
 mmcqd/0-92      0d...    1us#: _raw_spin_lock_irqsave
 mmcqd/0-92      0.n.1 2066us : _raw_spin_unlock_irqrestore
 mmcqd/0-92      0.n.1 2070us+: trace_preempt_on <-_raw_spin_unlock_irqrestore
 mmcqd/0-92      0.n.1 2107us : <stack trace>
 => sdhci_runtime_resume_host
 => __rpm_callback
 => rpm_callback
 => rpm_resume
 => __pm_runtime_resume
 => __mmc_claim_host
 => mmc_blk_issue_rq
 => mmc_queue_thread
 => kthread
 => ret_from_fork

2 ms with interrupts disabled!!! To much dismay, I later discovered that this
isn't even the worst case scenario. I also discovered that this has been in
the kernel for a long time without a fix (I have tested from 3.17 to 4.4-rc4).
There has been an attempt by someone to address this back in 2010, but
apparently it never hit mainline.
Going through the code in sdhci.c, I found this troublesome code-path:

sdhci_do_set_ios() {
	spin_lock_irqsave(&host->lock, flags);
	...
	sdhci_reinit() --> sdhci_init() --> sdhci_do_reset() -->
		host->ops->reset() --> sdhci_reset()	
	...
	spin_unlock_irqrestore(&host->lock, flags);
}

And in sdhci_reset(), which may be called with held spinlock:

	...
	/* Wait max 100 ms */
	timeout = 100;

	/* hw clears the bit when it's done */
	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
		if (timeout == 0) {
			pr_err("%s: Reset 0x%x never completed.\n",
				mmc_hostname(host->mmc), (int)mask);
			sdhci_dumpregs(host);
			return;
		}
		timeout--;
		mdelay(1);
	}

I am wondering: There either must be a reason this hasn't been fixed in such a
long time, or I am not understanding this correctly, so please enlighten me.
Before trying a cowboy attempt at "fixing" this, I'd really like to know why am
I seeing this?
I mean... how can such a problem get unnoticed and unfixed for so long?
Will an attempt at fixing this issue even be accepted?

Best regards,

-- 
David Jander
Protonic Holland.
