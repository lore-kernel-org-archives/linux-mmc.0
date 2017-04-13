From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH 2/2] mmc: sdhci: provide isr for card-detect interrupts
Date: Thu, 13 Apr 2017 17:17:59 +0800
Message-ID: <20170413171759.1e98aa36@xhacker>
References: <20170411102056.2869-1-jszhang@marvell.com>
 <20170411102056.2869-3-jszhang@marvell.com>
 <772c085c-beba-cfe8-23ca-0c46a96145fe@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <772c085c-beba-cfe8-23ca-0c46a96145fe@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 11 Apr 2017 13:31:16 +0300 Adrian Hunter wrote:

> On 11/04/17 13:20, Jisheng Zhang wrote:
> > We found one issue on BG4CT platforms with GPIO for sdcar card detect
> > interrupt: remove sdcard when there's read write access to the sdcard,
> > sometimes the card remove event can't be handled for a long time, so
> > the  system still think the sdcard is still plugged in. It turns out
> > that the sdhci_card_event() is missing in common slot gpio's card
> > detect isr.  
> 
> ->card_event() is called by mmc_rescan().  Why is that too late?  

Indeed, maybe the "too late" here is not accurate. Compared with host's
CD interrupt handling, the GPIO CD interrupt handling differs in when to
call sdhci_card_event(): in previous case, it's called in ISR, in later
it's in workqueue.

Now, I agree it's not necessary to put into ISR. So let's ignore the
two patches.

Thanks for your review,
Jisheng
