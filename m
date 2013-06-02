From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 01/10] clocksource: dw_apb_timer_of: use the clocksource as
 sched clock if necessary
Date: Mon, 3 Jun 2013 00:56:02 +0200
Message-ID: <201306030056.03522.heiko@sntech.de>
References: <201306030055.15413.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <201306030055.15413.heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Currently the dw_apb_timer always expects a separate special timer to be
availbable for the sched_clock. Some devices using dw_apb_timers do not
have the sptimer but can use the clocksource as sched_clock.
Therefore this patch adds using the clocksource timer as
a fallback if no usable sched timer is found.

Signed-off-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
---
 drivers/clocksource/dw_apb_timer_of.c |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index ab09ed3..d6c0fda 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -57,6 +57,9 @@ static void add_clockevent(struct device_node *event_timer)
 	dw_apb_clockevent_register(ced);
 }
 
+static void __iomem *sched_io_base;
+static u32 sched_rate;
+
 static void add_clocksource(struct device_node *source_timer)
 {
 	void __iomem *iobase;
@@ -71,9 +74,15 @@ static void add_clocksource(struct device_node *source_timer)
 
 	dw_apb_clocksource_start(cs);
 	dw_apb_clocksource_register(cs);
-}
 
-static void __iomem *sched_io_base;
+	/*
+	 * Fallback to use the clocksource as sched_clock if no separate
+	 * timer is found. sched_io_base then points to the current_value
+	 * register of the clocksource timer.
+	 */
+	sched_io_base = iobase + 0x04;
+	sched_rate = rate;
+}
 
 static u32 read_sched_clock(void)
 {
@@ -89,16 +98,15 @@ static const struct of_device_id sptimer_ids[] __initconst = {
 static void init_sched_clock(void)
 {
 	struct device_node *sched_timer;
-	u32 rate;
 
 	sched_timer = of_find_matching_node(NULL, sptimer_ids);
-	if (!sched_timer)
-		panic("No RTC for sched clock to use");
-
-	timer_get_base_and_rate(sched_timer, &sched_io_base, &rate);
-	of_node_put(sched_timer);
+	if (sched_timer) {
+		timer_get_base_and_rate(sched_timer, &sched_io_base,
+					&sched_rate);
+		of_node_put(sched_timer);
+	}
 
-	setup_sched_clock(read_sched_clock, 32, rate);
+	setup_sched_clock(read_sched_clock, 32, sched_rate);
 }
 
 static const struct of_device_id osctimer_ids[] __initconst = {
-- 
1.7.2.3
