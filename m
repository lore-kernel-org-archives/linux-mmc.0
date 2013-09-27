From: Bojan Prtvar <bojan.prtvar@rt-rk.com>
Subject: How to trigger sdio bus probing from user space
Date: Fri, 27 Sep 2013 12:19:57 +0200
Message-ID: <52455BCD.5040309@rt-rk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.rt-rk.ftn.uns.ac.rs ([147.91.177.140]:60052 "EHLO
	mail.rt-rk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949Ab3I0KuN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Sep 2013 06:50:13 -0400
Received: from mail.rt-rk.com (mail.localdomain [127.0.0.1])
	by mail.rt-rk.com (Postfix) with SMTP id 1BFB525B695
	for <linux-mmc@vger.kernel.org>; Fri, 27 Sep 2013 12:19:58 +0200 (CEST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

Is there a clean way to trigger sdio bus probing from user space?

I have a non removable sdio WiFi/BT module on embedded system that needs
to be tested and calibrated on production line.
In order to speed up production process, I need to be able to replace
the  WiFi/BT modules in run time without reboot.
Modules are connected to the host with a ribbon cable, not with a  sdio
connector.

I came up with fallowing two-part solution:
a)
I extended WiFi driver's /proc interface with a call to
mmc_detect_change()
b)
I also needed to let the sdio host think module is removable by
commenting fallowing in sdhci-mv.c:
sdhci_mv_probe_dt(struct platform_device *pdev)
{
    struct device_node *np = pdev->dev.of_node;
    struct sdhci_host *host = platform_get_drvdata(pdev);

    if (of_get_property(np, "mrvl,card-wired", NULL)) {
        /*
         * RT-RK
         * We need to comment out these in order to be able to
         * trigger sdio bus probing on the fly
         */
        //host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
        //host->mmc->caps |= MMC_CAP_NONREMOVABLE;
    }

This works in situations when working modules are inserted.
Unfortunately, it does not work in case when broken module is inserted
on production line.
In this case production board needs to be rebooted, because the WiFi
driver's /proc interface is gone, and I can not force a call to
mmc_detect_change() any more.

Is there cleaner and better approach?

Best regards,
Bojan

