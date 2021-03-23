Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AEEC433E3
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Mar 2021 15:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E45DB619BD
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Mar 2021 15:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhCWPlR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Mar 2021 11:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbhCWPlI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Mar 2021 11:41:08 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF82CC061574;
        Tue, 23 Mar 2021 08:41:07 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id y1so26169087ljm.10;
        Tue, 23 Mar 2021 08:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Y3SGVZu13EgCdo2JaEL55b8RhlSGf7jO2+zDyPGFEVc=;
        b=DIJdQSDWiHb/euo0wFq6Zwaq7Wl2MJFRp6GytAFNIGNuIhZkZycVcv+g+tL+C6v8xY
         i9Gv5PkG6QGMB4Oo5rZbH2vgW4QQAyQ+d9m2XfUzf6MULYJrF3Cp6+8PN6Dg6CEP6mS2
         Z14hBoIAJqjhqS/AYsAwhHbRl+PSXS7VVNSZZFsi07jeBnbNeradAQuLmrx3FN5Y/83w
         lFZNBWdW58yw2ZUQ97e+euYb8vgOS+VCSYr216t3FiG7urfv4+hEtRpVa1AlDhlbEH11
         c5Uq+ZlCFqpwLg5xesyuIGEmSsAWGl8m2jlEpUzc7jZMFz6Ei5W6TFJPYSDOLqkTrpvJ
         L8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Y3SGVZu13EgCdo2JaEL55b8RhlSGf7jO2+zDyPGFEVc=;
        b=F4QSlHWh7m7omfwxybskPAn7mdWbvQ8mNj4lGyipP97j0S/ul1B5iBMSXRUS+nd47B
         Gty+QBEFwaGfg43PP529jVT67bQ4jXswkLyjWErZABt4+Tfb3HMOkaNo052Nw5dF6+U6
         AqHe0nlimQK0XERG2xVSjrCD+Mp7Bjs0rmG9qzoRhiFcXGpSHrDbaOH5utDjdPwv1Cz4
         BG1GLTySjzYRzzv22O43+DKrzizEMUPcrGy8M9j+9l9PnhoeRMZpHIiXWFa5N0uZMFSF
         y8zkgvYpBfjQSAXV76zQ4BA970y5oorke4GERS7QTvLfuNWRh5uzLfLf/vcvPonsxotf
         dapA==
X-Gm-Message-State: AOAM530xySZFyNk5zIqN1xMaZ/24WZA3TxlRYz0c5KQ43Lc8yxzdMQUb
        euRvP4R0VMJfG1N65DRyHYFDWvH9HE66QedMmf0n49ojGMHx6B/GoQnqzw==
X-Google-Smtp-Source: ABdhPJwlwyWvyFF11fgvtcg7fs6rtJKUcGqIpSl6UQmhyzFQX+B1N3Exu00Nuo5A+bBUX5AcbwgAezd8kveuILrOHjY=
X-Received: by 2002:a2e:9793:: with SMTP id y19mr3386440lji.374.1616514066323;
 Tue, 23 Mar 2021 08:41:06 -0700 (PDT)
MIME-Version: 1.0
From:   xiang fei <liuxiang1999@gmail.com>
Date:   Tue, 23 Mar 2021 23:40:47 +0800
Message-ID: <CAPPcxxS+L7HDUUrfnEWYHAZWWCZ4S7GA0MSQioFbZZ4xEOyGcQ@mail.gmail.com>
Subject: Re:Re: [PATCH] mmc: block: use REQ_HIPRI flag to complete request
 directly in own complete workqueue
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, hch@lst.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

