Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC929C433B4
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Apr 2021 15:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFFE3610E5
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Apr 2021 15:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhDIPWv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:22:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:40763 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234059AbhDIPWv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 9 Apr 2021 11:22:51 -0400
IronPort-SDR: 2CsknCs59MWanh2O6j+eoy/aHGpJyrfaoULmsy4XK0T41ZelLCA3BOrOxplBSpjbD8Q1F9QcaC
 JAbN0DjSbBDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="255113669"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="255113669"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 08:22:37 -0700
IronPort-SDR: kAvV8NPktXh4c7UroL3NZQ457zgZALtZQMDKg2EkFAp9dUEvqtVNl/kk1htgb6HxNSeEPI8Z1R
 93C6w3IBviYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="520317158"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2021 08:22:36 -0700
Subject: Re: Question on HS400 timing sequence
To:     "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Cc:     linux-mmc@vger.kernel.org, Jasbeer.Singh@amd.com,
        Sudheesh.Mavila@amd.com
References: <e990824b-28c6-3624-3973-4f54c5764e44@amd.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <0c27d8cd-a102-8daa-dcd4-57647fff0f25@intel.com>
Date:   Fri, 9 Apr 2021 18:22:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e990824b-28c6-3624-3973-4f54c5764e44@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 9/04/21 5:19 pm, Shah, Nehal-bakulchandra wrote:
> Hi Adrian,
> 
> as per JESD84-B50 spec for EMMC 5.0 , HS400 timing sequence is following
> 
> In order to switch to HS400 mode, host should perform the following steps:
> 1) Initialize device with “Backward Compatible Timings”
> 2) Select the device with CMD7.
> 3) Read the DEVICE_TYPE [196] field of the Extended CSD register to validate whether the device supports HS400
> 4) Read the DRIVER_STRENGTH [197] field of the Extended CSD register to find the supported device Driver Strengths. (Note: This step may be skipped if changes of driver strength is not needed)
> 5) Set the “Selected Driver Strength” parameter in the HS_TIMING [185] field of the Extended CSD register to the appropriate driver strength for HS400 operation and set the “Timing Interface”
> parameter to 0x2 to switch to HS200 mode.
> 6) Perform the Tuning Process at the HS400 target operating frequency (Note: tuning process in HS200 mode is required to synchronize the command response on the CMD line to CLK for HS400 operation).
> 7) After the Tuning Process has completed, set the “Timing Interface” parameter in the HS_TIMING [185] field of the Extended CSD register to 0x3 to switch to HS400 mode.
> 
> But in case of JESD84-B51 spec  EMMC 5.1, HS400 timing sequence is following
> 
> 1 )Initialize device with “Backward Compatible Timings”,
> 2) Select the device with CMD7,
> 3) Read the DEVICE_TYPE [196] field of the Extended CSD register to validate whether the device
> supports HS400,
> 4) Read the DRIVER_STRENGTH [197] field of the Extended CSD register to find the supported
> device Driver Strengths,
> NOTE This step may be skipped if changes of driver strength is not needed.
> 5) Set the “Selected Driver Strength” parameter in the HS_TIMING [185] field of the Extended CSD
> register to the appropriate driver strength for HS400 operation and set the “Timing Interface”
> parameter to 0x2 to switch to HS200 mode,
> 6) Perform the Tuning Process at the HS400 target operating frequency,
> NOTE Tuning process in HS200 mode is required to synchronize the command response on the CMD line to
> CLK for HS400 operation.
> 7) Set the “Timing Interface” parameter in the HS_TIMING [185] field of the Extended CSD register to
> 0x1 to switch to High Speed mode and then set the clock frequency to a value not greater than 52
> MHz,
> 8) Set BUS_WIDTH[183] to 0x06 to select the dual data rate x8 bus mode,
> 9) Set the “Timing Interface” parameter in the HS_TIMING [185] field of the Extended CSD register to
> 0x3 to switch to HS400 mode.
> 
> So basically in case EMMC5.1 for HS400 mode selection, there is some difference after tuning. However driver
> existing driver always follow spec of EMMC5.1 . Is there any specific reason for the same? So on our some AMD platforms
> with EMMC5.0 driver is failing but if we modify the driver as per EMCC5.0 sequencing it is passing. So can you please provide
> your inputs?

Hi Nehal Shah

There was another specification between those two, namely JESD84-B50.1 eMMC 5.01 which has the same procedure as eMMC 5.1

AFAICT the 5.0 text was almost immediately "clarified" in 5.01 to match the 5.1 text.

So we have only 1 HS400 sequence.  But some host controllers do have issues, which is why there are additional hooks like ->hs400_downgrade() and ->hs400_prepare_ddr()

Regards
Adrian

