From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: MMC Driver Throughput
Date: Thu, 31 Jan 2013 15:36:45 +0200
Message-ID: <510A736D.3090600@codeaurora.org>
References: <DB9374B0B2CB664D9425A1916C7DE85A36804AA8@NTXBOIMBX06.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:26633 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab3AaNgs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Jan 2013 08:36:48 -0500
In-Reply-To: <DB9374B0B2CB664D9425A1916C7DE85A36804AA8@NTXBOIMBX06.micron.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Bruce Ford (bford)" <bford@micron.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hello Bruce,
On 1/30/2013 8:35 PM, Bruce Ford (bford) wrote:
> Question:
>
> Has any testing been done to determine the maximum data throughput to/from
> a MMC device; assuming the MMC device takes zero time to complete tasks?
>
> Put another way - at what level of IOPS does the kernel/driver become the
> bottleneck, instead of the storage device?
This should depend on specific host controller, hardware and driver.
You can look from another end:

kernel/driver overhead = "Row max TPT of of the MMC device" - 
"lmdd/iozone/tiotest max TPT"

Where the row tpt can be found from card vendor data.

-- 
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