At 2021-02-06 00:22:21, "Christoph Hellwig" <hch@lst.de> wrote:
>On Fri, Feb 05, 2021 at 03:24:06PM +0100, Ulf Hansson wrote:
>> On Thu, 21 Jan 2021 at 09:13, Liu Xiang <liu.xiang@zlingsmart.com> wrote:
>> >
>> > After commit "40d09b53bfc557af7481b9d80f060a7ac9c7d314", request is
>> > completed in softirq. This may cause the system to suffer bad preemptoff
>> > time.
>> > The mmc driver has its own complete workqueue, but it can not work
>> > well now.
>> > The REQ_HIPRI flag can be used to complete request directly in its own
>> > complete workqueue and the preemptoff problem could be avoided.
>>
>> I am trying to understand all of the problem, but I don't quite get
>> it, sorry. Would it be possible for you to extend the description in
>> the commit message a bit?
>
>Yes, the message sounds weird.  The mentioned commit should obviously
>not make any difference for drivers not using it.
>
>> More exactly, what will happen if we tag a request with REQ_HIPRI
>> before completing it? Apologize for my ignorance, but I am currently a
>> bit overwhelmed with work, so I didn't have the time to really look it
>> up myself.
>
>Drivers must never set REQ_HIPRI!  This is a flag that is set by
>the submitter, and actually cleared for most drivers that don't support
>it by the block layer.


Sorry for not describing clearly in commit message.
I configure CONFIG_PREEMPT_TRACER and run iozone test with mmc driver.
This is the test result of the mainline:

