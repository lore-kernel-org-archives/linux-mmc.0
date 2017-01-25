From: Tomas Melin <tomas.melin@vaisala.com>
Subject: Re: Question on mmc utils write reliability
Date: Wed, 25 Jan 2017 10:47:59 +0200
Message-ID: <7a5ff950-017c-5c87-9a14-bbf22a445771@vaisala.com>
References: <SN1PR0201MB1934E741FB1C67BC01D0DBE2C3720@SN1PR0201MB1934.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:39011 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdAYI55 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jan 2017 03:57:57 -0500
In-Reply-To: <SN1PR0201MB1934E741FB1C67BC01D0DBE2C3720@SN1PR0201MB1934.namprd02.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sean Straw <sstraw@enphaseenergy.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi,

+cc linux-mmc which is the correct forum for discussion on mmc-utils.
 
What version of mmc-utils are you using (exact commit)?
 
If I recall correctly, you also need to first configure enhanced mode(enh_area set) for the partition you want to enable write reliability on.
 
Thanks,
Tomas


On 01/23/2017 08:34 PM, Sean Straw wrote:
> Pardon the intrusion, but I can't locate a discussion forum for the tool, and have searched around and have been unable to find information on how to actually set the write reliability bit.  I see you contributed to the write_reliability feature, so presume you've probably actually used it.
> 
> 
> I have a number of ARM dev boards with a Micron eMMC part on them which I want to enable write reliability on.  If I attempt to set the bit - with -y, I always receive an error in the R1_SWITCH_ERROR.  If I power cycle and read the extcsd, it shows as being set (this for the user partition), but elsewhere the partitioning isn't complete.
> 
> 
> I just want the write reliability for the user partition (the defauly 93% or whatever of the flash capacity) - I'm not using flash-specific partitioning.
> 
> 
> 
> mmc write_reliability set -y 0 /dev/mmcblk0
> 
> 
> Done setting EXT_CSD_WR_REL_SET to 0x01 on /dev/mmcblk0
> setting OTP PARTITION_SETTING_COMPLETED!
> *Setting OTP PARTITION_SETTING_COMPLETED failed on /dev/mmcblk0***
> 
> 
> Note that I'm not getting an "device is already partitioned" or anything about the WR_REL_SET being read-only.
> 
> 
> Once set, I can do nothing to _unset_ it, so it seems reasonable that it's been stored in the OTP, but why the error when setting, and also in the extcsd:
> 
> 
> Partitioning Setting [PARTITION_SETTING_COMPLETED]: 0x00
>  *Device partition setting NOT complete*
> General Purpose Partition Size
>  [GP_SIZE_MULT_4]: 0x000000
>  [GP_SIZE_MULT_3]: 0x000000
>  [GP_SIZE_MULT_2]: 0x000000
>  [GP_SIZE_MULT_1]: 0x000000
> 
> 
> I need to finish setting up the devices so that I can put them to use, but I have no trust that the write reliability is in fact in effect because of the error.  I've been flailing with this for the past week.
> 
> 
> I appreciate any insight you can provide.
