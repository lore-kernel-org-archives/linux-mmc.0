Return-Path: <SRS0=RiNA=5T=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AF8C43331
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Apr 2020 17:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A7020BED
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Apr 2020 17:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hlm6P03s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391137AbgDCREk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:04:40 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38281 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgDCREk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Apr 2020 13:04:40 -0400
Received: by mail-ua1-f67.google.com with SMTP id g10so2998287uae.5
        for <linux-mmc@vger.kernel.org>; Fri, 03 Apr 2020 10:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eKwWwj3eqf+cZzC5JrJMT4a43JvCqUM+JiOzX9deVL0=;
        b=hlm6P03s/Sq5PDxZkKnjNhsRznuMMud9tkThiDgQeV7G1rL6qquyi7rq7iMdnRCfLa
         eWAY/+MOlyXrktAih6k/dfz5ql/Vw70D8AgPa/ajBudMfEzf400Q4yG9I1r7eVo/sMOu
         OpTDl1bhUsTqqoiyOoYnCzV5tFYSc7pHf6vmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eKwWwj3eqf+cZzC5JrJMT4a43JvCqUM+JiOzX9deVL0=;
        b=ecSlNoEzWq/olGvOHx+ZcxsPwd9wzgt9x/ebnOoVWENjjNaW3G/a+LvtuKIBjvPG+r
         Z7i40LuUBKz7cU4BSYsvVy0A+Lfv+vTaJl0P1Yyj7G+94bafAKWxzNhgMMAlgEQQg49t
         9Ot6E8I0+1DWtstOqXl8iMj6oJ2FThyMQyVKyLxNAO2Hr9d+7HKvp7Iv3SSaSIdQMrBV
         7a/drmRBG5ybU74ti6eheEplce0cfyyuKaWe6a7jum3lRk7VV2UPrT33LO7LZ8e3SaGU
         yqBX2noLw/LTK/oB51Aw/uuSV1u1n3F2aJAWSEOAQVk/Y3tgqA1Km83mLiEztvi0eCqX
         6Scw==
X-Gm-Message-State: AGi0PuaCGatVbxRUCIHt1Yq/FMYCRlPkR1MvI40lohh/kh4zknyHSeOY
        eWnNF177gGKQvV8/eJFDt8nuFZaVAVw=
X-Google-Smtp-Source: APiQypLTJx4RkIJm1csQf+UAfkJy4KNwcOdhxsolVGtZVMJdOXxWX8JlPr21ZzgZrGH9tU0ozNkkbw==
X-Received: by 2002:ab0:1e45:: with SMTP id n5mr7586965uak.84.1585933477071;
        Fri, 03 Apr 2020 10:04:37 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id k5sm2380977vkk.23.2020.04.03.10.04.35
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 10:04:36 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id 9so2978897uav.12
        for <linux-mmc@vger.kernel.org>; Fri, 03 Apr 2020 10:04:35 -0700 (PDT)
X-Received: by 2002:ab0:1d10:: with SMTP id j16mr7491766uak.91.1585933475285;
 Fri, 03 Apr 2020 10:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <1573220319-4287-1-git-send-email-ppvk@codeaurora.org> <1573220319-4287-3-git-send-email-ppvk@codeaurora.org>
In-Reply-To: <1573220319-4287-3-git-send-email-ppvk@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 3 Apr 2020 10:04:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WGUasS=UZxFeSS0Cg=9WxHPMWVFyYae7CFmOxV2_yhJw@mail.gmail.com>
Message-ID: <CAD=FV=WGUasS=UZxFeSS0Cg=9WxHPMWVFyYae7CFmOxV2_yhJw@mail.gmail.com>
Subject: Re: [RFC-v2 2/2] mmc: sdhci-msm: Add support for bus bandwidth voting
To:     Pradeep P V K <ppvk@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        linux-mmc-owner@vger.kernel.org,
        Subhash Jadavani <subhashj@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Fri, Nov 8, 2019 at 5:45 AM Pradeep P V K <ppvk@codeaurora.org> wrote:
>
> +       if (msm_host->bus_vote_data->curr_vote != VOTE_ZERO)
> +               queue_delayed_work(system_wq,
> +                                  &msm_host->bus_vote_work,
> +                                  msecs_to_jiffies(MSM_MMC_BUS_VOTING_DELAY));
> +}

Drive-by feedback here without any full review of your patch...
Someone had your patch applied and sent me a stack trace with a
warning on it.  That warning showed:

workqueue: WQ_MEM_RECLAIM kblockd:blk_mq_run_work_fn is flushing
!WQ_MEM_RECLAIM events:sdhci_msm_bus_work

The trace shown was:

    check_flush_dependency+0x108/0x110
    __flush_work+0xa8/0x1e8
    __cancel_work_timer+0x130/0x1c4
    cancel_delayed_work_sync+0x20/0x30
    sdhci_msm_bus_cancel_work_and_set_vote+0x3c/0x8c
    sdhci_msm_bus_voting+0x40/0x7c
    sdhci_msm_runtime_resume+0xdc/0xf4
    pm_generic_runtime_resume+0x34/0x48
    __rpm_callback+0x70/0xfc
    rpm_callback+0x5c/0x8c
    rpm_resume+0x3fc/0x534
    __pm_runtime_resume+0x7c/0xa0
    __mmc_claim_host+0x1f4/0x230
    mmc_get_card+0x34/0x40
    mmc_mq_queue_rq+0x18c/0x244
    blk_mq_dispatch_rq_list+0x27c/0x560
    blk_mq_do_dispatch_sched+0xe0/0x140
    blk_mq_sched_dispatch_requests+0x138/0x1b8
    __blk_mq_run_hw_queue+0xc0/0x118
    blk_mq_run_work_fn+0x24/0x30

I believe the way to interpret this is that you need to be running
your work on a workqueue marked for memory reclaim.  That means you
can't use the system_wq to queue your work.  Without being an expert,
a quick guess would be that you should be queueing your work on the
"kblockd_workqueue" using one of the functions for this.

-Doug
