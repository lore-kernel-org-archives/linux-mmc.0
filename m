From: Shawn Lin <shawn.lin@kernel-upstream.org>
Subject: Re: [RFC PATCH 2/4] mmc: core: implement enhanced strobe support
Date: Fri, 4 Mar 2016 10:00:52 +0800
Message-ID: <56D8EC54.7040902@kernel-upstream.org>
References: <1456972557-7994-1-git-send-email-shawn.lin@rock-chips.com>
 <1456972596-8077-1-git-send-email-shawn.lin@rock-chips.com>
 <56D83E09.70008@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:57479 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754648AbcCDCCr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Mar 2016 21:02:47 -0500
In-Reply-To: <56D83E09.70008@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Adrian,

On 2016/3/3 21:37, Adrian Hunter wrote:
> On 03/03/16 04:36, Shawn Lin wrote:
>> Controllers use data strobe line to latch data from devices
>> under hs400 mode, but not for cmd line. So from emmc 5.1, JEDEC
>> introduces enhanced strobe mode for latching cmd response from
>> emmc devices to host controllers. This new feature is optional.
>
> As I currently understand it, HS400ES does not require tuning.
> Consequently you can go straight to HS400ES and do not need to do
> HS200 first.  If that is the case then more changes are needed.
>

That's the case, and it's already in my plan before I going to remove
"RFC" prefix. From my experience of developing emmc-device firmware, the
only reason we need tuning for HS200 before we switch it into HS400
is that although data-line can be latched by DS but the cmd-line is 
still in SDR mode when runing in HS400. With hs400-es setuped, tuning
and retune stuff is meaningless. ALl the SI should be guranteed by HW
design to regulate the PCB payload.


> Also it would be nice if the transfer mode displayed reflected enhanced
> strobe e.g.

Great idea! And maybe more thing should be done for core/debugfs.c
It seems to big change for init_card, so I need more time to split my
step for changing it to make the change will not do any side effect from
non-hs400es procedure. :)

Thanks.

>
> 	Currently
>
> 		mmc1: new HS400 MMC card at address 0001
>
> 	Change for enhance strobe supported
>
> 		mmc1: new HS400ES MMC card at address 0001
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

