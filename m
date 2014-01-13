From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/1] mmc: sdhci: fix lockdep error on tunning routine
Date: Mon, 13 Jan 2014 13:04:35 +0100
Message-ID: <20140113120435.GQ31570@twins.programming.kicks-ass.net>
References: <1387797184-18958-1-git-send-email-b29396@freescale.com>
 <CAA+hA=TRQP7hS3+iXyHg3FuNQKA=chJi7Ne47Ew_4RJcQ6yong@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAA+hA=TRQP7hS3+iXyHg3FuNQKA=chJi7Ne47Ew_4RJcQ6yong@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Dong Aisheng <b29396@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Dec 26, 2013 at 03:58:20PM +0800, Dong Aisheng wrote:
> > It's strange that this issue did not happen on kernel 3.10.17 with the same
> > code. And looking at the code, before call spin_lock we already disable the mmc
> > controller irq, per on my understanding, the deadlock given by lockdep may not
> > be able to happen(pls fix me if wrong).
> > May the lockdep not track the specific irq disable?
> > Copy lockdep guy to comment.

No, lockdep also doesn't know only that one line can take this lock.
Lockdep only knows a lock is taken from IRQ context, and disabling one
line still allows IRQs to happen and therefore it yells.
