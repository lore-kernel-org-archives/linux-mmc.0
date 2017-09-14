From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: dw_mmc: busy check incomplete?
Date: Thu, 14 Sep 2017 15:49:09 +0800
Message-ID: <fafd41ff-79fb-5cf6-41a8-2bedcbda4fde@rock-chips.com>
References: <FD897F46D140444CAB8DC80B08F0742B0185AAE994@PFDE-MX10.EU.P-F.BIZ>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:59218 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbdINHto (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Sep 2017 03:49:44 -0400
In-Reply-To: <FD897F46D140444CAB8DC80B08F0742B0185AAE994@PFDE-MX10.EU.P-F.BIZ>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Goldschmidt Simon <sgoldschmidt@de.pepperl-fuchs.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, shawn.lin@rock-chips.com



On 2017/9/14 13:33, Goldschmidt Simon wrote:
> Hi,
> 
> I stumbled accross what seems to be a bug in dw_mmc's busy check
> (implemented in dw_mci_wait_while_busy): repeatedly sending cmd 6
> (to write extcsd) results in a timeout. Here are the details:
> 
> When trying to set my eMMC to pSCL via "mmc-utils enhanced_area set",
> I get a command timeout error:
> 
> # mmc enh_area set -n 0 3792896 /dev/mmcblk0
> [ 3284.753472] dw_mmc ff704000.dwmmc0: __mmc_blk_ioctl_cmd: cmd error -110
> ioctl: Connection timed out
> Could not write 0x00 to EXT_CSD[139] in /dev/mmcblk0
> 
> Analysing the interface pins with an oscilloscope, I see that the eMMC
> asserts the busy condition after the first request (cmd 6: write
> EXT_CSD_ERASE_GROUP_DEF), which is expected (reading the JEDEC eMMC spec).
> 
> However, the dw_mmc host sends the next request before the eMMC is
> ready again (busy still asserted). So the eMMC does not handle the
> command and it times out. The dw_mmc host only checks the busy condition
> for commands including data, which cmd 6 doesn't. (This code has been
> added with commit 0bdbd0e "mmc: dw_mmc: Don't start commands while
> busy")
> 
> Always waiting for the busy condition to pass fixes this for me. But
> this is most probably not the correct fix, so the algorithm as to when
> checking the busy condition might probably have to be revised? I am not
> too familiar with other eMMC hosts and how they do this, though.
> 
> I'm running 4.9.33-rt23 on a socfpga_cyclone5 with mmc-utils 0.1 (from
> debian strecth). However, checking the newest versions of both the
> kernel and mmc-utils, I do not see relevant changes.

The situation of busy check was bad and all R1b shoule be handled by
core but not by individual host. dwmmc only handle some special
fsm busy internally noted by databook but left others for core.
Some improvement was introduced but I think you backport
all that for your 4.9 stock kernel if it doesn't contain these:

mainline:  git log drivers/mmc,
from commit 20348d1981  ~  e173f8911f091f


> 
> 
> As a side note, the JEDEC spec says the result of cmd6 should be read
> back after busy is deasserted. This is also not covered by the dw_mmc/
> mmc-utils combination. I wonder where this read-back should be
> implemented, in the driver or in mmc-utils? Or was this read-back
> left out on purpose?
> 
> 
> Thanks,
> Simon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

