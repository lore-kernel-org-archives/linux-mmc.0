Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC170EB64D8
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Jun 2023 06:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbjFNGjn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Jun 2023 02:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbjFNGj3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jun 2023 02:39:29 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232C71A5;
        Tue, 13 Jun 2023 23:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686724769; x=1718260769;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UqHs/WNrKGmP1bcfGdXzkdqfXtT6zONn0pOuB5yvCAg=;
  b=C07IK5egKKFRCmRuPh3HnjzeBAuBobiLOLf/g3jpP5dL/3YrfqIH0keu
   vnACYZR/sbs2Vrp5dEushH/Y2aNsNpnZd6wjqCWCUtBgZEk62VfOnWF5i
   HyG/o9tB3PoDXuNy2cDN2gzMZ/xLcUOHtM2Qo3cSnQVhueQmk8BmZJXqa
   C1OelqFHwuNOgza0V8fQTQYrKNVeGwCax+NbkUBptkwXvC80/UORuWiCH
   XQv+riXBArI2OQsOUS+FRGGC3EfKJZwvuMfLYDfXDIvXPOeY1BgQSmwfX
   Az+2rVsihpT+D8cTHw2+nbCZIFSgKTeci6HpRfH34BV/G863oDJbjfEsQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="338168698"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="338168698"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 23:39:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="958700649"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="958700649"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.240])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 23:39:26 -0700
Message-ID: <0b950bff-6796-636b-905d-e372cb4034c6@intel.com>
Date:   Wed, 14 Jun 2023 09:39:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH V1 1/2] mmc: sdhci-pci-o2micro: add Bayhub new chip GG8
 support
Content-Language: en-US
To:     Chevron Li <chevron_li@126.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        shirley.her@bayhubtech.com, chevron.li@bayhubtech.com
References: <20230607014812.30104-1-chevron_li@126.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230607014812.30104-1-chevron_li@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 7/06/23 04:48, Chevron Li wrote:
> From: Chevron Li <chevron.li@bayhubtech.com>
> 
> Add Bayhub new chip GG8 support for USHI function

USHI ? Should that be UHS-I

