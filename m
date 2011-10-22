From: Andrei Warkentin <awarkentin@vmware.com>
Subject: Re: [PATCH] mmc: boot partition ro lock support
Date: Fri, 21 Oct 2011 18:44:36 -0700 (PDT)
Message-ID: <1817564019.180377.1319247876337.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
References: <1319203043-29388-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-outbound-1.vmware.com ([65.115.85.69]:26557 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751958Ab1JVBoh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Oct 2011 21:44:37 -0400
In-Reply-To: <1319203043-29388-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Per Forlin <per.forlin@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, John Beckett <john.beckett@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Hi Ulf, Johan,

----- Original Message -----
> From: "Ulf Hansson" <ulf.hansson@stericsson.com>
> To: linux-mmc@vger.kernel.org, "Chris Ball" <cjb@laptop.org>
> Cc: "Per Forlin" <per.forlin@stericsson.com>, "Ulf Hansson" <ulf.hansson@stericsson.com>, "Lee Jones"
> <lee.jones@linaro.org>, "Johan Rudholm" <johan.rudholm@stericsson.com>, "John Beckett" <john.beckett@stericsson.com>
> Sent: Friday, October 21, 2011 9:17:23 AM
> Subject: [PATCH] mmc: boot partition ro lock support
> 
> From: Johan Rudholm <johan.rudholm@stericsson.com>
> 
> Enable boot partitions to be power and permanently read-only locked
> via
> a sysfs entry. There will be one sysfs entry for the main mmc device:
> 
> /sys/block/mmcblkX/boot_partition_ro_lock
> 
> and one for each boot partition:
> 
> /sys/block/mmcblkXbootY/ro_lock
> 
> The boot partitions are power or permanently locked by writing
> "pwr_ro"
> or "perm_ro" to one of the files.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> Signed-off-by: John Beckett <john.beckett@stericsson.com>
> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
> ---

What does power locking do that force_ro currently doesn't achieve?

The permalocking brick-potential (more like paper-weight-potential) is IMO unacceptably
high that something like this is just accessible via a sysfs attribute. This is exactly
why the boot partitions were put under force_ro, so that some poor sap wouldn't end up
nuking the boot partitions (with obvious consequences), and permalocking seems even nastier.

At a bigger picture, I'm uncertain what the point of this is. It adds code complexity for,
a generally rare and possibly self-destructive operation. This is like the GP partitioning 
support - it's a once-a-time (and unrecoverable) operation usually done at manufacturing (or initial
provisioning time) that shouldn't be even exposed to the general purpose user. This would be a
good use of that arbitrary-CMD ioctl interface John Calixto put in.

Thanks,
A
