Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A37C433DB
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Dec 2020 18:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ED3A207AB
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Dec 2020 18:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgL2SSZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Dec 2020 13:18:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:35300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgL2SSZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 29 Dec 2020 13:18:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACEB622209;
        Tue, 29 Dec 2020 18:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609265864;
        bh=qNzWyO2lWrIFq1QXmuk1xZYt14R7Mp9KJ7sZYUbJij0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m/QI47hSsOLw8jS02YtznER3l34nORn2dcUiHjR4nqOAN2KcHYj4RaHuqR+wECbMW
         ObCkm0gUAG2qG+jRLzpL4EOkJagQtob1HO8VefopovgDy/iwLT9mpo1L1Tq6Egkutb
         Fh9rMk9KKweIKwz12n5r/SNVPRlVV9cdvriceKGw6ZU68p10eUaa1LvibxQo3tXFwt
         5pUFch2Kao1aSePruTIKP6+XnUOUWxu5AHL12KrgVNmshBmDJNe+ZeJwUHJobi82mb
         flzqU5SkalCws2supB0uAXFZYtd4w2CUzhuFzqcH92ewpK1cAUIZuOeOYY5uk4Hhft
         jbkASE+1NIYQA==
Date:   Tue, 29 Dec 2020 10:17:43 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [RFC] how to support ADMA3 and emmc CQ and inline encryption at
 the same time
Message-ID: <X+tyxxxjs/pNk85H@sol.localdomain>
References: <20201229164602.2dd49d28@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229164602.2dd49d28@xhacker.debian>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Dec 29, 2020 at 04:46:02PM +0800, Jisheng Zhang wrote:
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

Only the hardware CQE provides inline encryption support.  In particular, the
hardware interface to program keyslots uses the CQE registers, as does the
hardware interface to assign keyslots and DUNs to particular read/write
requests.  So my understanding is that eMMC inline encryption isn't compatible
with eMMC commands being issued in ways other than the hardware CQE, such as via
the HSQ (host software queue) feature, or via "packed requests".  So those
features can't be enabled in combination with inline encryption.

- Eric
