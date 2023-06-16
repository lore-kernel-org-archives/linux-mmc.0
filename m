Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBACEB64D8
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Jun 2023 10:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344017AbjFPKWp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Jun 2023 06:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344028AbjFPKWX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2023 06:22:23 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8414699
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 03:20:56 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id B004C847B6;
        Fri, 16 Jun 2023 12:20:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1686910854;
        bh=JH+sBGHyFnxhNIvZkEdfTbqOQkpVn2WDNdWKOJV3Kq4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lyfISihPOrn62UVJsPrjNvo9ftZWgfjOGLoYiIk7ESFwEjvFq+3z+0gWH6MQ+EMWf
         PFlYpNCncut6XzzTjtcTfR2MOEzBSWTCIZGDnQJRcaowpy0kC3fCup4sVDH+9UOxkr
         21XqYIGb4t9gu1euSUI9VWUqczv/T7uQpB9MsnHAh73svZMRPSroDg+PW35mJ1rWnt
         mL/PH+CynCYbCoP8PRyR26f4dXAdAE8c+kW6Fqz0EbwY6HUH2Q0TL/Jwp0a/BBTcRw
         I3bTmX/FnI7zhIhwxFW1FDopgQtvPhYTBW0ZR4PF5GNVzvCaNvafZkf283ViNCPcdt
         5ZCVM8SYOWW7A==
Message-ID: <4a8ae652-b930-3cd3-00df-c6dd1dd2a31d@denx.de>
Date:   Fri, 16 Jun 2023 12:20:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] [RFC] Revert "mmc: core: Fixup support for
 writeback-cache for eMMC and SD"
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org,
        =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        Avri Altman <avri.altman@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Wu <michael@allwinnertech.com>,
        Ming Lei <ming.lei@redhat.com>,
        Seunghui Lee <sh043.lee@samsung.com>, xander_li@kingston.com.tw
References: <20230531002740.1235620-1-marex@denx.de>
 <ecad717c-77b5-c78a-795b-2c3019b7452a@intel.com>
 <a69823e8-4e87-9eaa-1cb8-7d1457df1492@denx.de>
 <f41e1546-f6d3-7f4d-7662-3b7eca291178@intel.com>
 <29a5f24d-2b8c-8387-8c11-601af8e13940@denx.de>
 <4c8d84ae-c8d0-fa12-81c6-a47382684d73@intel.com>
 <3bd65a30-756d-e7ee-ce77-e5ebfe6b6e30@denx.de>
 <75ab27e9-9203-f59b-c720-99bfa992bb9b@intel.com>
 <b494062c-7e9e-24ba-ef0a-13faf0fe7706@denx.de>
 <a316b98e-fe56-23a3-7d58-13fcd5d9abb5@intel.com>
 <0029620e-4d22-d8f9-5566-4b1ea7f05bae@denx.de>
 <CAPDyKFoe0WWs2-wSETMZR5shjmWnLfD4GPwOXJNhyKd8xntq8A@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAPDyKFoe0WWs2-wSETMZR5shjmWnLfD4GPwOXJNhyKd8xntq8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/15/23 17:14, Ulf Hansson wrote:

I finally got around testing the other card, there are changes in CSD 
and SSR which indicate there was a HW change, but nothing significant. 
Considering we still have a non-working card sample size 1, I wonder 
whether I should just consider this card defective and archive it. Or 
would you prefer a quirk based on manufacturing date ? I am also CCing 
Xander, maybe they can check internally at Kingston .

Old 2019 card:
--------------
mmc1: host does not support reading read-only switch, assuming write-enable
mmc1: new ultra high speed SDR104 SDXC card at address 5048
mmcblk1: mmc1:5048 SD64G 58.0 GiB
  mmcblk1: p1

~ # grep -H . /sys/class/mmc_host/mmc1/mmc1\:5048/*
/sys/class/mmc_host/mmc1/mmc1:5048/cid:9f544953443634476136980065013b00
/sys/class/mmc_host/mmc1/mmc1:5048/csd:400e00325b590001cfff7f800a400000
/sys/class/mmc_host/mmc1/mmc1:5048/date:11/2019
/sys/class/mmc_host/mmc1/mmc1:5048/dsr:0x404
/sys/class/mmc_host/mmc1/mmc1:5048/erase_size:512
/sys/class/mmc_host/mmc1/mmc1:5048/fwrev:0x1
/sys/class/mmc_host/mmc1/mmc1:5048/hwrev:0x6
/sys/class/mmc_host/mmc1/mmc1:5048/manfid:0x00009f
/sys/class/mmc_host/mmc1/mmc1:5048/name:SD64G
/sys/class/mmc_host/mmc1/mmc1:5048/ocr:0x00300000
/sys/class/mmc_host/mmc1/mmc1:5048/oemid:0x5449
/sys/class/mmc_host/mmc1/mmc1:5048/preferred_erase_size:4194304
/sys/class/mmc_host/mmc1/mmc1:5048/rca:0x5048
/sys/class/mmc_host/mmc1/mmc1:5048/scr:0205848701006432
/sys/class/mmc_host/mmc1/mmc1:5048/serial:0x36980065
/sys/class/mmc_host/mmc1/mmc1:5048/ssr:000000000800000004009000011b391e000800000002ff0003000000000000000000000000000000000000000000000000000000000000000000000000000000
/sys/class/mmc_host/mmc1/mmc1:5048/type:SD
/sys/class/mmc_host/mmc1/mmc1:5048/uevent:DRIVER=mmcblk
/sys/class/mmc_host/mmc1/mmc1:5048/uevent:MMC_TYPE=SD
/sys/class/mmc_host/mmc1/mmc1:5048/uevent:MMC_NAME=SD64G
/sys/class/mmc_host/mmc1/mmc1:5048/uevent:MODALIAS=mmc:block

