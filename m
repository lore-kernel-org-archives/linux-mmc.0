Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EE4C38A2D
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Oct 2022 16:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiJYQzx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Oct 2022 12:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiJYQzd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2022 12:55:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9739570E70
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2022 09:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666716915; x=1698252915;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0z8tSnlEqGJKR4/7SAbXPdF6MP3BukYRkNdcJw8ZC64=;
  b=ksjgnLJsTBMG3kZBe71ho50L6CEAC8AIupGKa2WRkHamrcUFvTZdK9m+
   ypW5UYAK1WXfVAYVNCO8+n/N7rxw5zE6U+546n04dt+jDHAFBZazPwPRw
   RTxaeAXtpwW+HQHwaeCGY0QxBGgJmVuQ+YzYnrMukPH7W3WlrMIncb9jQ
   7QboWAWK5g+TTe4DAVv8L5kVzRnHemMfsNlZet1sCHVbLkvHvobExhJ6J
   dJ7n3FJSzZwvkTOD49KnIaYJcbm2izZezehZ9PlgOUHaKGo8Rx5rHo1pK
   0+E+tu0rRwCXNU6t005VhB7hzZVYIL21YeOamjL3DsKefgk8OTAPHGecK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="295136755"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="295136755"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 09:55:11 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="582844400"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="582844400"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.45.236])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 09:55:08 -0700
Message-ID: <534dfadc-5f68-df2a-6c85-c2c221d8c7e0@intel.com>
Date:   Tue, 25 Oct 2022 19:55:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: constant media change events - hardware or driver problem?
Content-Language: en-US
To:     Andreas Radke <andreas.radke@mailbox.org>,
        linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org
References: <20221025153602.3cacaae6@workstation64>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221025153602.3cacaae6@workstation64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/10/22 16:36, Andreas Radke wrote:
> My Zotac Ci323 system with builtin sd-card reader keeps firing off
> media change events" DISK_MEDIA_CHANGE=1". It may be a driver or
> hardware problem and was detected by some systemd changes introduced
> between v250 and v251. 
> Please have a look at https://github.com/systemd/systemd/issues/25021.
> 
> I've already updated to latest Zotac bios 2K210510. There's
> currently no related kernel module loaded due to blacklisting
> sdhci_pci/sdhci/cqhci/mmc_core modules.
> 
> I can stop the mess when inserting an unneeded sd-card into the slot.
> 
> lspci -vvs 00:10.0
> 00:10.0 SD Host controller: Intel Corporation Atom/Celeron/Pentium
> Processor x5-E8000/J3xxx/N3xxx Series MMC Controller (rev 21) (prog-if
> 01) Subsystem: ZOTAC International (MCO) Ltd. Device b301 Control: I/O-
> Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
> FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
>> TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency: 0, Cache Line
>> Size: 64 bytes Interrupt: pin A routed to IRQ 11
> 	Region 0: Memory at 81516000 (32-bit, non-prefetchable)
> [size=4K] Capabilities: [80] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold-) Status: D0 NoSoftRst+ PME-Enable-
> DSel=0 DScale=0 PME- Kernel modules: sdhci_pci
> 
> Can you help me to find out if there's something wrong in the linux
> kernel / maybe a driver or subsystem bug or if this a hardware issue?
> 
> Should I file some kernel bug?

I may be misreading this, but the device causing the media change events seems to be:

/devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5.1/1-5.1:1.0/host2/target2:0:0/2:0:0:0/block/sdb

and the driver is ums-realtek which is a USB Storage driver for "Realtek Card Reader support".

In that case it does not involve the kernel mmc subsystem at all.

As you listed above, there is an SD Host controller PCI device 00:10.0.
Is there a reason to think that it is also involved?

