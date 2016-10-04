From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: MMC timeout issue on 4.6 kernel
Date: Tue, 4 Oct 2016 15:20:07 +0300
Message-ID: <9c0524cd-ae12-4d5c-341c-2ec509a8b3b9@intel.com>
References: <4FF8F58FAA9D5D4193D4E554E4352C591CCBF88E@XAP-PVEXMBX02.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:39836 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751701AbcJDMYx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 4 Oct 2016 08:24:53 -0400
In-Reply-To: <4FF8F58FAA9D5D4193D4E554E4352C591CCBF88E@XAP-PVEXMBX02.xlnx.xilinx.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

On 04/10/16 12:03, Sai Krishna Potthuri wrote:
> Hi All,
> 
> With further debug, I am seeing the issue only with ADMA2, whereas SDMA and PIO mode are working fine.
> Can anyone help me on this issue?

You should use git bisect to find the failing commit.

What driver is it?

Does the problem still happen on 4.8? Or stable kernels?

> 
> Regards
> Sai Krishna
> 
>> -----Original Message-----
>> From: Sai Krishna Potthuri
>> Sent: Saturday, October 01, 2016 1:59 PM
>> To: 'linux-mmc@vger.kernel.org' <linux-mmc@vger.kernel.org>
>> Cc: 'Ulf Hansson' <ulf.hansson@linaro.org>
>> Subject: RE: MMC timeout issue on 4.6 kernel
>>
>> Hi,
>>
>> Any help
>>
>> Regards
>> Sai Krishna
>>
>>> -----Original Message-----
>>> From: Sai Krishna Potthuri
>>> Sent: Monday, September 26, 2016 10:29 PM
>>> To: linux-mmc@vger.kernel.org
>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>>> Subject: MMC timeout issue on 4.6 kernel
>>>
>>> Hi,
>>>
>>> With 4.6 kernel, I am doing regression test on SD which does following things.
>>> 1. Mount SD card.
>>> 2. Read and write random 1MB data.
>>> 3. Reboot the board.
>>>
>>> I am facing following error while reading the data from the SD card.
>>>
>>> mmc0: Timeout waiting for hardware interrupt.
>>> mmcblk0: error -110 transferring data, sector 8194, nr 2, cmd response
>>> 0x900, card status 0xb00
>>> mmc0: tried to reset card
>>> mmc0: Timeout waiting for hardware interrupt.
>>> mmcblk0: error -110 transferring data, sector 8194, nr 2, cmd response
>>> 0x900, card status 0xb00
>>> mmcblk0: retrying using single block read
>>> mmc0: Timeout waiting for hardware interrupt.
>>> mmcblk0: error -110 transferring data, sector 8194, nr 2, cmd response
>>> 0x900, card status 0x0
>>> blk_update_request: I/O error, dev mmcblk0, sector 8194
>>> mmc0: Timeout waiting for hardware interrupt.
>>> mmcblk0: error -110 transferring data, sector 8195, nr 1, cmd response
>>> 0x900, card status 0x0
>>> blk_update_request: I/O error, dev mmcblk0, sector 8195 EXT2-fs
>> (mmcblk0p1):
>>> error: unable to read superblock
>>> mmc0: Timeout waiting for hardware interrupt.
>>> mmcblk0: error -110 transferring data, sector 16387, nr 61, cmd
>>> response 0x900, card status 0xb00
>>> mmc0: tried to reset card
>>>
>>> Getting this error once in a while in regression test after several runs.
>>> I am not seeing this issue with 4.5 kernel.
>>> Please let me know if anyone has seen this issue.
>>>
>>> Regards
>>> Sai Krishna
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

