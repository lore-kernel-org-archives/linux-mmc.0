Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E05EB64D7
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 06:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjFTGqg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 02:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjFTGqd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 02:46:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FD51729
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jun 2023 23:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687243589; x=1718779589;
  h=message-id:date:mime-version:subject:to:references:cc:
   from:in-reply-to:content-transfer-encoding;
  bh=gT8RnILpWpIE13rmISbFgOLGhO1xm3+yldKPYflQ3ug=;
  b=k38C8SpogFa15d0gaEc23/Lq2W9L7uEJtjqKQskSvYDFYbj7VteH/EZM
   h3G5iEOQSF24tQIMvKcAXTH9A2J/66G5lViX/yuzUT7FgSVGD1Ef88hE7
   GBrDSoZmcoH8Y5a3QIvGm0N5WO8XsPW8rJ8B4RL1YWiTbBp7BvaBIMUK9
   qNQ9ITS1yRCaGmmbmHLFO0AHRyuQhiSN0NEMVypLbvHRkfanRcjnDAgf9
   iLs3CTwKUQlaFSx9MPxF48AAUApD3DDI8yl1Hvy5lrS0nUJKYIAtCbAYM
   U0HYBV6zg46JWmr4jwCou3b7OSGDsNzwDxCH8YVUe2eyj55SY3bjhJlCo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="363205584"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="363205584"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 23:46:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="779275267"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="779275267"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.49])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 23:46:26 -0700
Message-ID: <fee1c1af-8f03-375f-f75b-81f14e1ce038@intel.com>
Date:   Tue, 20 Jun 2023 09:46:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: Question about EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER
Content-Language: en-US
To:     =?UTF-8?B?SnlhbiBDaG91IFvlkajoirflrold?= <jyanchou@realtek.com>
References: <6d989a63463b4d1e8c1f468754f4f424@realtek.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <6d989a63463b4d1e8c1f468754f4f424@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/06/23 10:04, Jyan Chou [周芷安] wrote:
> Hello Adrian,
> 
>  
> 
> We had push one patch that would like to add a callback function in cqhci driver.
> 
> Due to the suggestion you gave us , we soon added our driver that implements ->setup_tran_desc() callback.
> 
> https://patchwork.kernel.org/project/linux-mmc/patch/20230616063731.17591-1-jyanchou@realtek.com/ <https://patchwork.kernel.org/project/linux-mmc/patch/20230616063731.17591-1-jyanchou@realtek.com/>

Why not add CQHCI support to dw_mmc.c ?

> 
> Do we need to push the setup_tran_desc() patch again, or can we use the patch below?
> 
> https://patchwork.kernel.org/project/linux-mmc/patch/20221116020012.19318-1-jyanchou@realtek.com/ <https://patchwork.kernel.org/project/linux-mmc/patch/20221116020012.19318-1-jyanchou@realtek.com/>

Please submit patches together as a patch set.

> 
>  
> 
> Please help to review the patch or give some advice.
> 
>  
> 
> Thanks a lot.
> 
>  
> 
> Best Regards,
> 
> Jyan
> 

