From: "Winkler, Tomas" <tomas.winkler@intel.com>
Subject: RE: [PATCH V2 0/3] mmc: block: Fix tuning (by avoiding it) for RPMB
Date: Wed, 4 May 2016 11:54:54 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B54257B9C@hasmsx108.ger.corp.intel.com>
References: <1462361893-11897-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:22806 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753075AbcEDLy7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2016 07:54:59 -0400
In-Reply-To: <1462361893-11897-1-git-send-email-adrian.hunter@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Hunter, Adrian" <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>



> -----Original Message-----
> From: Hunter, Adrian
> Sent: Wednesday, May 04, 2016 14:38
> To: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc <linux-mmc@vger.kernel.org>; Winkler, Tomas
> <tomas.winkler@intel.com>
> Subject: [PATCH V2 0/3] mmc: block: Fix tuning (by avoiding it) for RPMB
> 
> Hi
> 
> The RPMB partition only allows certain commands.  In particular, the tuning
> command (CMD21) is not allowed -  refer JEDEC eMMC standard v5.1 section
> 6.2.2 Command restrictions.
> 
> That means commands will begin failing if re-tuning is needed while switched
> to the RPMB partition.
> 
> As we discussed here:
> 
> 	http://marc.info/?l=linux-mmc&m=146218765801869
> 
> this patch set takes a new approach which is:
> 
> 	Re-tune before switching to the RPMB partition
> 	Don't allow re-tuning while switched to RPMB
> 	Switch back from the RPMB partition immediately
> 
> I gave it a brief test with a HS400 eMMC and using mmc utils to access RPMB.
> Despite all the partition switches and re-tuning in between, all RPMB
> operations were successful.
> 
> 
> Changes in V2:
> 
> 	New approach entirely
> 
> 
> Adrian Hunter (3):
>       mmc: core: Add a facility to "pause" re-tuning
>       mmc: block: Always switch back to main area after RPMB access
>       mmc: block: Pause re-tuning while switched to the RPMB partition
> 
>  drivers/mmc/card/block.c | 19 ++++++++++++++++++-
> drivers/mmc/core/host.c  | 22 ++++++++++++++++++++++
> include/linux/mmc/host.h |  4 ++++
>  3 files changed, 44 insertions(+), 1 deletion(-)
> 

The series looks good, it will be easy to adjust to my RPMB patch.
Thanks
Tomas



