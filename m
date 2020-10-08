Return-Path: <SRS0=iGfF=DP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF312C4363C
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 05:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F79217BA
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 05:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfFdEtFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgJHFLS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Oct 2020 01:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgJHFLS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Oct 2020 01:11:18 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDE5C061755;
        Wed,  7 Oct 2020 22:11:18 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h6so3260658pgk.4;
        Wed, 07 Oct 2020 22:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DGXqI+4Sh6rs8urwhC133dx8DNmlAjYdeCRk7jyHfZg=;
        b=OfFdEtFhTKkRCe5RhlJFEaguPGSub55q1j5ONalcOHYwpD35DWTogG8xfJy0GBysMo
         dxcYGiB8uyMdFWDnNUp7Hd1hPovvpAuxunu94srqIv0CH5Y6e48+RSphHQi8uqeyh8Da
         NR10jkXD0hVtDZjJIaqnPL+rlortGJ3JWWQUy4OcFaQj5dFCWB2MYVBCzgqh7XThOKLO
         XNUDKQBQ+/NmCUKSNM2WiorrxI9tZk3qOoqZxaHMhl/tTEx6ihRc1b8ABChignNYILSS
         RTfW+NoPm8MxlQ7BdzJigZFnU1+GryvjXu3yPndZip5zzdffGbaSC8zKCCstTDPilIbm
         viIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DGXqI+4Sh6rs8urwhC133dx8DNmlAjYdeCRk7jyHfZg=;
        b=HicVhaozVc1jqGgFcqKjzPZjoaVYA5zXYlzApN3Fl27GNr6i+sZsjJzZXYlDdQjjLl
         OPYjexN470cUdj1TiyFdTTNkLGhLrK8Z89Bjsn52ABl8FtmUYdgJHyWySedVis6OQJYq
         8f2YFVGrYaAYJe6ivr8BlzRAFrktJQNudCUSRxhoUSmOQ7QyR3QdK0oHkFLlsKfOT/jh
         u/ecJgTN1eM97il/CsmT036xVSTpurJQTFnIrJJnvIvD4SXcANESNLunDomxZocOAq0K
         cYjYYwvTNJbmwUuVHhVv8VE5wkobRiAFiV5I3Bi5fPZ172Qg0rD+jhp+5+/agMazWYhR
         zfiw==
X-Gm-Message-State: AOAM533IZ9F/wO5ArBMOwek7OwA5bSSL4pLT6vbSK6crjouNHC1NzbWG
        EUoF8bF3O07h81PFK6zjtms=
X-Google-Smtp-Source: ABdhPJycc1QbXjDu44U3IZ20piKXkYt9w5+DehGFEbkwhNjBd2/NDvFAV6yf0lZsSAksNGlo65uF5g==
X-Received: by 2002:a17:90a:73c9:: with SMTP id n9mr6194715pjk.90.1602133877705;
        Wed, 07 Oct 2020 22:11:17 -0700 (PDT)
Received: from ?IPv6:2402:b801:2840:8200:64bb:b626:4f99:bb54? ([2402:b801:2840:8200:64bb:b626:4f99:bb54])
        by smtp.gmail.com with ESMTPSA id k7sm4643537pjs.9.2020.10.07.22.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 22:11:17 -0700 (PDT)
Subject: Re: [PATCH] mmc: meson-gx: remove IRQF_ONESHOT
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
References: <e4e6cc45-bc18-40ec-035e-fdb45b9a8f46@gmail.com>
 <87o8lf74j5.fsf@nanos.tec.linutronix.de>
 <1jy2ki1db4.fsf@starbuckisacylon.baylibre.com>
From:   Brad Harper <bjharper@gmail.com>
Message-ID: <c8a8797e-a8ef-6d22-be76-97c27cea6819@gmail.com>
Date:   Thu, 8 Oct 2020 16:11:10 +1100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1jy2ki1db4.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 7/10/2020 10:32 pm, Jerome Brunet wrote:
> With arm64 defconfig on Khadas vim3, no obvious regression. Looks good.
>
> Tested-by: Jerome Brunet <jbrunet@baylibre.com>
>
> I did not test with RT. Brad, Could you let us know is Thomas's patch
> works for you ? Thx
There was a merge conflict in applying against v5.9-rc8-rt12 with
particular this patch:
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/kernel/irq/manage.c?h=linux-5.9.y-rt&id=18df00ef0b2b1513dc8f1a9ed26b11fff2261c30

I did manage to add the patch after attempting to resolve the conflict
which solves the deadlock issue I am seeing with mmc and works fine during
testing (a kernel compilation on preempt_rt configured kernel).

irq_thread in /kernel/irq/manage.c Looks like this (not 100% sure I
should have placed the irq_finalize_oneshot before
add_interrupt_randomness).

Based on this I can provide

Tested-by: Brad Harper <bjharper@gmail.com>

---
static int irq_thread(void *data)
{
         struct callback_head on_exit_work;
         struct irqaction *action = data;
         struct irq_desc *desc = irq_to_desc(action->irq);
         irqreturn_t (*handler_fn)(struct irq_desc *desc,
                         struct irqaction *action);

         if (force_irqthreads && test_bit(IRQTF_FORCED_THREAD,
&action->thread_flags))
                 handler_fn = irq_forced_thread_fn;
         else
                 handler_fn = irq_thread_fn;

         init_task_work(&on_exit_work, irq_thread_dtor);
         task_work_add(current, &on_exit_work, false);

         irq_thread_check_affinity(desc, action);

         while (!irq_wait_for_interrupt(action)) {
                 irqreturn_t action_ret;

                 irq_thread_check_affinity(desc, action);

                 action_ret = handler_fn(desc, action);
                 if (action_ret == IRQ_HANDLED)
                         atomic_inc(&desc->threads_handled);

                 if (action_ret == IRQ_WAKE_THREAD)
                         irq_wake_secondary(desc, action);

                 irq_finalize_oneshot(desc, action);

                 if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
                        migrate_disable();
                        add_interrupt_randomness(action->irq, 0,
                                 desc->random_ip ^ (unsigned long) action);
                        migrate_enable();
                 }
                 wake_threads_waitq(desc);
         }

         /*
          * This is the regular exit path. __free_irq() is stopping the
          * thread via kthread_stop() after calling
          * synchronize_hardirq(). So neither IRQTF_RUNTHREAD nor the
          * oneshot mask bit can be set.
          */
         task_work_cancel(current, irq_thread_dtor);
         return 0;
}

---

