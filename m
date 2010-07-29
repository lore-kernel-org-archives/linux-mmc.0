From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 04/12] mmci: allow the card detect status not to be
	inverted
Date: Thu, 29 Jul 2010 15:20:11 +0100
Message-ID: <20100729142011.GG18923@n2100.arm.linux.org.uk>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
	<1277198267-10860-4-git-send-email-rabin.vincent@stericsson.com>
	<20100729123443.GA18923@n2100.arm.linux.org.uk>
	<AANLkTikQi+SPpx8Wpvb0siSSsw0ZhusWaaKmqRnfHrnz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikQi+SPpx8Wpvb0siSSsw0ZhusWaaKmqRnfHrnz@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: STEricsson_nomadik_linux@list.st.com, linux-mmc@vger.kernel.org, Rabin Vincent <rabin.vincent@stericsson.com>, Colin Tuckley <colin.tuckley@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Jul 29, 2010 at 03:53:19PM +0200, Linus Walleij wrote:
> 2010/7/29 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> 
> > What now needs to happen is the sense of the GPIOLIB support on platforms
> > needs to be checked - eg, I suspect the card detect via the GPIO primecell
> > is inverted on Realview - in which case we need a 'cd_invert' rather
> > than the negative 'cd_noinvert'.
> 
> Doesn't seem so. I applied this patch and it works like a charm just
> like before on PB1176. (PL061 is compiled in, so it's not that other
> weird stuff being used.)

Well, as I said in the other thread which seems to be dealing with this,
I'm completely confused (as seems to be the case with this) as to what
sense the various card detect signals are on ARMs various hardware
platforms.

It seems to be a totally undocumented - and I've no idea whether the
behaviour I see on my platforms is what other people see (from some
suggestions in these threads, my platforms behave differently.)

So, for now I'm going to go with this patch, which fixes it across the
board for the non-GPIO cases.

When the right sense for the GPIO case can be _properly_ determined,
we can see about fixing that.  What I don't want to get into is a "it
works this way on my realview revision X platform, but not revision Y."
If that's the case, we might as well stick with reading the status from
the reliable MCI register which always uses positive logic.

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 595be19..02e9fde 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -237,7 +237,7 @@ static unsigned int realview_mmc_status(struct device *dev)
 	else
 		mask = 2;
 
-	return !(readl(REALVIEW_SYSMCI) & mask);
+	return readl(REALVIEW_SYSMCI) & mask;
 }
 
 struct mmci_platform_data realview_mmc0_plat_data = {
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index d250711..c842397 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -241,7 +241,7 @@ static struct platform_device v2m_flash_device = {
 
 static unsigned int v2m_mmci_status(struct device *dev)
 {
-	return !(readl(MMIO_P2V(V2M_SYS_MCI)) & (1 << 0));
+	return readl(MMIO_P2V(V2M_SYS_MCI)) & (1 << 0);
 }
 
 static struct mmci_platform_data v2m_mmci_data = {
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 4917af9..8ca38d9 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -541,7 +541,11 @@ static int mmci_get_cd(struct mmc_host *mmc)
 	else
 		status = gpio_get_value(host->gpio_cd);
 
-	return !status;
+	/*
+	 * Use positive logic throughout - status is zero for no card,
+	 * non-zero for card inserted.
+	 */
+	return status;
 }
 
 static const struct mmc_host_ops mmci_ops = {
