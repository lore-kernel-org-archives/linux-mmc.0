From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: core: select the operation mode with sysfs
Date: Sat, 04 Feb 2012 17:36:23 -0500
Message-ID: <m2mx8y9qfs.fsf@bob.laptop.org>
References: <4F17B530.6040809@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35523 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110Ab2BDWg3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 4 Feb 2012 17:36:29 -0500
In-Reply-To: <4F17B530.6040809@samsung.com> (Jaehoon Chung's message of "Thu,
	19 Jan 2012 15:16:16 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi,

On Thu, Jan 19 2012, Jaehoon Chung wrote:
> This patch is support the sysfs for operation mode.
>
> There are two operation modes(open-ended/pre-defined).
> Now, operation mode is selected only one at the compile time.
>
> But using this patch, we can change the operation mode with node at runtime.
>
> * pre-defined mode 
> echo 1 > /sys/class/mmc_host/mmc0/pre_defined_op  
> * open-ended mode
> echo 0 > /sys/class/mmc_host/mmc0/pre_defined_op  
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> Changelog v2:
> 	- Add the check point in mmc_cmd23_store()
> 	(If host controller didn't support CMD23, need not to change the ops-mode.)
>
>  drivers/mmc/card/block.c |   14 +++++++-------
>  drivers/mmc/core/host.c  |   41 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/host.h |    5 ++++-
>  3 files changed, 52 insertions(+), 8 deletions(-)

Patches that add sysfs nodes must come with documentation added to
Documentation/mmc/mmc-dev-attrs.txt.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