# tracer: preemptoff
#
# preemptoff latency trace v1.1.5 on 5.11.0-rc4-ga95f9eb3f6cf
# --------------------------------------------------------------------
# latency: 1130504 us, #51247/49333412, CPU#3 | (M:preempt VP:0, KP:0,
SP:0 HP:0 #P:4)
#    -----------------
#    | task: ksoftirqd/3-27 (uid:0 nice:0 policy:0 rt_prio:0)
#    -----------------
#  => started at: __do_softirq
#  => ended at:   __do_softirq
#
#
#                    _------=> CPU#
#                   / _-----=> irqs-off
#                  | / _----=> need-resched
#                  || / _---=> hardirq/softirq
#                  ||| / _--=> preempt-depth
#                  |||| /     delay
#  cmd     pid     ||||| time  |   caller
#     \   /        |||||  \    |   /
ksoftirq-27        3.Ns1 1055999us : end_page_writeback <-ext4_finish_bio
ksoftirq-27        3.Ns1 1056000us : test_clear_page_writeback
<-end_page_writeback
ksoftirq-27        3.Ns1 1056002us : page_mapping <-test_clear_page_writeback
ksoftirq-27        3.Ns1 1056003us : lock_page_memcg <-test_clear_page_writeback
ksoftirq-27        3.Ns1 1056004us : __rcu_read_lock <-lock_page_memcg
ksoftirq-27        3.Ns1 1056006us : _raw_spin_lock_irqsave
<-test_clear_page_writeback
ksoftirq-27        3dNs1 1056007us : preempt_count_add <-_raw_spin_lock_irqsave
ksoftirq-27        3dNs2 1056009us : preempt_count_add
<-percpu_counter_add_batch
ksoftirq-27        3dNs3 1056010us : preempt_count_sub
<-percpu_counter_add_batch
ksoftirq-27        3dNs2 1056012us : preempt_count_add
<-percpu_counter_add_batch
ksoftirq-27        3dNs3 1056013us : preempt_count_sub
<-percpu_counter_add_batch
ksoftirq-27        3dNs2 1056014us : preempt_count_add
<-percpu_counter_add_batch
ksoftirq-27        3dNs3 1056016us : preempt_count_sub
<-percpu_counter_add_batch
ksoftirq-27        3dNs2 1056017us : preempt_count_add
<-percpu_counter_add_batch
ksoftirq-27        3dNs3 1056018us : preempt_count_sub
<-percpu_counter_add_batch
ksoftirq-27        3dNs2 1056020us : mem_cgroup_wb_domain
<-test_clear_page_writeback
ksoftirq-27        3dNs2 1056021us : _raw_spin_unlock_irqrestore
<-test_clear_page_writeback
ksoftirq-27        3.Ns2 1056023us : preempt_count_sub
<-_raw_spin_unlock_irqrestore
ksoftirq-27        3dNs1 1056025us : __mod_lruvec_state
<-test_clear_page_writeback
ksoftirq-27        3dNs1 1056026us : __mod_node_page_state <-__mod_lruvec_state
ksoftirq-27        3dNs1 1056027us : __mod_memcg_lruvec_state
<-__mod_lruvec_state
ksoftirq-27        3dNs1 1056029us : __mod_memcg_state
<-__mod_memcg_lruvec_state
ksoftirq-27        3.Ns1 1056031us : dec_zone_page_state
<-test_clear_page_writeback
ksoftirq-27        3.Ns1 1056032us : inc_node_page_state
<-test_clear_page_writeback
ksoftirq-27        3.Ns1 1056033us : __unlock_page_memcg
<-test_clear_page_writeback
ksoftirq-27        3.Ns1 1056035us : __rcu_read_unlock <-__unlock_page_memcg
ksoftirq-27        3.Ns1 1056036us : wake_up_page_bit <-end_page_writeback
ksoftirq-27        3.Ns1 1056037us : _raw_spin_lock_irqsave <-wake_up_page_bit
ksoftirq-27        3dNs1 1056039us : preempt_count_add <-_raw_spin_lock_irqsave
ksoftirq-27        3dNs2 1056041us : __wake_up_locked_key_bookmark
<-wake_up_page_bit
ksoftirq-27        3dNs2 1056042us : __wake_up_common
<-__wake_up_locked_key_bookmark
ksoftirq-27        3dNs2 1056043us : wake_page_function <-__wake_up_common
ksoftirq-27        3dNs2 1056044us : wake_up_state <-wake_page_function
ksoftirq-27        3dNs2 1056045us : try_to_wake_up <-wake_up_state
ksoftirq-27        3dNs2 1056047us : preempt_count_add <-try_to_wake_up
ksoftirq-27        3dNs3 1056048us : _raw_spin_lock_irqsave <-try_to_wake_up
ksoftirq-27        3dNs3 1056049us : preempt_count_add <-_raw_spin_lock_irqsave
ksoftirq-27        3dNs4 1056051us : select_task_rq_fair <-try_to_wake_up
ksoftirq-27        3dNs4 1056052us : __rcu_read_lock <-select_task_rq_fair
ksoftirq-27        3dNs4 1056053us : available_idle_cpu <-select_task_rq_fair
ksoftirq-27        3dNs4 1056055us : available_idle_cpu <-select_task_rq_fair
ksoftirq-27        3dNs4 1056056us : available_idle_cpu <-select_task_rq_fair
ksoftirq-27        3dNs4 1056057us : __rcu_read_unlock <-select_task_rq_fair
ksoftirq-27        3dNs4 1056059us : ttwu_queue_wakelist <-try_to_wake_up
ksoftirq-27        3dNs4 1056060us : _raw_spin_lock <-try_to_wake_up
ksoftirq-27        3dNs4 1056061us : preempt_count_add <-_raw_spin_lock
ksoftirq-27        3dNs5 1056062us : update_rq_clock.part.104 <-try_to_wake_up
ksoftirq-27        3dNs5 1056064us : ttwu_do_activate.isra.115 <-try_to_wake_up
ksoftirq-27        3dNs5 1056065us : __delayacct_blkio_end
<-ttwu_do_activate.isra.115
ksoftirq-27        3dNs5 1056066us : delayacct_end <-__delayacct_blkio_end
ksoftirq-27        3dNs5 1056068us : ktime_get <-delayacct_end
ksoftirq-27        3dNs5 1056069us : arch_counter_read <-ktime_get
ksoftirq-27        3dNs5 1056070us : _raw_spin_lock_irqsave <-delayacct_end
ksoftirq-27        3dNs5 1056072us : preempt_count_add <-_raw_spin_lock_irqsave
ksoftirq-27        3dNs6 1056073us : _raw_spin_unlock_irqrestore <-delayacct_end
ksoftirq-27        3dNs6 1056074us : preempt_count_sub
<-_raw_spin_unlock_irqrestore
ksoftirq-27        3dNs5 1056075us : enqueue_task_fair
<-ttwu_do_activate.isra.115
ksoftirq-27        3dNs5 1056077us : update_curr <-enqueue_task_fair
ksoftirq-27        3dNs5 1056078us : __update_load_avg_se <-update_load_avg
ksoftirq-27        3dNs5 1056080us : __update_load_avg_cfs_rq <-update_load_avg
ksoftirq-27        3dNs5 1056081us : update_cfs_group <-enqueue_task_fair
ksoftirq-27        3dNs5 1056082us : __enqueue_entity <-enqueue_task_fair
ksoftirq-27        3dNs5 1056084us : update_curr <-enqueue_task_fair
ksoftirq-27        3dNs5 1056085us : __update_load_avg_se <-update_load_avg
ksoftirq-27        3dNs5 1056086us : __update_load_avg_cfs_rq <-update_load_avg
ksoftirq-27        3dNs5 1056088us : update_cfs_group <-enqueue_task_fair
ksoftirq-27        3dNs5 1056089us : reweight_entity <-update_cfs_group
ksoftirq-27        3dNs5 1056090us : __enqueue_entity <-enqueue_task_fair
ksoftirq-27        3dNs5 1056092us : ttwu_do_wakeup.isra.114
<-ttwu_do_activate.isra.115
ksoftirq-27        3dNs5 1056093us : check_preempt_curr
<-ttwu_do_wakeup.isra.114
ksoftirq-27        3dNs5 1056095us : resched_curr <-check_preempt_curr
ksoftirq-27        3dNs5 1056096us : smp_send_reschedule <-resched_curr
ksoftirq-27        3dNs5 1056097us : smp_cross_call <-smp_send_reschedule
ksoftirq-27        3dNs5 1056098us : __ipi_send_mask <-smp_cross_call
ksoftirq-27        3dNs5 1056100us : gic_ipi_send_mask <-__ipi_send_mask
ksoftirq-27        3dNs5 1056101us : _raw_spin_unlock <-try_to_wake_up
ksoftirq-27        3dNs5 1056103us : preempt_count_sub <-_raw_spin_unlock
ksoftirq-27        3dNs4 1056104us : _raw_spin_unlock_irqrestore
<-try_to_wake_up
ksoftirq-27        3dNs4 1056105us : preempt_count_sub
<-_raw_spin_unlock_irqrestore
ksoftirq-27        3dNs3 1056107us : preempt_count_sub <-try_to_wake_up
ksoftirq-27        3dNs2 1056108us : _raw_spin_unlock_irqrestore
<-wake_up_page_bit
ksoftirq-27        3.Ns2 1056110us : preempt_count_sub
<-_raw_spin_unlock_irqrestore
ksoftirq-27        3.Ns1 1056112us : _raw_spin_lock_irqsave <-ext4_finish_bio
ksoftirq-27        3dNs1 1056113us : preempt_count_add <-_raw_spin_lock_irqsave
ksoftirq-27        3dNs2 1056115us : _raw_spin_unlock_irqrestore
<-ext4_finish_bio
ksoftirq-27        3.Ns2 1056117us : preempt_count_sub
<-_raw_spin_unlock_irqrestore
ksoftirq-27        3.Ns1 1056119us : end_page_writeback <-ext4_finish_bio
ksoftirq-27        3.Ns1 1056120us : test_clear_page_writeback
<-end_page_writeback
ksoftirq-27        3.Ns1 1056121us : page_mapping <-test_clear_page_writeback
ksoftirq-27        3.Ns1 1056122us : lock_page_memcg <-test_clear_page_writeback
ksoftirq-27        3.Ns1 1056124us : __rcu_read_lock <-lock_page_memcg
ksoftirq-27        3.Ns1 1056125us : _raw_spin_lock_irqsave
<-test_clear_page_writeback
ksoftirq-27        3dNs1 1056127us : preempt_count_add <-_raw_spin_lock_irqsave
ksoftirq-27        3dNs2 1056129us : preempt_count_add
<-percpu_counter_add_batch
ksoftirq-27        3dNs3 1056130us : preempt_count_sub
<-percpu_counter_add_batch
ksoftirq-27        3dNs2 1056131us : preempt_count_add
<-percpu_counter_add_batch
ksoftirq-27        3dNs3 1056132us : preempt_count_sub
<-percpu_counter_add_batch
ksoftirq-27        3dNs2 1056134us : preempt_count_add
<-percpu_counter_add_batch
ksoftirq-27        3dNs3 1056135us : preempt_count_sub
<-percpu_counter_add_batch
ksoftirq-27        3dNs2 1056136us : preempt_count_add
<-percpu_counter_add_batch
ksoftirq-27        3dNs3 1056138us : preempt_count_sub
<-percpu_counter_add_batch
ksoftirq-27        3dNs2 1056139us : mem_cgroup_wb_domain
<-test_clear_page_writeback
ksoftirq-27        3dNs2 1056140us : _raw_spin_unlock_irqrestore
<-test_clear_page_writeback
ksoftirq-27        3.Ns2 1056142us : preempt_count_sub
<-_raw_spin_unlock_irqrestore
ksoftirq-27        3dNs1 1056144us : __mod_lruvec_state
<-test_clear_page_writeback
ksoftirq-27        3dNs1 1056146us : __mod_node_page_state <-__mod_lruvec_state
ksoftirq-27        3dNs1 1056147us : __mod_memcg_lruvec_state
<-__mod_lruvec_state
ksoftirq-27        3dNs1 1056148us : __mod_memcg_state
<-__mod_memcg_lruvec_state
ksoftirq-27        3.Ns1 1056150us : dec_zone_page_state
<-test_clear_page_writeback
ksoftirq-27        3.Ns1 1056152us : inc_node_page_state
<-test_clear_page_writeback
ksoftirq-27        3.Ns1 1056153us : __unlock_page_memcg
<-test_clear_page_writeback
ksoftirq-27        3.Ns1 1056154us : __rcu_read_unlock <-__unlock_page_memcg
ksoftirq-27        3.Ns1 1056156us : _raw_spin_lock_irqsave <-ext4_finish_bio
ksoftirq-27        3dNs1 1056158us : preempt_count_add <-_raw_spin_lock_irqsave
ksoftirq-27        3dNs2 1056159us : _raw_spin_unlock_irqrestore
<-ext4_finish_bio
ksoftirq-27        3.Ns2 1056161us : preempt_count_sub
<-_raw_spin_unlock_irqrestore
ksoftirq-27        3.Ns1 1056163us : end_page_writeback <-ext4_finish_bio
ksoftirq-27        3.Ns1 1056164us : test_clear_page_writeback
<-end_page_writeback
ksoftirq-27        3.Ns1 1056165us : page_mapping <-test_clear_page_writeback
ksoftirq-27        3.Ns1 1056167us : lock_page_memcg <-test_clear_page_writeback
ksoftirq-27        3.Ns1 1056168us : __rcu_read_lock <-lock_page_memcg
ksoftirq-27        3.Ns1 1056169us : _raw_spin_lock_irqsave
<-test_clear_page_writeback
ksoftirq-27        3dNs1 1056171us : preempt_count_add <-_raw_spin_lock_irqsave
ksoftirq-27        3dNs2 1056173us : preempt_count_add
<-percpu_counter_add_batch
ksoftirq-27        3dNs3 1056174us : preempt_count_sub
<-percpu_counter_add_batch
ksoftirq-27        3dNs2 1056175us : preempt_count_add
<-percpu_counter_add_batch
ksoftirq-27        3dNs3 1056177us : preempt_count_sub
<-percpu_counter_add_batch
ksoftirq-27        3dNs2 1056178us : preempt_count_add
<-percpu_counter_add_batch
ksoftirq-27        3dNs3 1056179us : preempt_count_sub
<-percpu_counter_add_batch
ksoftirq-27        3dNs2 1056180us : preempt_count_add
<-percpu_counter_add_batch
ksoftirq-27        3dNs3 1056182us : preempt_count_sub
<-percpu_counter_add_batch
ksoftirq-27        3dNs2 1056183us : mem_cgroup_wb_domain
<-test_clear_page_writeback
ksoftirq-27        3dNs2 1056184us : _raw_spin_unlock_irqrestore
<-test_clear_page_writeback
ksoftirq-27        3.Ns2 1056186us : preempt_count_sub
<-_raw_spin_unlock_irqrestore
ksoftirq-27        3dNs1 1056188us : __mod_lruvec_state
<-test_clear_page_writeback
ksoftirq-27        3dNs1 1056190us : __mod_node_page_state <-__mod_lruvec_state
ksoftirq-27        3dNs1 1056191us : __mod_memcg_lruvec_state
<-__mod_lruvec_state
ksoftirq-27        3dNs1 1056192us : __mod_memcg_state
<-__mod_memcg_lruvec_state
ksoftirq-27        3.Ns1 1056194us : dec_zone_page_state
<-test_clear_page_writeback
ksoftirq-27        3.Ns1 1056196us : inc_node_page_state
<-test_clear_page_writeback
ksoftirq-27        3.Ns1 1056197us : __unlock_page_memcg
<-test_clear_page_writeback
ksoftirq-27        3.Ns1 1056198us : __rcu_read_unlock <-__unlock_page_memcg
ksoftirq-27        3.Ns1 1056200us : _raw_spin_lock_irqsave <-ext4_finish_bio
ksoftirq-27        3dNs1 1056202us : preempt_count_add <-_raw_spin_lock_irqsave
ksoftirq-27        3dNs2 1056204us : _raw_spin_unlock_irqrestore
<-ext4_finish_bio
ksoftirq-27        3.Ns2 1056207us : preempt_count_sub
<-_raw_spin_unlock_irqrestore
ksoftirq-27        3.Ns1 1056208us : end_page_writeback <-ext4_finish_bio
ksoftirq-27        3.Ns1 1056209us : test_clear_page_writeback
<-end_page_writeback
ksoftirq-27        3.Ns1 1056211us : page_mapping <-test_clear_page_writeback
ksoftirq-27        3.Ns1 1056212us : lock_page_memcg <-test_clear_page_writeback
ksoftirq-27        3.Ns1 1056213us : __rcu_read_lock <-lock_page_memcg
ksoftirq-27        3.Ns1 1056215us : _raw_spin_lock_irqsave
<-test_clear_page_writeback


