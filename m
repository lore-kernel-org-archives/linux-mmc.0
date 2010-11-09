From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc: agressive clocking framework v8
Date: Tue, 9 Nov 2010 03:59:48 +0000
Message-ID: <20101109035948.GA32119@void.printf.net>
References: <1288776170-10141-1-git-send-email-linus.walleij@stericsson.com> <AANLkTika=H3EOA=WSdyuP9Mexrrh0z6-KjjTiNCj=mLc@mail.gmail.com> <AANLkTiniyy_rC4wUAhxN4i09d4GqhdnqPOqXMYNZyBXT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37034 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287Ab0KID7w (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 8 Nov 2010 22:59:52 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTiniyy_rC4wUAhxN4i09d4GqhdnqPOqXMYNZyBXT@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ghorai Sukumar <s-ghorai@ti.com>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, David Vrabel <david.vrabel@csr.com>, Kyungmin Park <kmpark@infradead.org>, jh80.chung@samsung.com, Linus Walleij <linus.walleij@stericsson.com>

Hi Linus,

On Mon, Nov 08, 2010 at 11:30:41PM +0100, Linus Walleij wrote:
> Chris, can you add v8 to your for-next git?

Done -- thanks very much for doing this!  I fixed up a compile error
when CONFIG_MMC_CLKGATE=n:

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 746730e..8bf542c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -617,12 +617,15 @@ static inline void mmc_set_ios(struct mmc_host *host)
 		 ios->power_mode, ios->chip_select, ios->vdd,
 		 ios->bus_width, ios->timing);
 
+#ifdef CONFIG_MMC_CLKGATE
 	/*
 	 * We've been given a new frequency while the clock is gated,
 	 * so make sure we regard this as ungating it.
 	 */
 	if (ios->clock > 0 && host->clk_gated)
 		host->clk_gated = false;
+#endif
+
 	host->ops->set_ios(host, ios);
 }
 
.. and I also made trivial stylistic changes, let me know if you
disagree with anything below.  ("/**" is a required preamble for
kerneldoc comments.)

diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index 1018ccc1..ef10387 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -21,7 +21,7 @@ config MMC_CLKGATE
 	bool "MMC host clock gating (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
 	help
-	  This will attempt to agressively gate the clock to the MMC card.
+	  This will attempt to aggressively gate the clock to the MMC card.
 	  This is done to save power due to gating off the logic and bus
 	  noise when the MMC card is not in use. Your host driver has to
 	  support handling this in order for it to be of any use.
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1be5d65..746730e 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -618,7 +618,7 @@ static inline void mmc_set_ios(struct mmc_host *host)
 		 ios->bus_width, ios->timing);
 
 	/*
-	 * We get a new frequency while the clock is gated,
+	 * We've been given a new frequency while the clock is gated,
 	 * so make sure we regard this as ungating it.
 	 */
 	if (ios->clock > 0 && host->clk_gated)
