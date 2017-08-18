From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 00/13] mmc: Add Command Queue support
Date: Fri, 18 Aug 2017 14:03:32 +0300
Message-ID: <ac4d7a84-dbee-d789-e5d4-2191a201fcac@intel.com>
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com>
 <AM4PR0401MB2324B4E9B0818CCC3D70113090830@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8974 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750913AbdHRLKX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 18 Aug 2017 07:10:23 -0400
In-Reply-To: <AM4PR0401MB2324B4E9B0818CCC3D70113090830@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bough Chen <haibo.chen@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

On 17/08/17 10:45, Bough Chen wrote:
> 
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> owner@vger.kernel.org] On Behalf Of Adrian Hunter
>> Sent: Thursday, August 10, 2017 8:08 PM
>> To: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: linux-mmc <linux-mmc@vger.kernel.org>; Bough Chen
>> <haibo.chen@nxp.com>; Alex Lemberg <alex.lemberg@sandisk.com>;
>> Mateusz Nowak <mateusz.nowak@intel.com>; Yuliy Izrailov
>> <Yuliy.Izrailov@sandisk.com>; Jaehoon Chung <jh80.chung@samsung.com>;
>> Dong Aisheng <dongas86@gmail.com>; Das Asutosh
>> <asutoshd@codeaurora.org>; Zhangfei Gao <zhangfei.gao@gmail.com>;
>> Sahitya Tummala <stummala@codeaurora.org>; Harjani Ritesh
>> <riteshh@codeaurora.org>; Venu Byravarasu <vbyravarasu@nvidia.com>;
>> Linus Walleij <linus.walleij@linaro.org>; Shawn Lin <shawn.lin@rock-chips.com>
>> Subject: [PATCH V5 00/13] mmc: Add Command Queue support
>>
>> Hi
>>
>> Here is V5 of the hardware command queue patches without the software
>> command queue patches.
>>
>> HW CMDQ offers 25% - 50% better random multi-threaded I/O.  I see a slight 2%
>> drop in sequential read speed but no change to sequential write.
>>
>>
> Hi Adrian,
> 
> I test the performance on the i.MX8.  Here in my side, I use 'dd' to test the
> sequential read/write speed, see a slight 3% drop for both read and write.
> 
>     ---------------------------------------------
>    |               | read (KB/s)| write (KB/s) |
>    ---------------------------------------------
>     |CMDQ in HS400ES|    257     |     94.5     |
>     ---------------------------------------------
>     |    HS400ES    |    265     |     96.6     |
>     --------------------------------------------- 
> 
> For random multi-threaded I/O, I use 'fio'  to test, the test command:
> fio -filename=/mnt/test -direct=1 -iodepth 1 -thread -rw=randread - ioengine=psync  -bs=4k -size=2G -numjobs=10 -runtime=60  -group_reporting - name=mytest
> 
> I test 5 times, and get the average value.
> For CMDQ in HS400ES
>     ----------------------------------------------------
>     | block size   |    4KB    |    8KB    |    16KB   |
>     ----------------------------------------------------
>     | random read  | 26340KB/s | 51844KB/s | 85738KB/s |
>     ----------------------------------------------------
>     | random write | 12691KB/s | 15879KB/s | 17535KB/s |
>     ----------------------------------------------------
> 
> HS400ES without CMDQ
>     ----------------------------------------------------
>     | block size   |    4KB    |    8KB    |    16KB   |
>     ----------------------------------------------------
>     | random read  | 18585KB/s | 35041KB/s | 63880KB/s |
>     ----------------------------------------------------
>     | random write | 16465KB/s | 19210KB/s | 22672KB/s |
>     ----------------------------------------------------
> 
> For random write from the test, I find every test value differ greatly no matter enable CMDQ or not.
> 
>>From the test, I see CMDQ random read speed increase 34%~48%, but for random write, the speed 
> drop 17.4% ~ 33%.  
> 
> When you send software cmdq V5 patch, you give some explanation for the random write. But the
> average random write speed also drops a lot, I think it is now a good news, which need attention!

I tried your test and got quite variable results but did not see a drop:

CQ
                    4K           8K            16K
Random Write    10,374 KB/s   9,669 KB/s    10,712 KB/s


Non-CQ
                    4K           8K            16K
Random Write     9,898 KB/s   8,747 KB/s     9,098 KB/s


But given the variability of results I would not conclude CQ was faster.

I would suggest you run more tests and see if the trend continues.
