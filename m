Return-Path: <SRS0=/V3P=7B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445CBC433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 10:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D27C20709
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 10:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgESK5P (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 May 2020 06:57:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:21143 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgESK5O (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 19 May 2020 06:57:14 -0400
IronPort-SDR: HOVmPEZlzAlMCjAVMOXiyELmIY/1BjJkLRixYekxhYGbA8m/bQe1bwt6TStyg9SeTZooFPuolX
 xIR+bssJ9ykw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 03:57:13 -0700
IronPort-SDR: 2Ru7e82J+azRLad8p2tCR+KZQXufvzyZSFptH1nFOg+Kqj/64E4f1JttxA3s8gBi6Ctn5MbMu/
 qufgEzlu4Mdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,409,1583222400"; 
   d="scan'208";a="288918543"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by fmsmga004.fm.intel.com with ESMTP; 19 May 2020 03:57:12 -0700
Subject: Re: Query on patch "7ff2760 mmc: core: Add a facility to "pause"
 re-tuning"
To:     "Y.b. Lu" <yangbo.lu@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc:     Sachin Miglani <sachin.miglani@nxp.com>
References: <AM7PR04MB6885850EAB3307DDA0C4FDC3F8B90@AM7PR04MB6885.eurprd04.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3d56b588-9519-ed36-4bbe-6929a9f5ee53@intel.com>
Date:   Tue, 19 May 2020 13:57:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <AM7PR04MB6885850EAB3307DDA0C4FDC3F8B90@AM7PR04MB6885.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 19/05/20 1:42 pm, Y.b. Lu wrote:
> Hi Uffe and Adrian,
> 
>  
> 
> May I have a query on below patch. Do we really need re-tuning before
> switching to RPMB partition each time per eMMC spec, especially for HS400
> mode with auto-tuning?

It was to ensure tuning would not be needed while accessing RPMB since RPMB
does not support tuning.

> 
> What’s the impact if no re-tuning here?

Increased risk of CRC errors.

> 
>  
> 
> 7ff2760 mmc: core: Add a facility to "pause" re-tuning
> 
>  
> 
> +/*
> 
> + * Pause re-tuning for a small set of operations.  The pause begins after the
> 
> + * next command and after first doing re-tuning.
> 
> + */
> 
> +void mmc_retune_pause(struct mmc_host *host)
> 
> +{
> 
> +       if (!host->retune_paused) {
> 
> +               host->retune_paused = 1;
> 
> +               mmc_retune_needed(host);
> 
> +               mmc_retune_hold(host);
> 
> +       }
> 
> +}
> 
>  
> 
> Thanks a lot.
> 
>  
> 
> Best regards,
> 
> Yangbo Lu
> 
>  
> 

