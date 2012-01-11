From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 2/2] mmc: sdhci: Deal with failure case in sdhci_suspend_host
Date: Wed, 11 Jan 2012 14:39:34 -0500
Message-ID: <m2mx9udo5l.fsf@bob.laptop.org>
References: <1325642863-8734-1-git-send-email-aaron.lu@amd.com>
	<4F0B001C.9010205@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38724 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757862Ab2AKTjp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 Jan 2012 14:39:45 -0500
In-Reply-To: <4F0B001C.9010205@intel.com> (Adrian Hunter's message of "Mon, 09
	Jan 2012 16:56:28 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Aaron Lu <aaron.lu@amd.com>, linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>

Hi,

On Mon, Jan 09 2012, Adrian Hunter wrote:
> On 04/01/12 04:07, Aaron Lu wrote:
>> V3: Rework on top of Adrian's vmmc patch
>> 
>> V2: Error processing code in sdhci_pci_suspend should not be deleted,
>> it is used to resume hosts which are already successfully suspended for
>> a multi slot pci device as suggested by Adrian.
>> 
>> If there are errors happened in sdhci_suspend_host, handle it so that
>> when the function returns with an error, the host's behaviour is the
>> same before this function call, e.g. card detection is enabled and
>> tuning timer is active, etc.
>> 
>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>> Signed-off-by: Aaron Lu <aaron.lu@amd.com>
>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, I'll push for 3.3 with Adrian's ACK and:

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a8f1f7e..0636e9a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2348,7 +2348,8 @@ out:
 
 int sdhci_suspend_host(struct sdhci_host *host)
 {
-	int ret, has_tuning_timer;
+	int ret;
+	bool has_tuning_timer;
 
 	sdhci_disable_card_detection(host);
 
- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