This is the test result with the patch:

# tracer: preemptoff
#
# preemptoff latency trace v1.1.5 on 5.11.0-rc4-ga95f9eb3f6cf-dirty
# --------------------------------------------------------------------
# latency: 37647 us, #1084/1084, CPU#1 | (M:preempt VP:0, KP:0, SP:0 HP:0 #P:4)
#    -----------------
#    | task: kworker/1:1H-117 (uid:0 nice:-20 policy:0 rt_prio:0)
#    -----------------
#  => started at: __mutex_lock.isra.10
#  => ended at:   __mutex_lock.isra.10
#
#
#                    _------=> CPU#
#                   / _-----=> irqs-off
#                  | / _----=> need-resched
#                  || / _---=> hardirq/softirq
#                  ||| / _--=> preempt-depth
#                  |||| /     delay
#  cmd     pid     ||||| time  |   caller
#     \   /        |||||  \    |   /
kworker/-117       1...1    0us : __mutex_lock.isra.10 <-__mutex_lock.isra.10
kworker/-117       1...2    2us : __rcu_read_lock <-__mutex_lock.isra.10
kworker/-117       1...2    4us : __rcu_read_unlock <-__mutex_lock.isra.10
kworker/-117       1...2    5us : osq_lock <-__mutex_lock.isra.10
kworker/-117       1...2    7us : mutex_spin_on_owner <-__mutex_lock.isra.10
kworker/-117       1...2    9us!: __rcu_read_lock <-mutex_spin_on_owner
kworker/-117       1d..2  426us : gic_handle_irq <-el1_irq
kworker/-117       1d..2  427us : __handle_domain_irq <-gic_handle_irq
kworker/-117       1d..2  429us : irq_enter <-__handle_domain_irq
kworker/-117       1d..2  430us : irq_enter_rcu <-irq_enter
kworker/-117       1d..2  431us : preempt_count_add <-irq_enter_rcu
kworker/-117       1d.h2  433us : irqtime_account_irq <-irq_enter_rcu
kworker/-117       1d.h2  435us : irq_find_mapping <-__handle_domain_irq
kworker/-117       1d.h2  436us : generic_handle_irq <-__handle_domain_irq
kworker/-117       1d.h2  438us : handle_percpu_devid_irq <-generic_handle_irq
kworker/-117       1d.h2  439us : arch_timer_handler_phys
<-handle_percpu_devid_irq
kworker/-117       1d.h2  440us : hrtimer_interrupt <-arch_timer_handler_phys
kworker/-117       1d.h2  442us : _raw_spin_lock_irqsave <-hrtimer_interrupt
kworker/-117       1d.h2  443us : preempt_count_add <-_raw_spin_lock_irqsave
kworker/-117       1d.h3  444us : ktime_get_update_offsets_now
<-hrtimer_interrupt
kworker/-117       1d.h3  445us : arch_counter_read
<-ktime_get_update_offsets_now
kworker/-117       1d.h3  447us : __hrtimer_run_queues <-hrtimer_interrupt
kworker/-117       1d.h3  449us : __remove_hrtimer <-__hrtimer_run_queues
kworker/-117       1d.h3  450us : _raw_spin_unlock_irqrestore
<-__hrtimer_run_queues
kworker/-117       1d.h3  451us : preempt_count_sub
<-_raw_spin_unlock_irqrestore
kworker/-117       1d.h2  453us : tick_sched_timer <-__hrtimer_run_queues
kworker/-117       1d.h2  454us : ktime_get <-tick_sched_timer
kworker/-117       1d.h2  455us : arch_counter_read <-ktime_get
kworker/-117       1d.h2  457us : tick_sched_do_timer <-tick_sched_timer
kworker/-117       1d.h2  458us : tick_do_update_jiffies64 <-tick_sched_do_timer
kworker/-117       1d.h2  459us : _raw_spin_lock <-tick_do_update_jiffies64
kworker/-117       1d.h2  460us : preempt_count_add <-_raw_spin_lock
kworker/-117       1d.h3  462us : calc_global_load <-tick_do_update_jiffies64
kworker/-117       1d.h3  465us : _raw_spin_unlock <-tick_do_update_jiffies64
kworker/-117       1d.h3  466us : preempt_count_sub <-_raw_spin_unlock
kworker/-117       1d.h2  467us : update_wall_time <-tick_do_update_jiffies64
kworker/-117       1d.h2  469us : timekeeping_advance <-update_wall_time
kworker/-117       1d.h2  470us : _raw_spin_lock_irqsave <-timekeeping_advance
kworker/-117       1d.h2  472us : preempt_count_add <-_raw_spin_lock_irqsave
kworker/-117       1d.h3  473us : arch_counter_read <-timekeeping_advance
kworker/-117       1d.h3  474us : ntp_tick_length <-timekeeping_advance
kworker/-117       1d.h3  476us : ntp_tick_length <-timekeeping_advance
kworker/-117       1d.h3  478us : timekeeping_update <-timekeeping_advance
kworker/-117       1d.h3  479us : ntp_get_next_leap <-timekeeping_update
kworker/-117       1d.h3  481us : update_vsyscall <-timekeeping_update
kworker/-117       1d.h3  483us : raw_notifier_call_chain <-timekeeping_update
kworker/-117       1d.h3  485us : update_fast_timekeeper <-timekeeping_update
kworker/-117       1d.h3  486us : update_fast_timekeeper <-timekeeping_update
kworker/-117       1d.h3  487us : _raw_spin_unlock_irqrestore
<-timekeeping_advance
kworker/-117       1d.h3  489us : preempt_count_sub
<-_raw_spin_unlock_irqrestore
kworker/-117       1d.h2  490us : tick_sched_handle.isra.16 <-tick_sched_timer
kworker/-117       1d.h2  492us : update_process_times
<-tick_sched_handle.isra.16
kworker/-117       1d.h2  493us : account_process_tick <-update_process_times
kworker/-117       1d.h2  494us : irqtime_account_process_tick
<-account_process_tick
kworker/-117       1d.h2  496us : account_system_index_time
<-irqtime_account_process_tick
kworker/-117       1d.h2  497us : cpuacct_account_field
<-account_system_index_time
kworker/-117       1d.h2  499us : __rcu_read_lock <-cpuacct_account_field
kworker/-117       1d.h2  500us : __rcu_read_unlock <-cpuacct_account_field
kworker/-117       1d.h2  501us : __rcu_read_lock <-account_system_index_time
kworker/-117       1d.h2  503us : __rcu_read_unlock <-account_system_index_time
kworker/-117       1d.h2  504us : acct_account_cputime
<-account_system_index_time
kworker/-117       1d.h2  505us : __acct_update_integrals <-acct_account_cputime



Before the commit "40d09b53bfc557af7481b9d80f060a7ac9c7d314", block I/O request
is completed in mmc_blk_mq_complete_work() and there is no problem.
But after the commit, block I/O request is completed in softirq and it
may cause the preemptoff
problem as above.

The use of REQ_HIPRI flag is intended to execute rq->q->mq_ops->complete() in
mmc_blk_mq_complete_work(), not in softirq.
I just think it can avoid the preemptoff problem and not change too much.
Maybe there is  a better way to solve the problem.
