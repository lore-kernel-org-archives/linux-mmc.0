From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH V2] mmc: sdhci: supporting PCI MSI
Date: Wed, 13 Nov 2013 21:40:06 +0800
Message-ID: <52838136.1090509@intel.com>
References: <1384239413-7027-1-git-send-email-Jackey.Shen@amd.com> <5281DC68.3080606@intel.com> <20131112092716.GA7285@ubuntu.amd.com> <5282CDE2.60500@intel.com> <20131113055508.GA3755@ubuntu.amd.com> <20131113060011.GB3755@ubuntu.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:61306 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757263Ab3KMNkR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Nov 2013 08:40:17 -0500
Received: by mail-pa0-f50.google.com with SMTP id hz1so431881pad.23
        for <linux-mmc@vger.kernel.org>; Wed, 13 Nov 2013 05:40:16 -0800 (PST)
In-Reply-To: <20131113060011.GB3755@ubuntu.amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jackey Shen <jackey.shen@amd.com>
Cc: alexander.stein@systec-electronic.com, manuel.lauss@googlemail.com, hanfi@spahan.ch, linux-mmc@vger.kernel.org, mcuos.com@gmail.com, Ray.Huang@amd.com

On 11/13/2013 02:00 PM, Jackey Shen wrote:
> On Wed, Nov 13, 2013 at 01:55:08PM +0800, Jackey Shen wrote:
>>>>> What about we only call pci_enable_msi in sdhci-pci.c and then assign
>>>>> host->irq appropriately before calling sdhci_add_host, will that work?
>>>>> The only difference would be, request_irq will have SHARED flag, but I
>>>>> suppose that's not a problem.
>>>>>
>>>> There are 2 points for this part:
>>>> 1. fall back to legacy interrupt right after MSI request fails;
>>>
>>> If we call pci_enable_msi somewhere in sdhci_pci_probe_slot, then if it
>>> failed, we can also fall back I suppose?
>>>
>> Yes, it is. 
>> But, sdhci_pci_disable_msi should be kept since pci_disable_msi is
>> pci bus releted and better not used in sdhci.c.
>> So, enable msi and disable msi are NOT symmetric in style.
>> What's your opinion?
> 
> Sorry for missing word.
> So, enable msi and disable msi are NOT symmetric in style.
>

I meant something like this:

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index d7d6bc8..96461a3 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1339,12 +1339,17 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	host->quirks = chip->quirks;
 	host->quirks2 = chip->quirks2;

+	ret = pci_enable_msi(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot enable msi\n");
+		goto cleanup;
+	}
 	host->irq = pdev->irq;

 	ret = pci_request_region(pdev, bar, mmc_hostname(host->mmc));
 	if (ret) {
 		dev_err(&pdev->dev, "cannot request region\n");
-		goto cleanup;
+		goto disable_msi;
 	}

 	host->ioaddr = pci_ioremap_bar(pdev, bar);
@@ -1396,6 +1401,9 @@ unmap:
 release:
 	pci_release_region(pdev, bar);

+disable_msi:
+	pci_disable_msi(pdev);
+
 cleanup:
 	if (slot->data && slot->data->cleanup)
 		slot->data->cleanup(slot->data);
@@ -1431,6 +1439,8 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)

 	pci_release_region(slot->chip->pdev, slot->pci_bar);

+	pci_disable_msi(slot->chip->pdev);
+
 	sdhci_free_host(slot->host);
 }


We can do all these MSI stuffs in sdhci-pci.c, but I'm not sure if this
is correct.

Thanks,
Aaron
