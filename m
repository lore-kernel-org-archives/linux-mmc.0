From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Recent "Run the driver callback directly" patch
	breaks libertas suspend
Date: Sun, 25 Mar 2012 23:25:37 +0200
Message-ID: <201203252325.37478.rjw@sisk.pl>
References: <20120325203849.7a908e32@notabene.brown>
	<201203252309.48705.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201203252309.48705.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: NeilBrown <neilb@suse.de>
Cc: linux-pm@lists.linux-foundation.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Sunday, March 25, 2012, Rafael J. Wysocki wrote:
> Hi,
> 
> On Sunday, March 25, 2012, NeilBrown wrote:
> > 
> > Hi Rafael,
> > 
> >  Your recent patch:
> >    commit 35cd133c
> >    PM: Run the driver callback directly if the subsystem one is not there
> > 
> >  breaks suspend for my libertas wifi and probably other SDIO devices.
> 
> Well, the patch is not recent.  The _commit_ is more than three months old
> and the patch has been around since the last November (at least).
> 
> >  SDIO (and possible MMC in general) has a protocol where the suspend
> >  method can return -ENOSYS and this means "There is no point in suspending,
> >  just turn me off".
> >
> >  The device itself "mmc1:0001" (I think) doesn't have any bus etc 'suspend'
> >  function so the new code call the device's suspend function which returns
> >  ENOSYS and the suspend fails.
> > 
> >  The previous code ignores the device as there is no bus suspend, and when it
> >  gets to suspend the ancestor - which for me is omap_hsmmc.1, it calls the
> >  device suspend function catches the ENOSYS, and turns it off.
> 
> Well, I can only call that a blatant abuse of the PM infrastructure.
> 
> >  I suspect just reverting it isn't the right long term solution, however I
> >  can confirm that it works for me for now.
> 
> It's not a solution at all, because there's code that depends on it already in
> the tree and the fact that it works for you doesn't mean it won't break other
> systems.  So no, it's not an option.
> 
> >  I'm happy to try any alternate fixes you would like to suggest (but I cannot
> >  promise how quickly I will get the testing done).
> > 
> >  (I'm testing with 3.3)
> 
> The only fix I can think of is to rework SDIO to stop abusing the PM callbacks.
> I'll have a look at that next week, although I can't promise anything any time
> soon, because I'm heading to San Francisco on Saturday.

Well, this is kind of a long shot, but I wonder if the patch below makes
any difference?

Rafael

---
 drivers/mmc/core/sdio_bus.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

Index: linux/drivers/mmc/core/sdio_bus.c
===================================================================
--- linux.orig/drivers/mmc/core/sdio_bus.c
+++ linux/drivers/mmc/core/sdio_bus.c
@@ -192,9 +192,15 @@ static int sdio_bus_remove(struct device
 	return ret;
 }
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
+
+static int pm_no_operation(struct device *dev)
+{
+	return 0;
+}
 
 static const struct dev_pm_ops sdio_bus_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_no_operation, pm_no_operation)
 	SET_RUNTIME_PM_OPS(
 		pm_generic_runtime_suspend,
 		pm_generic_runtime_resume,
@@ -204,11 +210,11 @@ static const struct dev_pm_ops sdio_bus_
 
 #define SDIO_PM_OPS_PTR	(&sdio_bus_pm_ops)
 
-#else /* !CONFIG_PM_RUNTIME */
+#else /* !CONFIG_PM */
 
 #define SDIO_PM_OPS_PTR	NULL
 
-#endif /* !CONFIG_PM_RUNTIME */
+#endif /* !CONFIG_PM */
 
 static struct bus_type sdio_bus_type = {
 	.name		= "sdio",
