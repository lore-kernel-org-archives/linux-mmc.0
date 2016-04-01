From: Naveen Kumar P <naveenkumar.parna@gmail.com>
Subject: Re: [PATCH] mmc: core: Fix bug on signal voltage switch failure
Date: Fri, 1 Apr 2016 14:15:53 +0530
Message-ID: <CAMciSVWWsoSny5dJXw2p9DLYie2YZmAb3Yk5YewpwbK-QjBWow@mail.gmail.com>
References: <1459433831-4162-1-git-send-email-naveenkumar.parna@gmail.com>
	<56FE2344.6060702@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36189 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbcDAIpy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Apr 2016 04:45:54 -0400
In-Reply-To: <56FE2344.6060702@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, chris@printf.net, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Apr 1, 2016 at 12:59 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 31/03/16 17:17, Naveen Kumar Parna wrote:
>> When switching SD and SDIO cards from 3.3V to 1.8V signal level fails, a bug in sdhci_set_power() will trigger.
>> To fix the kernel crash during recovery from signal voltage switch failure, OCR should be reset to avail voltage mask before power-cycle the card.
>>
>> Signed-off-by: Naveen Kumar Parna <naveenkumar.parna@gmail.com>
>> ---
>>  drivers/mmc/core/core.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index f26a5f1..e7eb427 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1477,6 +1477,8 @@ power_cycle:
>>       if (err) {
>>               pr_debug("%s: Signal voltage switch failed, "
>>                       "power cycling card\n", mmc_hostname(host));
>> +             /* Reset OCR mask */
>> +             ocr =  host->ocr_avail;
>>               mmc_power_cycle(host, ocr);
>>       }
>>
>>
>
>
> Is this the same as the following?
>
>
> commit d9bfbb95ed598a09cf336adb0f190ee0ff802f0d
> Author: Adrian Hunter <adrian.hunter@intel.com>
> Date:   Thu Nov 26 14:00:47 2015 +0200
>
>     mmc: sdio: Fix invalid vdd in voltage switch power cycle
>
>     The 'ocr' parameter passed to mmc_set_signal_voltage()
>     defines the power-on voltage used when power cycling
>     after a failure to set the voltage.  However, in the
>     case of mmc_sdio_init_card(), the value passed has the
>     R4_18V_PRESENT flag set which is not valid for power-on
>     and results in an invalid vdd.  Fix by passing the card's
>     ocr value which does not have the flag.
>
>     Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: stable@vger.kernel.org # v3.13+
>     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>


Yes, it is the same.

 [77342.349520] mmc0: clock 0Hz busmode 2 powermode 1 cs 0 Vdd 24
width 0 timing 0
 [77342.349561] ------------[ cut here ]------------
 [77342.349634] kernel BUG at
/build/buildd/linux-lts-utopic-3.16.0/drivers/mmc/host/sdhci.c:1242!
 [77342.349742] invalid opcode: 0000 [#1] SMP
 [77342.350677] CPU: 1 PID: 7673 Comm: kworker/u4:3 Tainted: G
W IOE 3.16.0-30-generic
 [77342.350968] Workqueue: kmmcd mmc_rescan
 [77342.351023] task: ffff8800b78b7010 ti: ffff8800b82fc000 task.ti:
ffff8800b82fc000
 [77342.351115] RIP: 0010:[<ffffffffc011ada8>]  [<ffffffffc011ada8>]
sdhci_do_set_ios+0x478/0x590 [sdhci]
 [77342.351242] RSP: 0018:ffff8800b82ffbd8  EFLAGS: 00010006
 [77342.351312] RAX: 0000000001000000 RBX: ffff8800b78ad500 RCX:
0000000000000018
 [77342.351400] RDX: ffffc9001074c000 RSI: 0000000000000000 RDI:
ffff8800b78ad500
 [77342.351488] RBP: ffff8800b82ffc08 R08: 0000000000000296 R09:
000000000005082c
 [77342.351576] R10: 0000000000000000 R11: ffff8800b82ff8a6 R12:
ffff8800b78ad33c
 [77342.351663] R13: ffff8800b78ad698 R14: 0000000000000296 R15:
0000000000000000
 [77342.351752] FS:  0000000000000000(0000) GS:ffff88013fd00000(0000)
knlGS:0000000000000000
 [77342.351853] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
 [77342.351925] CR2: 00000000017ca008 CR3: 0000000001c13000 CR4:
00000000000407e0
 [77342.352012] Stack:
 [77342.352013]  00188800b82ffc08 ffff8800b78ad000 ffff8800b78ad33c
0000000000000001
 [77342.352013]  0000000001200000 0000000000000000 ffff8800b82ffc28
ffffffffc011aef5
 [77342.352013]  ffff8800b78ad000 ffff8800b78ad33c ffff8800b82ffc70
ffffffff816001af
 [77342.352013] Call Trace:
 [77342.352013]  [<ffffffffc011aef5>] sdhci_set_ios+0x35/0x50 [sdhci]
 [77342.352013]  [<ffffffff816001af>] mmc_power_up+0x7f/0x2b0
 [77342.352013]  [<ffffffff8160055a>] mmc_power_cycle+0x3a/0x40
 [77342.352013]  [<ffffffff81600797>] mmc_set_signal_voltage+0x157/0x350
 [77342.352013]  [<ffffffff810b4e22>] ? complete_all+0x42/0x50
 [77342.352013]  [<ffffffff81607feb>] mmc_sdio_init_card+0x12b/0xbb0
 [77342.352013]  [<ffffffff81608f30>] mmc_attach_sdio+0x90/0x3e0
 [77342.352013]  [<ffffffff816010ab>] mmc_rescan+0x29b/0x320
 [77342.352013]  [<ffffffff81089ef2>] process_one_work+0x182/0x450
 [77342.352013]  [<ffffffff8108a663>] worker_thread+0x123/0x5a0
 [77342.352013]  [<ffffffff8108a540>] ? rescuer_thread+0x380/0x380
 [77342.352013]  [<ffffffff810912c2>] kthread+0xd2/0xf0
 [77342.352013]  [<ffffffff810911f0>] ? kthread_create_on_node+0x1c0/0x1c0
 [77342.352013]  [<ffffffff8176ac3c>] ret_from_fork+0x7c/0xb0
 [77342.352013]  [<ffffffff810911f0>] ? kthread_create_on_node+0x1c0/0x1c0
 [77342.352013] Code: 80 bb b6 01 00 00 00 0f 85 a2 fe ff ff 48 8b 43
38 c6 83 b6 01 00 00 01 48 8b 00 f0 ff 80 88 01 00 00 e9 88 fe ff ff
0f 1f 40 00 <0f> 0b 66 0f 1f 44 00 00 66 8b 52 2c 83 e2 fb 48 8b 4b 18
66 89
 [77342.352013] RIP  [<ffffffffc011ada8>] sdhci_do_set_ios+0x478/0x590 [sdhci]
 [77342.352013]  RSP <ffff8800b82ffbd8>
 [77342.397966] ---[ end trace 18d8c79ccd8e4e11 ]---

Thanks,
Naveen
