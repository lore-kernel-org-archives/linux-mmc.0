Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA78CC433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Nov 2022 08:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbiKHIUV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Nov 2022 03:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiKHIUU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2022 03:20:20 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A5F2DE3
        for <linux-mmc@vger.kernel.org>; Tue,  8 Nov 2022 00:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667895619; x=1699431619;
  h=message-id:date:mime-version:subject:to:references:cc:
   from:in-reply-to:content-transfer-encoding;
  bh=pQlnMMCIRyEi4cVteHCjIdZ89vgIq6S/6CwX7fJFQhM=;
  b=ZoDZJSGBofahMZtaB7VkW/qJHOXLJ8No0+lyrOzDQiyosbMtY26jYDeT
   +No1PfwlV025m4wpon3VNRKIkeSBGjg69IIH4pPRUL5FhaCVrMqJBuxWL
   VQJAp+eES7/ieWBYFcbqL/LrNEsG/+3QAnlVajhnks+HOhUf/jVsyoVB8
   mnsU0lxis2V1LVABcU47UV9zMgLRUXfyloyGcoYBvMorUTaZP3qvwFJgn
   Ps1ZbdITCKWs5vwGecLnGvUjKH5+Le1uotss07whoZfwwAJ8nua96piv6
   Q3YB3yfhiShjosFBCB9bIP+YEsElQkVvmEP2AhSs+BxxFEaixaqCsCErd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="291026087"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="291026087"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 00:20:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="725479003"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="725479003"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.56.164])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 00:20:18 -0800
Message-ID: <c97df3b4-0038-616d-ef10-953eba595638@intel.com>
Date:   Tue, 8 Nov 2022 10:20:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: Question about EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER
Content-Language: en-US
To:     =?UTF-8?B?SnlhbiBDaG91IFvlkajoirflrold?= <jyanchou@realtek.com>
References: <5842d536cb0d4086a225ea0fa2d42e72@realtek.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <5842d536cb0d4086a225ea0fa2d42e72@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 8/11/22 09:25, Jyan Chou [周芷安] wrote:
> Hello Adrian Hunter,
> 
> We are now using the upstream code of EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER, but we found that the existing driver cannot support the limitation of Synopsys IP.
> 
> Synopsys IP has a description on their data book " While using DMA, the host memory data buffer size and start address must not exceed 128 MB".
> 
> I am wondering whether there is a method or patch that can fix this boundary limitation.
> Thanks.
> Best Regards,
> Jyan Chou

Hello Jyan Chou

I am not clear on what the exact limitation is.  The driver never uses buffers as big as 128 MB.
To restrict DMA to low memory addresses a DMA mask can be used.

But perhaps you mean not to cross a 128 MB boundary?

Please cc your questions to the linux kernel mmc mailing list: linux-mmc@vger.kernel.org because others
can answer too.

Regards
Adrian
