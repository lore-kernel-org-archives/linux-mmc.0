Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C599C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Oct 2021 06:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1476960E0B
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Oct 2021 06:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhJZGEf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Oct 2021 02:04:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:44991 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229940AbhJZGEf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 26 Oct 2021 02:04:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="227283749"
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="227283749"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 23:02:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="596781073"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga004.jf.intel.com with ESMTP; 25 Oct 2021 23:02:09 -0700
Subject: Re: [ISSUE] ADMA issue when PAGE_SIZE=64K
To:     Bough Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jason Liu <jason.hui.liu@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <VI1PR04MB52948BCF8ACD0BB2BC1C51CB90839@VI1PR04MB5294.eurprd04.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <805f4341-4ab9-175d-bb78-f459cc627f6e@intel.com>
Date:   Tue, 26 Oct 2021 09:02:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB52948BCF8ACD0BB2BC1C51CB90839@VI1PR04MB5294.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/10/2021 11:59, Bough Chen wrote:
> Hi Ulf, Adrian
> 
> For mmc controllers with quirks SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC, it
> limit the max segment size as 64K-1.
> Currently, linux kernel support 4K/16K/64K PAGE_SIZE. If choose 64K
> PAGE_SIZE, sdhci in ADMA mode with the upper quirks will meet issue.
> Though mmc driver give block layer the max segment size through
> blk_queue_max_segment_size(), but in this function, it will compare the
> argument with PAGE_SIZE.
> In this case, finally the mmc request queue will get 64K as the max segment
> size. Once the sg data length=64K, ADMA will meet issue.
> 
> Find this issue on i.MX8MM-evk board, and I just notice omap/tegra/s3c also
> contain this quirks, seems a common issue.
> Should sdhci driver detect this case, and change to use SDMA mode
> automatically? Any thoughts?

It seems sensible to clear SDHCI_USE_ADMA in sdhci_setup_host() if it is
not going to work because of >= 64K page size.

> 
> 
> /block/blk-settings.c
> void blk_queue_max_segment_size(struct request_queue *q, unsigned int
> max_size)
> {
>          if (max_size < PAGE_SIZE) {
>                  max_size = PAGE_SIZE;
>                  printk(KERN_INFO "%s: set to minimum %d\n",
>                         __func__, max_size);
>          }
> 
>          /* see blk_queue_virt_boundary() for the explanation */
>          WARN_ON_ONCE(q->limits.virt_boundary_mask);
> 
>          q->limits.max_segment_size = max_size;
>  }
>  EXPORT_SYMBOL(blk_queue_max_segment_size);
> 
> 
> 
> Best Regards
> Haibo Chen
> 
> 

