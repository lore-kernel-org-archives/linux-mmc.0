From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: HP Chromebook 13 G1 eMMC is broken since 4.12
Date: Mon, 9 Oct 2017 10:24:01 +0300
Message-ID: <e568ad32-588f-8506-c52b-57e42cc7cdeb@intel.com>
References: <CAKzrAgSR+j7-XeVEH4Db1nSyNtJAUOei1dfOvJuRKsUOzeoDeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:46593 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751735AbdJIHbK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 9 Oct 2017 03:31:10 -0400
In-Reply-To: <CAKzrAgSR+j7-XeVEH4Db1nSyNtJAUOei1dfOvJuRKsUOzeoDeQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ojab <ojab@ojab.ru>, linux-mmc@vger.kernel.org

On 07/10/17 03:16, ojab // wrote:
> [Please CC me, since I'm not subscribed to the list]
> 
> Oh hai!
> 
> Since linux-4.12 I have eMMC-related errors in dmesg and it's
> completely unusable (_very_ slow):
> 
> Oct 05 18:24:11 ojab-notebook kernel: print_req_error: I/O error, dev
> mmcblk0, sector 118656
> Oct 05 18:24:11 ojab-notebook dracut-initqueue[378]: /dev/mmcblk0p8:
> read failed after 0 of 4096 at 16711680: Input/output error
> Oct 05 18:24:11 ojab-notebook dracut-initqueue[378]: /dev/mmcblk0rpmb:
> read failed after 0 of 4096 at 4128768: Input/output error
> Oct 05 18:24:11 ojab-notebook dracut-initqueue[378]: /dev/mmcblk0rpmb:
> read failed after 0 of 4096 at 4186112: Input/output error
> Oct 05 18:24:11 ojab-notebook dracut-initqueue[378]: /dev/mmcblk0rpmb:
> read failed after 0 of 4096 at 0: Input/output error
> Oct 05 18:24:11 ojab-notebook dracut-initqueue[378]: /dev/mmcblk0rpmb:
> read failed after 0 of 4096 at 4096: Input/output error
> ...
> Oct 05 18:24:26 ojab-notebook kernel: mmc0: Timeout waiting for
> hardware interrupt.
> Oct 05 18:24:26 ojab-notebook kernel: mmc0: sdhci: ============ SDHCI
> REGISTER DUMP ===========
> Oct 05 18:24:26 ojab-notebook kernel: mmc0: sdhci: Sys addr:
> 0x00000008 | Version:  0x00001002
> Oct 05 18:24:26 ojab-notebook kernel: mmc0: sdhci: Blk size:
> 0x00007200 | Blk cnt:  0x00000008
> Oct 05 18:24:26 ojab-notebook kernel: mmc0: sdhci: Argument:
> 0x0001cf80 | Trn mode: 0x0000003b
> Oct 05 18:24:26 ojab-notebook kernel: mmc0: sdhci: Present:
> 0x1fff0001 | Host ctl: 0x0000003d
> Oct 05 18:24:26 ojab-notebook kernel: mmc0: sdhci: Power:
> 0x0000000b | Blk gap:  0x00000080
> Oct 05 18:24:26 ojab-notebook kernel: mmc0: sdhci: Wake-up:
> 0x00000000 | Clock:    0x00000007
> Oct 05 18:24:26 ojab-notebook kernel: mmc0: sdhci: Timeout:
> 0x00000005 | Int stat: 0x00000000
> Oct 05 18:24:26 ojab-notebook kernel: mmc0: sdhci: Int enab:
> 0x02ff000b | Sig enab: 0x02ff000b
> Oct 05 18:24:26 ojab-notebook kernel: mmc0: sdhci: AC12 err:
> 0x00000000 | Slot int: 0x00000000
> Oct 05 18:24:26 ojab-notebook kernel: mmc0: sdhci: Caps:
> 0x546ec881 | Caps_1:   0x80000807
> Oct 05 18:24:26 ojab-notebook kernel: mmc0: sdhci: Cmd:
> 0x0000123a | Max curr: 0x00000000
> Oct 05 18:24:26 ojab-notebook kernel: mmc0: sdhci: Resp[0]:
> 0x00000000 | Resp[1]:  0x00000000
> Oct 05 18:24:26 ojab-notebook kernel: mmc0: sdhci: Resp[2]:
> 0x00000000 | Resp[3]:  0x00001900
> Oct 05 18:24:26 ojab-notebook kernel: mmc0: sdhci: Host ctl2: 0x0000000d
> Oct 05 18:24:26 ojab-notebook kernel: mmc0: sdhci: ADMA Err:
> 0x00000000 | ADMA Ptr: 0x000000026de25200
> Oct 05 18:24:26 ojab-notebook kernel: mmc0: sdhci:
> ============================================
> Oct 05 18:24:26 ojab-notebook kernel: mmcblk0: error -84 sending
> status command, retrying
> Oct 05 18:24:26 ojab-notebook kernel: mmcblk0: error -110 sending stop
> command, original cmd response 0x0, card status 0x900
> Oct 05 18:24:26 ojab-notebook kernel: mmcblk0: error -110 transferring
> data, sector 118656, nr 8, cmd response 0x0, card status 0x0
> ...
> 
> `git bisect` told me that
> 
> c959a6b00ff589c652373e27bced5a700bd450f2 is the first bad commit
> commit c959a6b00ff589c652373e27bced5a700bd450f2
> Author: Adrian Hunter <adrian.hunter@intel.com>
> Date:   Mon Mar 20 19:50:34 2017 +0200
> 
>     mmc: sdhci-pci: Don't re-tune with runtime pm for some Intel devices
> 
>     Make use  of an Intel ACPI _DSM that indicates if re-tuning is needed after
>     D3.
> 
>     Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>     Tested-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> 
> :040000 040000 e6b59f520ed0beadb7e3ae609f237c2e4a03dfa1
> c9726a0a3ef41a9c59137bbc52a808a6c91e0d81 M      drivers
> 
> 
> It's HP Chromebook 13 G1 (CHELL) with stock firmware (SeaBIOS/legacy
> boot mode), vanilla kernel is used, `acpidump` output can be found in
> the attached file.

Please try this:

From: Adrian Hunter <adrian.hunter@intel.com>
Date: Mon, 9 Oct 2017 10:06:57 +0300
Subject: [PATCH] mmc: sdhci-pci: Fix default d3_retune for Intel host
 controllers

The default for d3_retune is true, but that was not being set in all cases,
which results in eMMC errors because re-tuning has not been done.
Fix by initializing d3_retune to true.

Reported-by: ojab <ojab@ojab.ru>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: c959a6b00ff5 ("mmc: sdhci-pci: Don't re-tune with runtime pm for some Intel devices")
Cc: stable@vger.kernel.org # v4.12+
---
 drivers/mmc/host/sdhci-pci-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 5f3f7b51299f..e854ee5d7f4a 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -448,6 +448,8 @@ static void intel_dsm_init(struct intel_host *intel_host, struct device *dev,
 	int err;
 	u32 val;
 
+	intel_host->d3_retune = true;
+
 	err = __intel_dsm(intel_host, dev, INTEL_DSM_FNS, &intel_host->dsm_fns);
 	if (err) {
 		pr_debug("%s: DSM not supported, error %d\n",
-- 
1.9.1