New 2023 card:
--------------
mmc1: host does not support reading read-only switch, assuming write-enable
mmc1: new ultra high speed SDR104 SDXC card at address 5048
mmcblk1: mmc1:5048 SD64G 58.0 GiB
  mmcblk1: p1

~ # grep -H . /sys/class/mmc_host/mmc1/mmc1\:5048/*
/sys/class/mmc_host/mmc1/mmc1:5048/cid:9f54495344363447614890060a017500
/sys/class/mmc_host/mmc1/mmc1:5048/csd:400e00325b590001cf9f7f800a400000
/sys/class/mmc_host/mmc1/mmc1:5048/date:05/2023
/sys/class/mmc_host/mmc1/mmc1:5048/dsr:0x404
/sys/class/mmc_host/mmc1/mmc1:5048/erase_size:512
/sys/class/mmc_host/mmc1/mmc1:5048/fwrev:0x1
/sys/class/mmc_host/mmc1/mmc1:5048/hwrev:0x6
/sys/class/mmc_host/mmc1/mmc1:5048/manfid:0x00009f
/sys/class/mmc_host/mmc1/mmc1:5048/name:SD64G
/sys/class/mmc_host/mmc1/mmc1:5048/ocr:0x00300000
/sys/class/mmc_host/mmc1/mmc1:5048/oemid:0x5449
/sys/class/mmc_host/mmc1/mmc1:5048/preferred_erase_size:4194304
/sys/class/mmc_host/mmc1/mmc1:5048/rca:0x5048
/sys/class/mmc_host/mmc1/mmc1:5048/scr:0205848701006432
/sys/class/mmc_host/mmc1/mmc1:5048/serial:0x4890060a
/sys/class/mmc_host/mmc1/mmc1:5048/ssr:000000000800000004009000010f391e000800000002ff0003000000000000000000000000000000000000000000000000000000000000000000000000000000
/sys/class/mmc_host/mmc1/mmc1:5048/type:SD
/sys/class/mmc_host/mmc1/mmc1:5048/uevent:DRIVER=mmcblk
/sys/class/mmc_host/mmc1/mmc1:5048/uevent:MMC_TYPE=SD
/sys/class/mmc_host/mmc1/mmc1:5048/uevent:MMC_NAME=SD64G
/sys/class/mmc_host/mmc1/mmc1:5048/uevent:MODALIAS=mmc:block

diff (-old 2019, +new 2023):
----------------------------
-/sys/class/mmc_host/mmc1/mmc1:5048/cid:9f544953443634476136980065013b00
-/sys/class/mmc_host/mmc1/mmc1:5048/csd:400e00325b590001cfff7f800a400000
-/sys/class/mmc_host/mmc1/mmc1:5048/date:11/2019
+/sys/class/mmc_host/mmc1/mmc1:5048/cid:9f54495344363447614890060a017500
+/sys/class/mmc_host/mmc1/mmc1:5048/csd:400e00325b590001cf9f7f800a400000
+/sys/class/mmc_host/mmc1/mmc1:5048/date:05/2023
  /sys/class/mmc_host/mmc1/mmc1:5048/dsr:0x404
  /sys/class/mmc_host/mmc1/mmc1:5048/erase_size:512
  /sys/class/mmc_host/mmc1/mmc1:5048/fwrev:0x1
@@ -18,10 +18,15 @@
  /sys/class/mmc_host/mmc1/mmc1:5048/preferred_erase_size:4194304
  /sys/class/mmc_host/mmc1/mmc1:5048/rca:0x5048
  /sys/class/mmc_host/mmc1/mmc1:5048/scr:0205848701006432
-/sys/class/mmc_host/mmc1/mmc1:5048/serial:0x36980065
-/sys/class/mmc_host/mmc1/mmc1:5048/ssr:000000000800000004009000011b391e000800000002ff0003000000000000000000000000000000000000000000000000000000000000000000000000000000
+/sys/class/mmc_host/mmc1/mmc1:5048/serial:0x4890060a
+/sys/class/mmc_host/mmc1/mmc1:5048/ssr:000000000800000004009000010f391e000800000002ff0003000000000000000000000000000000000000000000000000000000000000000000000000000000
  /sys/class/mmc_host/mmc1/mmc1:5048/type:SD
  /sys/class/mmc_host/mmc1/mmc1:5048/uevent:DRIVER=mmcblk
  /sys/class/mmc_host/mmc1/mmc1:5048/uevent:MMC_TYPE=SD
  /sys/class/mmc_host/mmc1/mmc1:5048/uevent:MMC_NAME=SD64G
  /sys/class/mmc_host/mmc1/mmc1:5048/uevent:MODALIAS=mmc:block

Changes:
--------
CID: PSN (serial number), MDT (manufacturing date)
CSD: C_SIZE: 0x1cfff -> 0x1cf9f
SSR: ERASE_TIMEOUT: 6 -> 3
