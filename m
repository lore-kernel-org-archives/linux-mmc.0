From: Chris Ball <cjb@laptop.org>
Subject: Re: eMMC bus test command failure
Date: Thu, 27 Jun 2013 10:51:51 -0400
Message-ID: <87ppv7r4hk.fsf@octavius.laptop.org>
References: <59606D77376AA44BB2E289FE5BA55046751CFA84@NTXXIAMBX01.xacn.micron.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37347 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751869Ab3F0Ov5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 10:51:57 -0400
In-Reply-To: <59606D77376AA44BB2E289FE5BA55046751CFA84@NTXXIAMBX01.xacn.micron.com>
	(Minjian Wu's message of "Mon, 27 May 2013 01:12:49 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Minjian Wu (minjianwu)" <minjianwu@micron.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

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
