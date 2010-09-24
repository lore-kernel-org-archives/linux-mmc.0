From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] sdhci: allow controller private registers to be
 changaed on reset
Date: Fri, 24 Sep 2010 14:04:36 -0700
Message-ID: <97DF7AC4-AF36-47C6-B92B-3B5D13BCF968@marvell.com>
References: <3622567C-B5F4-40D4-A525-0AAE641E2B28@marvell.com>
 <73FAA3FF-6415-4A67-94FE-F93C3DA4A05C@marvell.com>
 <772C1381-0CF0-41CD-B580-CBD090BBA1AB@marvell.com>
 <20100924182652.59f38462@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:45466 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753591Ab0IXVE4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 24 Sep 2010 17:04:56 -0400
In-Reply-To: <20100924182652.59f38462@lxorguk.ukuu.org.uk>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>


Alan,

Cannot find you patch for sdhci.c for reset -- can you send it to me.  

The approach of having a reset call into the platform specific code is fine.  This is the way I implemented our code originally but ....   this was not felt when I did the code as the right direction to go in.  What I did in my code was call back into the driver reset and then reset the private registers.  I felt this gave me more control.

Philip


On Sep 24, 2010, at 10:26 AM, Alan Cox wrote:

> On Fri, 24 Sep 2010 09:42:15 -0700
> Philip Rakity <prakity@marvell.com> wrote:
> 
>>> From 9d64df0fa6874371446147f67c071e78c587c0d6 Mon Sep 17 00:00:00 2001
>> From: Philip Rakity <prakity@marvell.com>
>> Date: Fri, 24 Sep 2010 05:27:11 -0700
>> Subject: [PATCH] sdhci: allow controller private registers to be changaed on reset
>> 
>> allow controllers that have private registers that are reset when
>> the controller is reset. They need to be reprogrammed back to their
>> values when the reset happens.  Provide a hook to allow this to happen.
>> 
>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>> ---
>> drivers/mmc/host/sdhci.c |    3 +++
>> drivers/mmc/host/sdhci.h |    1 +
>> 2 files changed, 4 insertions(+), 0 deletions(-)
>> 
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 401527d..0774dad 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -174,6 +174,9 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
>> 
>> 	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
>> 		sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, ier);
>> +
>> +	if (host->ops->platform_specific_reset)
>> +		host->ops->platform_specific_reset(host, mask);
>> }
>> 
>> static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index d316bc7..f68af47 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -323,6 +323,7 @@ struct sdhci_ops {
>> 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
>> 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
>> 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
>> +	void	(*platform_specific_reset)(struct sdhci_host *host, u8 mask);
> 
> See the patches I posted earlier about reset. All of sdhci_reset could be
> cleaned up further by replacing sdhci_reset as a whole with a hookable
> interface, and the hook you propose isn't sufficient for the Intel
> devices, nor can it eliminate some of the other quirk flags.
> 
> Alan