@@ -669,9 +669,8 @@ void mmc_gate_clock(struct mmc_host *host)
 void mmc_ungate_clock(struct mmc_host *host)
 {
 	/*
-	 * We should previously have gated the clock, so the clock
-	 * shall be 0 here!
-	 * The clock may however be 0 during intialization,
+	 * We should previously have gated the clock, so the clock shall
+	 * be 0 here! The clock may however be 0 during initialization,
 	 * when some request operations are performed before setting
 	 * the frequency. When ungate is requested in that situation
 	 * we just ignore the call.
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 958409a..aacd9c5 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -58,9 +58,8 @@ static DEFINE_SPINLOCK(mmc_host_lock);
  * Enabling clock gating will make the core call out to the host
  * once up and once down when it performs a request or card operation
  * intermingled in any fashion. The driver will see this through
- * set_ios() operations with ios.clock field set to 0 to gate
- * (disable) the block clock, and to the old frequency to enable
- * it again.
+ * set_ios() operations with ios.clock field set to 0 to gate (disable)
+ * the block clock, and to the old frequency to enable it again.
  */
 static void mmc_host_clk_gate_delayed(struct mmc_host *host)
 {
@@ -82,11 +81,11 @@ static void mmc_host_clk_gate_delayed(struct mmc_host *host)
 	 */
 	spin_lock_irqsave(&host->clk_lock, flags);
 	users = host->clk_requests;
+
 	/*
 	 * Delay n bus cycles (at least 8 from MMC spec) before attempting
-	 * to disable the MCI block clock. The reference count
-	 * may have gone up again after this delay due to
-	 * rescheduling!
+	 * to disable the MCI block clock. The reference count may have
+	 * gone up again after this delay due to rescheduling!
 	 */
 	if (!users) {
 		spin_unlock_irqrestore(&host->clk_lock, flags);
@@ -101,11 +100,10 @@ static void mmc_host_clk_gate_delayed(struct mmc_host *host)
 	spin_lock_irqsave(&host->clk_lock, flags);
 	if (!host->clk_requests) {
 		spin_unlock_irqrestore(&host->clk_lock, flags);
-		/* this will set host->ios.clock to 0 */
+		/* This will set host->ios.clock to 0 */
 		mmc_gate_clock(host);
 		spin_lock_irqsave(&host->clk_lock, flags);
-		pr_debug("%s: gated MCI clock\n",
-			 mmc_hostname(host));
+		pr_debug("%s: gated MCI clock\n", mmc_hostname(host));
 	}
 	host->clk_pending_gate = false;
 	spin_unlock_irqrestore(&host->clk_lock, flags);
@@ -122,12 +120,13 @@ static void mmc_host_clk_gate_work(struct work_struct *work)
 	mmc_host_clk_gate_delayed(host);
 }
 
-/*
- *	mmc_host_clk_ungate - make sure the host ios.clock is
- *	restored to some non-zero value past this call.
+/**
+ *	mmc_host_clk_ungate - ungate hardware MCI clocks
  *	@host: host to ungate.
  *
- *	Increase clock reference count and ungate clock if first user.
+ *	Makes sure the host ios.clock is restored to a non-zero value
+ *	past this call.	Increase clock reference count and ungate clock
+ *	if we're the first user.
  */
 void mmc_host_clk_ungate(struct mmc_host *host)
 {
@@ -138,14 +137,13 @@ void mmc_host_clk_ungate(struct mmc_host *host)
 		spin_unlock_irqrestore(&host->clk_lock, flags);
 		mmc_ungate_clock(host);
 		spin_lock_irqsave(&host->clk_lock, flags);
-		pr_debug("%s: ungated MCI clock\n",
-			 mmc_hostname(host));
+		pr_debug("%s: ungated MCI clock\n", mmc_hostname(host));
 	}
 	host->clk_requests++;
 	spin_unlock_irqrestore(&host->clk_lock, flags);
 }
 
-/*
+/**
  *	mmc_host_may_gate_card - check if this card may be gated
  *	@card: card to check.
  */
@@ -168,13 +166,13 @@ static bool mmc_host_may_gate_card(struct mmc_card *card)
 	return true;
 }
 
-/*
- *	mmc_host_clk_gate - call the host driver with ios.clock
- *	set to zero as often as possible so as to make it
- *	possible to gate off hardware MCI clocks.
+/**
+ *	mmc_host_clk_gate - gate off hardware MCI clocks
  *	@host: host to gate.
  *
- *	Decrease clock reference count and schedule disablement of clock.
+ *	Calls the host driver with ios.clock set to zero as often as possible
+ *	in order to gate off hardware MCI clocks. Decrease clock reference
+ *	count and schedule disabling of clock.
  */
 void mmc_host_clk_gate(struct mmc_host *host)
 {
@@ -190,10 +188,11 @@ void mmc_host_clk_gate(struct mmc_host *host)
 	spin_unlock_irqrestore(&host->clk_lock, flags);
 }
 
-/*
- *	mmc_host_clk_rate - get current clock frequency setting no matter
- *	whether it's gated or not.
+/**
+ *	mmc_host_clk_rate - get current clock frequency setting
  *	@host: host to get the clock frequency for.
+ *
+ *	Returns current clock frequency regardless of gating.
  */
 unsigned int mmc_host_clk_rate(struct mmc_host *host)
 {
@@ -209,21 +208,22 @@ unsigned int mmc_host_clk_rate(struct mmc_host *host)
 	return freq;
 }
 
-/*
+/**
  *	mmc_host_clk_init - set up clock gating code
  *	@host: host with potential clock to control
  */
 static inline void mmc_host_clk_init(struct mmc_host *host)
 {
 	host->clk_requests = 0;
-	host->clk_delay = 8; /* hold MCI clock in 8 cycles by default */
+	/* Hold MCI clock for 8 cycles by default */
+	host->clk_delay = 8;
 	host->clk_gated = false;
 	host->clk_pending_gate = false;
 	INIT_WORK(&host->clk_disable_work, mmc_host_clk_gate_work);
 	spin_lock_init(&host->clk_lock);
 }
 
-/*
+/**
  *	mmc_host_clk_exit - shut down clock gating code
  *	@host: host with potential clock to control
  */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index c38c400..f108cee 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -176,7 +176,7 @@ struct mmc_host {
 	unsigned int		clk_delay;	/* number of MCI clk hold cycles */
 	bool			clk_gated;	/* clock gated */
 	bool			clk_pending_gate; /* pending clock gating */
-	struct work_struct	clk_disable_work; /* delayed clock disablement */
+	struct work_struct	clk_disable_work; /* delayed clock disable */
 	unsigned int		clk_old;	/* old clock value cache */
 	spinlock_t		clk_lock;	/* lock for clk fields */
 #endif


-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
