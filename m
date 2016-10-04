From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: MMC timeout issue on 4.6 kernel
Date: Tue, 4 Oct 2016 15:59:03 +0300
Message-ID: <f44317a2-2238-8906-608c-3f45562a2c83@intel.com>
References: <4FF8F58FAA9D5D4193D4E554E4352C591CCBF88E@XAP-PVEXMBX02.xlnx.xilinx.com>
 <9c0524cd-ae12-4d5c-341c-2ec509a8b3b9@intel.com>
 <4FF8F58FAA9D5D4193D4E554E4352C591CCBF92A@XAP-PVEXMBX02.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:38177 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751549AbcJDNDu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 4 Oct 2016 09:03:50 -0400
In-Reply-To: <4FF8F58FAA9D5D4193D4E554E4352C591CCBF92A@XAP-PVEXMBX02.xlnx.xilinx.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, dianders@chromium.org, Soren Brinkmann <soren.brinkmann@xilinx.com>

On 04/10/16 15:41, Sai Krishna Potthuri wrote:
> Hi,
> 
>>
>> You should use git bisect to find the failing commit.
> It is failing after many successful runs, issue occurring in regression sometimes after 4 to 5hrs.
> So, it is taking lot of time to test a single commit. Anyway I will do this if I don't have any
> Other option.
>>
>> What driver is it?
> sdhci arasan driver(sdhci-of-arasan.c)

So let's cc some of the people who have worked on it.

>>
>> Does the problem still happen on 4.8? Or stable kernels?
> Tried on 4.7 kernel, didn't see the issue.

What about 4.5 stable? i.e. 4.5.7

> 
> Regards
> Sai Krishna
>>
>>>
>>> Regards
>>> Sai Krishna
>>>
>>>> -----Original Message-----
>>>> From: Sai Krishna Potthuri
>>>> Sent: Saturday, October 01, 2016 1:59 PM
>>>> To: 'linux-mmc@vger.kernel.org' <linux-mmc@vger.kernel.org>
>>>> Cc: 'Ulf Hansson' <ulf.hansson@linaro.org>
>>>> Subject: RE: MMC timeout issue on 4.6 kernel
>>>>
>>>> Hi,
>>>>
>>>> Any help
>>>>
>>>> Regards
>>>> Sai Krishna
>>>>
>>>>> -----Original Message-----
>>>>> From: Sai Krishna Potthuri
>>>>> Sent: Monday, September 26, 2016 10:29 PM
>>>>> To: linux-mmc@vger.kernel.org
>>>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>>>>> Subject: MMC timeout issue on 4.6 kernel
>>>>>
>>>>> Hi,
>>>>>
>>>>> With 4.6 kernel, I am doing regression test on SD which does following
>> things.
>>>>> 1. Mount SD card.
>>>>> 2. Read and write random 1MB data.
>>>>> 3. Reboot the board.
>>>>>
>>>>> I am facing following error while reading the data from the SD card.
>>>>>
>>>>> mmc0: Timeout waiting for hardware interrupt.
>>>>> mmcblk0: error -110 transferring data, sector 8194, nr 2, cmd response
>>>>> 0x900, card status 0xb00
>>>>> mmc0: tried to reset card
>>>>> mmc0: Timeout waiting for hardware interrupt.
>>>>> mmcblk0: error -110 transferring data, sector 8194, nr 2, cmd response
>>>>> 0x900, card status 0xb00
>>>>> mmcblk0: retrying using single block read
>>>>> mmc0: Timeout waiting for hardware interrupt.
>>>>> mmcblk0: error -110 transferring data, sector 8194, nr 2, cmd response
>>>>> 0x900, card status 0x0
>>>>> blk_update_request: I/O error, dev mmcblk0, sector 8194
>>>>> mmc0: Timeout waiting for hardware interrupt.
>>>>> mmcblk0: error -110 transferring data, sector 8195, nr 1, cmd response
>>>>> 0x900, card status 0x0
>>>>> blk_update_request: I/O error, dev mmcblk0, sector 8195 EXT2-fs
>>>> (mmcblk0p1):
>>>>> error: unable to read superblock
>>>>> mmc0: Timeout waiting for hardware interrupt.
>>>>> mmcblk0: error -110 transferring data, sector 16387, nr 61, cmd
>>>>> response 0x900, card status 0xb00
>>>>> mmc0: tried to reset card
>>>>>
>>>>> Getting this error once in a while in regression test after several runs.
>>>>> I am not seeing this issue with 4.5 kernel.
>>>>> Please let me know if anyone has seen this issue.
>>>>>
>>>>> Regards
>>>>> Sai Krishna
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
> 
> 
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
> 
> 

