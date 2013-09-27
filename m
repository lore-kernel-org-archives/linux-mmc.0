From: Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH] Re: How to trigger sdio bus probing from user space
Date: Fri, 27 Sep 2013 13:56:14 +0000 (UTC)
Message-ID: <l242pu$fog$1@ger.gmane.org>
References: <52455BCD.5040309@rt-rk.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:36907 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993Ab3I0N4i (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Sep 2013 09:56:38 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1VPYX4-0004gD-GD
	for linux-mmc@vger.kernel.org; Fri, 27 Sep 2013 15:56:34 +0200
Received: from 146.187.3.109.rev.sfr.net ([109.3.187.146])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Fri, 27 Sep 2013 15:56:34 +0200
Received: from romain.izard.pro by 146.187.3.109.rev.sfr.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Fri, 27 Sep 2013 15:56:34 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

On 2013-09-27, Bojan Prtvar <bojan.prtvar@rt-rk.com> wrote:
>
> Is there a clean way to trigger sdio bus probing from user space?
>
> I have a non removable sdio WiFi/BT module on embedded system that needs
> to be tested and calibrated on production line.
> In order to speed up production process, I need to be able to replace
> the  WiFi/BT modules in run time without reboot.
> Modules are connected to the host with a ribbon cable, not with a  sdio
> connector.
>
> I came up with fallowing two-part solution:
> a)
> I extended WiFi driver's /proc interface with a call to
> mmc_detect_change()
> b)
> I also needed to let the sdio host think module is removable by
> commenting fallowing in sdhci-mv.c:
> sdhci_mv_probe_dt(struct platform_device *pdev)
> {
>     struct device_node *np = pdev->dev.of_node;
>     struct sdhci_host *host = platform_get_drvdata(pdev);
>
>     if (of_get_property(np, "mrvl,card-wired", NULL)) {
>         /*
>          * RT-RK
>          * We need to comment out these in order to be able to
>          * trigger sdio bus probing on the fly
>          */
>         //host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>         //host->mmc->caps |= MMC_CAP_NONREMOVABLE;
>     }
>
> This works in situations when working modules are inserted.
> Unfortunately, it does not work in case when broken module is inserted
> on production line.
> In this case production board needs to be rebooted, because the WiFi
> driver's /proc interface is gone, and I can not force a call to
> mmc_detect_change() any more.
>
> Is there cleaner and better approach?

For internal use I have added a 'rescan' sysfs entry to the mmc
controller, instead of the sdio device itself. It is quite similar to
the way it is done in the scsi subsystem, and uses the same
'mmc_detect_change' function as you do .

Updated to use the new attribute groups syntax for 3.12, I obtain the
following patch - compile-tested only, nothing more, as I do not have a
3.12 test system available.

---

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 49bc403..b5b0811 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -39,9 +39,26 @@ static void mmc_host_classdev_release(struct device *dev)
        kfree(host);
 }
 
+static ssize_t rescan_store(struct device *dev, struct device_attribute *attr,
+                            const char *buf, size_t count)
+{
+       struct mmc_host *host = cls_dev_to_mmc_host(dev);
+       mmc_detect_change(host, 0);
+       return count;
+}
+
+static DEVICE_ATTR_WO(rescan);
+
+static struct attribute *mmc_host_attrs[] = {
+       &dev_attr_rescan.attr,
+       NULL,
+};
+ATTRIBUTE_GROUPS(mmc_host);
+
 static struct class mmc_host_class = {
        .name           = "mmc_host",
        .dev_release    = mmc_host_classdev_release,
+       .dev_groups     = mmc_host_groups,
 };
 
 int mmc_register_host_class(void)


-- 
Romain Izard

