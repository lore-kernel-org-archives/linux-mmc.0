Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBEDC433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Oct 2022 19:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJRTHA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Oct 2022 15:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiJRTG4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2022 15:06:56 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80B86E8B4
        for <linux-mmc@vger.kernel.org>; Tue, 18 Oct 2022 12:06:55 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 15C8F32000CC;
        Tue, 18 Oct 2022 15:06:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 18 Oct 2022 15:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666120014; x=1666206414; bh=ogx1Ik9GsH
        a565kB6576zAyqipkHSWO5bk1YRoygIFk=; b=BLNROm0aaldug8M7ZS0wvabS95
        zxWgO4Huz3pQoEC8SzixWLqUao1N7Wv0v4wNOSyT7ZA/tkxrhj1XxQjALmNS22rm
        UTG92cvOHkiJclMQbPEgV8LC4XxnLxfsyx5sbNR5DLX+K/Eb4lathpQnI70uXshF
        BjsWPCzN+nOumyYnVX3uznNA2LnVCvIzT+TjFdNwqCSz7nv0don4vQnFr1FFWnqL
        IyfwGm2qP/WyQJbWt/SX6ocTCRyIE7mUppDkNv1mpCNZUigNDkLS21uHwegj3tYJ
        mToVgXHY+E2YPF18fE19ZhmRE09PLJVBmWtzI5BGHMdbPP+1+0VUf/mvTi1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666120014; x=1666206414; bh=ogx1Ik9GsHa565kB6576zAyqipkH
        SWO5bk1YRoygIFk=; b=IL4Wzif5/oMlyHpK8Bj35eHgi0ATjowNnVsL2REBzDU6
        Y4vGhZ/Hks06shTBU6C9ejzWD/ArUoPmVIpvgIpshZ8KcGU6SFjj9Wy6jAI+H8Js
        mWFI3UBKIL0aiqFT9Ac1py60hLUkkJLAwFWVO5wQLM/meeOtzhix5XxIyop6ceiQ
        2qyfJv1LSoY1noy1qWWULTPoyBeHKSnbWOZ7PQgBsq/0f7NsVZArs/AIdHLS56Q0
        y5rVI1l2necdyYvc3Q1TRrYMcSb7k4pEv+C87+pEEaqItDeignRQBs4iuaUN/HDU
        598BGNQMi95v1QNbxeczRWzSDNuOhtqlNs4yx5KYMA==
X-ME-Sender: <xms:TvlOY3iE7fcCgFNd7VhUzUja27JyKQuAw44Fy0VXEmpTBti7N_x3dQ>
    <xme:TvlOY0BTu2uxkRUi8qnsP-x98KGMj_e1TEj_51F-jgr8BnmIeOPscF3pasmMv8ziB
    okXLxvOr6xqQp3FbPY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelvddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:TvlOY3FK7mEb6mPmC0YCL9hbEBu9t5YDnMfLD1Nhe7yc-0VK0MpquA>
    <xmx:TvlOY0SkZqz14Q0Gj8kGHpMFRfeRn_YzFnrtybM9qsP5F-ornu9mZQ>
    <xmx:TvlOY0zNPEJDO7Dr0XXqyT07RKZCKFfiuX_ELvW22H2WUdcgJ-qGnQ>
    <xmx:TvlOY_-3H-r0oGSJ_-s3KStq83Oa78sbQr4Vq393qdZ_XMKlUM6aRA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 52E1EB60086; Tue, 18 Oct 2022 15:06:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <a577dfcf-5a0a-4568-8f6d-872a8324dfcc@app.fastmail.com>
In-Reply-To: <20221018133800.10636-1-firas.ashkar@savoirfairelinux.com>
References: <20221018133800.10636-1-firas.ashkar@savoirfairelinux.com>
Date:   Tue, 18 Oct 2022 21:06:34 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Firas Ashkar" <firas.ashkar@savoirfairelinux.com>,
        alex@digriz.org.uk, "Ulf Hansson" <ulf.hansson@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] mmc: add TS7800 FPGA based MMC controller driver
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Oct 18, 2022, at 15:38, Firas Ashkar wrote:
> add standard mmc/host controller driver for TS-7800v1, instead of the
> original block based 'tssdcore' driver provided by EmbeddedTS linux-2.6.x
> code base.

I'm looking at this driver since Marc pointed me to your
work on the platform and I noticed this post as well.
Not doing a full review, but I'm still pointing out a few
issue that caught my eye.

> +
> +#define DRIVER_NAME "ts7800v1_sdmmc"

Maybe drop this macro and just use the string directly.

> +
> +	if (IS_ERR_OR_NULL(pslot->rw_dma_buf)) {
> +		dev_warn(mmc_dev(ts_sdmmc_host->mmc_host),
> +			 "%s|%d - Error, No allocated DMA read buffer %ld\n",
> +			 __func__, __LINE__, PTR_ERR(pslot->rw_dma_buf));
> +		*data_error = ret = -ENOMEM;
> +		goto done;
> +	}
> +
> +	dat0_sent_crc16_buf = kzalloc(sizeof(u16), GFP_KERNEL);
> +	if (IS_ERR_OR_NULL(dat0_sent_crc16_buf)) {

You should never need IS_ERR_OR_NULL, as all interfaces
in the kernel are supposed to either return an error code
or return NULL on error. Please fix the error handling
for this throughout the driver.

> + spin_lock_bh(&ts_sdmmc_host->bh_lock);

I'm a bit confused by your locking. Why do you use
spin_lock_bh() instead of a normal spin_lock() or
a spin_lock_irq()? I don't see any use of softirqs
(typically tasklets and timers) in this driver, so
disabling softirqs in the critical section should
not change anything.

     Arnd
