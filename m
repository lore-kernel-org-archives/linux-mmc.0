From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: dw_mmc: busy check incomplete?
Date: Fri, 22 Sep 2017 23:39:34 +0800
Message-ID: <107466d9-f6da-6d4d-5b3c-abd0caa1d2ca@rock-chips.com>
References: <FD897F46D140444CAB8DC80B08F0742B0185AAEB0B@PFDE-MX10.EU.P-F.BIZ>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:50579 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751986AbdIVPkL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Sep 2017 11:40:11 -0400
In-Reply-To: <FD897F46D140444CAB8DC80B08F0742B0185AAEB0B@PFDE-MX10.EU.P-F.BIZ>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Goldschmidt Simon <sgoldschmidt@de.pepperl-fuchs.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, shawn.lin@rock-chips.com


On 2017/9/15 12:38, Goldschmidt Simon wrote:
> On 2017/9/14 09:49, Shawn Lin wrote:
>> On 2017/9/14 13:33, Goldschmidt Simon wrote:
>>> [..]
>>> I'm running 4.9.33-rt23 on a socfpga_cyclone5 with mmc-utils 0.1 (from
>>> debian strecth). However, checking the newest versions of both the
>>> kernel and mmc-utils, I do not see relevant changes.
>>
>> The situation of busy check was bad and all R1b shoule be handled by
>> core but not by individual host. dwmmc only handle some special
>> fsm busy internally noted by databook but left others for core.
>> Some improvement was introduced but I think you backport
>> all that for your 4.9 stock kernel if it doesn't contain these:
>>
>> mainline:  git log drivers/mmc,
>> from commit 20348d1981  ~  e173f8911f091f
>
> Reading the git log, those commits were before 4.9 final and I am
> running a stock 4.9.33 (only addition is the rt patch).
>
> I also just tested a clean 4.13.2 (no rt patch) and it shows the same
> result. Does that mean the dw_mmc driver handles R1b the wrong way?

Sorry for late.

Still think that should be part of mmc core's behaviour. I try to make
sure the following ugly patch could work for you? And we could move
forward later to see how to do it more gracefully.



@@ -546,6 +546,24 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card 
*card, struct mmc_blk_data *md,
                         return err;
         }

+       /*
+         * Don't try to rely on the host drivers to check the busy status
+         * and do it for here. Maybe it's worth more condiction check
+         * to see if this cmd use data line or not, as we could still 
support
+         * cmd in flight even the the device is busy, for instance CQE. 
Andt
+         * not sure how much time need to be a proper arbitrary, so bindly
+         * resort to MMC_BLK_TIMEOUT_MS. Also not sure if we need to take
+         * poll mathod if no card_busy available.
+         */
+       if (card->host->ops->card_busy) {
+               int tries = MMC_BLK_TIMEOUT_MS;
+               while (host->ops->card_busy(card->host) && --tries)
+                       mmc_delay(1);
+
+               if (tries == 0)
+                       return -ETIMEDOUT;
+       }


>
>
> Simon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>


-- 
Best Regards
Shawn Lin

