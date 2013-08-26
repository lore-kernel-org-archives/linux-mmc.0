From: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Subject: Re: [PATCH 6/8] sdhci: Turn host->lock into a mutex
Date: Mon, 26 Aug 2013 10:37:56 +0200
Message-ID: <521B13E4.6030800@parrot.com>
References: <1373384652-21958-1-git-send-email-jeremie.samuel.ext@parrot.com> <1373384652-21958-7-git-send-email-jeremie.samuel.ext@parrot.com> <874naev8e1.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:34579 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756305Ab3HZIiz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 26 Aug 2013 04:38:55 -0400
In-Reply-To: <874naev8e1.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Matthieu Castet <matthieu.castet@parrot.com>, =?ISO-8859-1?Q?Gr=E9gor_BOIRIE?= <gregor.boirie@parrot.com>

Hi Chris,

Thank you for the feedback. I'll send you the modifications in 
September. But I will not be able to test the changes. I don't have the 
hardware.

Regards,

-- 
Jeremie Samuel              Parrot S.A.
Software Engineer           14, quai de Jemmapes
R&D/OS Platform             75010 Paris, France
http://www.parrot.com

On 25/08/2013 03:58, Chris Ball wrote:
> Hi Jeremie, I'm sorry for a very late review.
>
> On Tue, Jul 09 2013, Jeremie Samuel wrote:
>> @@ -118,7 +119,7 @@ struct sdhci_host {
>>   	enum led_brightness brightness;
>>   #endif
>>   
>> -	spinlock_t lock;	/* Mutex */
>> +	struct mutex lock;	/* Mutex */
>>   
>>   	int flags;		/* Host attributes */
>>   #define SDHCI_USE_SDMA		(1<<0)	/* Host is SDMA capable */
> I think you need to modify many of the drivers/mmc/host/sdhci-*
> drivers too -- for example:
>
> sdhci-pxav3.c:
>
> static int sdhci_pxav3_runtime_suspend(struct device *dev)
> {
>          struct sdhci_host *host = dev_get_drvdata(dev);
>          struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>          unsigned long flags;
>
>          if (pltfm_host->clk) {
>                  spin_lock_irqsave(&host->lock, flags);
> [...]
>
>
> sdhci-s3c.c:
>
> static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
> {
>          struct sdhci_host *host = platform_get_drvdata(dev);
> #ifdef CONFIG_PM_RUNTIME
>          struct sdhci_s3c *sc = sdhci_priv(host);
> #endif
>          unsigned long flags;
>
>          if (host) {
>                  spin_lock_irqsave(&host->lock, flags);
> [...]
>
>
> Thanks,
>
> - Chris.

