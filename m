From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-pci: Let devices define their own private
 data
Date: Fri, 11 Nov 2016 09:00:10 +0200
Message-ID: <356cc7f6-31fb-4b09-6612-e4d03c23abd0@intel.com>
References: <78fc9537-4fea-1938-ba1d-b0c6030bd777@amd.com>
 <CAPDyKFpZb+2ArPs46UaLTB1jnDPjnNwCs6UZUSwRYRjDyM8sSA@mail.gmail.com>
 <d2b209d9-0d7e-fa61-49a7-cf5db4fcb372@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:30321 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935017AbcKKHFI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 11 Nov 2016 02:05:08 -0500
In-Reply-To: <d2b209d9-0d7e-fa61-49a7-cf5db4fcb372@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shyam Sundar S K <ssundark@amd.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "Sen, Pankaj" <Pankaj.Sen@amd.com>, "Agrawal, Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>, "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>

On 11/11/16 06:12, Shyam Sundar S K wrote:
> 
> 
> On 11/11/2016 3:46 AM, Ulf Hansson wrote:
>> On 10 November 2016 at 13:50, Shyam Sundar S K <ssundark@amd.com> wrote:
>>> Let devices define their own private data to facilitate device-specific
>>> operations. The size of the private structure is specified in the
>>> sdhci_pci_fixes structure,then sdhci_pci_probe_slot() will allocate extra
>>> space for it, and sdhci_pci_priv() can be used to get a reference to it.
>>>
>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>
>> Still not Adrian as author...
> 
> Hi Ulf,
> 
> It shows Adrian as author in my git log. I have done
> 
> git commit --amend --author="Adrian Hunter <adrian.hunter@intel.com>"
> 
> before generating the patch. Here is the git log output.
> 
> commit 169dce57501d234f436ba25e2a8c51aabc6792b5
> Author: Adrian Hunter <adrian.hunter@intel.com>
> Date:   Thu Nov 10 17:52:51 2016 +0530
> 
>     mmc: sdhci-pci: Let devices define their own private data
> 
>     Let devices define their own private data to facilitate device-specific
>     operations. The size of the private structure is specified in the
>     sdhci_pci_fixes structure,then sdhci_pci_probe_slot() will allocate extra
>     space for it, and sdhci_pci_priv() can be used to get a reference to it.
> 
>     Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

"git am" takes the author from the "From" line of email messages.  If that
is not the author, then you can add a "From" line in the message body.  Read
'man git am' and please try sending patches to yourself, applying them, and
checking they are correct before sending again.

> 
> 
> Thanks,
> Shyam
>>
>> Kind regards
>> Uffe
>>
>>> ---
>>>  drivers/mmc/host/sdhci-pci-core.c | 3 ++-
>>>  drivers/mmc/host/sdhci-pci.h      | 7 +++++++
>>>  2 files changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>>> index 1d9e00a..782c8d2 100644
>>> --- a/drivers/mmc/host/sdhci-pci-core.c
>>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>>> @@ -1646,6 +1646,7 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>>>         struct sdhci_pci_slot *slot;
>>>         struct sdhci_host *host;
>>>         int ret, bar = first_bar + slotno;
>>> +       size_t priv_size = chip->fixes ? chip->fixes->priv_size : 0;
>>>
>>>         if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM)) {
>>>                 dev_err(&pdev->dev, "BAR %d is not iomem. Aborting.\n", bar);
>>> @@ -1667,7 +1668,7 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>>>                 return ERR_PTR(-ENODEV);
>>>         }
>>>
>>> -       host = sdhci_alloc_host(&pdev->dev, sizeof(struct sdhci_pci_slot));
>>> +       host = sdhci_alloc_host(&pdev->dev, sizeof(*slot) + priv_size);
>>>         if (IS_ERR(host)) {
>>>                 dev_err(&pdev->dev, "cannot allocate host\n");
>>>                 return ERR_CAST(host);
>>> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
>>> index 6bccf56..0bfd568 100644
>>> --- a/drivers/mmc/host/sdhci-pci.h
>>> +++ b/drivers/mmc/host/sdhci-pci.h
>>> @@ -67,6 +67,7 @@ struct sdhci_pci_fixes {
>>>         int                     (*resume) (struct sdhci_pci_chip *);
>>>
>>>         const struct sdhci_ops  *ops;
>>> +       size_t                  priv_size;
>>>  };
>>>
>>>  struct sdhci_pci_slot {
>>> @@ -87,6 +88,7 @@ struct sdhci_pci_slot {
>>>                                      struct mmc_card *card,
>>>                                      unsigned int max_dtr, int host_drv,
>>>                                      int card_drv, int *drv_type);
>>> +       unsigned long           private[0] ____cacheline_aligned;
>>>  };
>>>
>>>  struct sdhci_pci_chip {
>>> @@ -101,4 +103,9 @@ struct sdhci_pci_chip {
>>>         struct sdhci_pci_slot   *slots[MAX_SLOTS]; /* Pointers to host slots */
>>>  };
>>>
>>> +static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
>>> +{
>>> +       return (void *)slot->private;
>>> +}
>>> +
>>>  #endif /* __SDHCI_PCI_H */
>>> --
>>> 2.7.4
> 

