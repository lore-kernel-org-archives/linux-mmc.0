From: "Minjian Wu (minjianwu)" <minjianwu@micron.com>
Subject: RE: eMMC bus test command failure
Date: Wed, 24 Jul 2013 02:50:07 +0000
Message-ID: <59606D77376AA44BB2E289FE5BA55046751F550C@NTXXIAMBX01.xacn.micron.com>
References: <59606D77376AA44BB2E289FE5BA55046751CFA84@NTXXIAMBX01.xacn.micron.com>
 <87ppv7r4hk.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout.micron.com ([137.201.242.129]:20397 "EHLO
	mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab3GXCuV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Jul 2013 22:50:21 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Chris,
	Could you let me know how about this fix? Thank you!

-----Original Message-----
From: Minjian Wu (minjianwu) 
Sent: Monday, July 08, 2013 3:28 PM
To: 'Chris Ball'
Cc: linux-mmc@vger.kernel.org
Subject: RE: eMMC bus test command failure

Hi Chris,
	Sorry for the late response. Below is the patch based on Linux 3.8.4. Please help to check it. Thanks!

diff --git a/linux-3.8.4/drivers/mmc/core/mmc_ops.c b/linux-3.8_new/drivers/mmc/
index 6d8f701..a3ca845 100644
--- a/linux-3.8.4/drivers/mmc/core/mmc_ops.c
+++ b/linux-3.8_new/drivers/mmc/core/mmc_ops.c
@@ -560,6 +560,7 @@ mmc_send_bus_test(struct mmc_card *card, struct mmc_host *ho
        else
                data.flags = MMC_DATA_WRITE;
 
+       mmc_set_data_timeout(&data,card);
        data.sg = &sg;
        data.sg_len = 1;
        sg_init_one(&sg, data_buf, len);




-----Original Message-----
From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Chris Ball
Sent: Thursday, June 27, 2013 10:52 PM
To: Minjian Wu (minjianwu)
Cc: linux-mmc@vger.kernel.org
Subject: Re: eMMC bus test command failure

Hi Minjian,

On Sun, May 26 2013, Minjian Wu (minjianwu) wrote:
> Hi,
>
> 	I got one issue on Linux V3.7 as following.
>          > mmc0: switch to bus width 1 ddr 0 failed 
>          > mmc0: error -110 whilst initialising MMC card
>
>          After debugging and checking the source codes, we find that
> in mmc_send_bus_test function, there is no data timeout
> setting(mmc_set_data_timeout). After we add the timeout setting
> function, this issue is fixed, could you help confirm it? Thank you!

Please could you submit the patch you used?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
