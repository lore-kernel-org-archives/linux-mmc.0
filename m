Return-Path: <SRS0=RpB2=DG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C960DC4346E
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Sep 2020 08:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7370420759
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Sep 2020 08:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeWdKp0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgI2Icb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Sep 2020 04:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgI2Ica (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Sep 2020 04:32:30 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF52C061755;
        Tue, 29 Sep 2020 01:32:30 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d6so3793061pfn.9;
        Tue, 29 Sep 2020 01:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DYjZtwFq2L9ODgZVruIDHZD1toUiu3MKxRUMakYMWRU=;
        b=FeWdKp0cQSjJN/b3lNofZspZaUqJ1xmZBCJeFWNVxJK5m1jFEWKLosAu+xzSYXaXls
         KsAyM70BbFfxL/t8kG4vNnfIcVTBJcT8H1yXoWaNWSry/ANWA1tDgGX6Qv9tOO/NnWIb
         AftK/Br/DTPtTMgcNJGwERcEQU1JAj+Us3f3JNg6hCYauFca444Er8KnADs6e58ppwBv
         +n1eBdHmo+IZY7/XqbNPahtqvImr5u5d9f4iwWd2arv4Bi11HaMUzrjQUXaAhPMbaVTc
         PZOrjholSfG83IPmUP+ve7USkuxIrQE3ccqNkvu1OmrWH+xnzO9++NvaM+G1JPLiTktc
         eV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DYjZtwFq2L9ODgZVruIDHZD1toUiu3MKxRUMakYMWRU=;
        b=kZGrXl91xQcxekaG3He4dsLCHAgn5SSXpJIu9B9crg69o6YG2g62gTjnMazC+Ot0jl
         Yozo0si6IXzw/9VwgMT8+Y5wt10MPrLy+Vc/4HG2XP45YqagJg1njeyHxYtKrzo6Qm1g
         hTcPO1CuxsOd3QhhsOLRMWSPg0Z87CzFgs7dpMFBWKM5yqX1FMj3kuxW0vaoVwNG2o53
         YGurZ76RjEh9HnK1bPlA2ah27Blxx4GJS+Yj3SKLz10tl/+6MN08v0Zu6f+VF9F5gdlq
         fF+S7yPJoBR3iGWhtNARy3k6t29t7a+awDzVQ6aXXaKDaeZ2E+jQYBBrVrLawjDsvFjb
         iGnA==
X-Gm-Message-State: AOAM533rc15HCOCdonFyGTPvDBS3NP/1t4ewFuJMuoUcTSoDF1M1aFC+
        6qi5zgX4wm6/92Bjk1tBr+o=
X-Google-Smtp-Source: ABdhPJw2nceW5g+34FtHTjROn02MB3Gw+F0Nr3MztE6s2E9M+UpdsMe5B99y7mflzmBMfmU4S8/COA==
X-Received: by 2002:a65:410c:: with SMTP id w12mr2390169pgp.411.1601368350179;
        Tue, 29 Sep 2020 01:32:30 -0700 (PDT)
Received: from ?IPv6:2402:b801:2840:8200:cc15:dbc:89f1:a9a5? ([2402:b801:2840:8200:cc15:dbc:89f1:a9a5])
        by smtp.gmail.com with ESMTPSA id 22sm4425686pfw.17.2020.09.29.01.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 01:32:29 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] mmc: host: meson-gx-mmc: fix possible deadlock
 condition for preempt_rt
To:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bigeasy@linutronix.de
References: <20200927025418.12382-1-bjharper@gmail.com>
 <20200927025418.12382-2-bjharper@gmail.com> <7hwo0dmnbt.fsf@baylibre.com>
From:   Brad Harper <bjharper@gmail.com>
Message-ID: <aaf796cc-7e6e-2831-5b13-9654f8e6fc77@gmail.com>
Date:   Tue, 29 Sep 2020 18:32:24 +1000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <7hwo0dmnbt.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Kevin,

     I think you are right,  I don't have a good enough understanding to 
make this work so please disregard the patch.  I will take on 
Sebastian's advice and do some testing with 'threadirqs' parameter 
enabled in standard kernel to see if I can reproduce my original issue 
there.  I'm hoping Jerome might also be able to help with some time to 
find proper solution.

Many Thanks,

Brad.

On 29/09/2020 10:35 am, Kevin Hilman wrote:
> Brad Harper <bjharper@gmail.com> writes:
>
>> ---
>>   drivers/mmc/host/meson-gx-mmc.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> This patch still needs changelog summarizing the problem and what is
> being fixed by the patch.  Most of what's in the cover letter belongs
> here.
>
> The cover letter can be used to describe the history/background that you
> don't want in the patch itself.  Alternatviely, you could include that
> information in the a single patch email also because everything after
> the "---" line does not end up in git history.
>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index 08a3b1c05..3ba8f988d 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -146,6 +146,7 @@ struct sd_emmc_desc {
>>   };
>>   
>>   struct meson_host {
>> +	spinlock_t		lock;
>>   	struct	device		*dev;
>>   	struct	meson_mmc_data *data;
>>   	struct	mmc_host	*mmc;
>> @@ -1051,6 +1052,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
>>   	host->mmc = mmc;
>>   	host->dev = &pdev->dev;
>>   	dev_set_drvdata(&pdev->dev, host);
>> +	spin_lock_init(&host->lock);
> I'm confused about what this lock is intended to do.  You init it here,
> but it's never used anywhere.
>
>>   	/* The G12A SDIO Controller needs an SRAM bounce buffer */
>>   	host->dram_access_quirk = device_property_read_bool(&pdev->dev,
>> @@ -1139,7 +1141,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
>>   	       host->regs + SD_EMMC_IRQ_EN);
>>   
>>   	ret = request_threaded_irq(host->irq, meson_mmc_irq,
>> -				   meson_mmc_irq_thread, IRQF_ONESHOT,
>> +				   meson_mmc_irq_thread, 0,
>>   				   dev_name(&pdev->dev), host);
>>   	if (ret)
>>   		goto err_init_clk;
> Kevin
