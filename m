Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B496C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Dec 2020 12:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C62CD22209
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Dec 2020 12:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgL3M1V (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Dec 2020 07:27:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:3083 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgL3M1U (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 30 Dec 2020 07:27:20 -0500
IronPort-SDR: SsEsZPna0mmIbpasSThKR3t9AbILB9ygSkPnnd6qCE1a8Ge5fUNhnJNSiiYYCbFuPspeZP4Bnh
 VLjdcoFKnzGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9849"; a="163661995"
X-IronPort-AV: E=Sophos;i="5.78,461,1599548400"; 
   d="scan'208";a="163661995"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2020 04:26:38 -0800
IronPort-SDR: 9anj3X+IkFwsOrWCkuHZEh7C7RuGTgVCejDlBCyRSoQHwA9t1d/oBl6pSR1I7Ie7iS2l3SlAT7
 K0wEfpFgyI5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,461,1599548400"; 
   d="scan'208";a="347824893"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga008.fm.intel.com with ESMTP; 30 Dec 2020 04:26:36 -0800
Subject: Re: [RFC] how to support ADMA3 and emmc CQ and inline encryption at
 the same time
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
References: <20201229164602.2dd49d28@xhacker.debian>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <6cd19111-e4cd-6550-d841-96692498a6b6@intel.com>
Date:   Wed, 30 Dec 2020 14:26:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201229164602.2dd49d28@xhacker.debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 29/12/20 10:46 am, Jisheng Zhang wrote:
> Hi,
> 
> Two patch series:
> 
> *emmc inline encryption
> Recently Eric sent out emmc inline encryption patches, per my understanding
> the emmc inline encryption based on CQ interface:cqhci.
> 
> *ADMA3 support
> Baolin send out ADMA3 support patches: https://lkml.org/lkml/2020/4/26/125
> which makes use of the ADMA3 transfer in mmc software queue.
> 
> Per my understanding, ADMA3 is focusing on the host side while the emmc CQ
> focuses on emmc card side, they don't conflict with each other. But current
> mmc_blk_cqe_issue_rw_rq() goes through either hsq or cqe code path but not both.
> 
> So how can ADMA3 and CQE be used at the same time?
> 
> Thanks in advance
> 

The mmc block driver has a CQE *interface* based around struct mmc_cqe_ops,
which was designed for JEDEC eMMC CQHCI.  CQHCI is a host side hardware
command queue engine and it now supports hardware inline encryption.  CQHCI
can only be used with eMMCs that support command queuing.

The mmc block driver CQE interface was later also adopted for a software
based queue called hsq.  hsq does not support eMMC command queuing.

Command queuing is an eMMC card feature.  It does not require CQHCI although
that is all we support at the moment.

ADMA3 is a hardware host-side interface that conflicts with CQHCI.  ADMA3
can be used with both SD cards and eMMC and does not require that a card
supports command queuing.
