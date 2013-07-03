From: Krishna Konda <kkonda@codeaurora.org>
Subject: Re: Hynix eMMC RPMB: Access timeouts, broken?
Date: Tue, 02 Jul 2013 23:08:13 -0700
Message-ID: <51D3BFCD.4080603@codeaurora.org>
References: <51ADD03F.5030407@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:45752 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767Ab3GCGIP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Jul 2013 02:08:15 -0400
In-Reply-To: <51ADD03F.5030407@de.bosch.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 6/4/2013 4:32 AM, Dirk Behme wrote:
>
> Using some recent Hynix eMMC devices [1] on our Freescale i.MX6 boards
> we get harmless (?), but annoying access timeouts accessing the RPMB
> partition:
>
> mmcblk1rpmb: error -110 transferring data, sector 0, nr 32, cmd response
> 0x900, card status 0xb00
> mmcblk1rpmb: retrying using single block read
> ...
>
> The output with MMC debug enabled below [2].
>
> This seems to be harmless because it stops, but is annoying due to some
> auto mounter trying to access all available partitions.
>
The RPMB partition should never be mounted. Its not a regular partition
and does not a file system on it. So my suggestion would to be to modify
the auto mounter to not mount RPMB paritions.

-- 

Thanks,
Krishna Konda
-----------------------------------------------------------------------
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
-----------------------------------------------------------------------
