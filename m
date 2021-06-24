Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76592C49EA5
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 17:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59981613B3
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 17:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhFXRbp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Jun 2021 13:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhFXRbp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jun 2021 13:31:45 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39691C061574
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jun 2021 10:29:25 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id b3so4753145qtq.6
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jun 2021 10:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+rsHIuusfgMY4pqsH67Cui+AEpTgqc5yU+NQJneTe3I=;
        b=nBGujxlend0FDFpaE8uA1VUl+5W3aXuZOEudrIKeZDfQ/+pPr4z/II/WEyNd+uPN26
         soAHBGP+8BikRpyXJAG3b8cFuHlgqAS3iEFezd2Ak3P1sLNeJUFtACX4Ma/t0C5DxnCj
         gDadjhrj4RKoBq1/dEScJTk1qx68aEBMsAMaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+rsHIuusfgMY4pqsH67Cui+AEpTgqc5yU+NQJneTe3I=;
        b=pa3Emc4Uu6M5nF8s29VJR0LMri7S4F98tQQzBXOzLDZv1k7S2bFrIPoHohOnuChH5a
         9ysU14uxZtlCwPDjvoVQ1UZZo72/KKz9TkL1OfshoprCcEcJrp3shpzBeiVuFK42H2T5
         zD83EvrFmUyWEMYTOrD3bk8siORX5TNHQ3vFG8wfWz7qFR8PkMShyZyS0lfF6NEoMPEG
         qPnjBjyeVweOdT8w9ML8C9/fDN3vaFOTFxamyQhu/O7Zam9lwqeCIuypUPmcP7y5SA/b
         A+3RfrcOWSBTAIKOcBI5X8dzbaVp7auyJjRAsIahJuUS9rPohxF1PVf2P2M9tSErwnKr
         YpLw==
X-Gm-Message-State: AOAM531rAoVtOFlYwGOxRzgS30jMbLrfXkCHP6WN73Nm67gI0ZoD+Vvj
        QAOkAmp0mb7BgmuBHHHrYTDvH4iS+EuNTA==
X-Google-Smtp-Source: ABdhPJzW99jxk8tFilvaXTeLIM6B6BP6xOkWlY9jU2xKkZqVyhZoQBw19z89y4tEHr9AAuI3Xw9GJA==
X-Received: by 2002:ac8:5345:: with SMTP id d5mr5777405qto.366.1624555764288;
        Thu, 24 Jun 2021 10:29:24 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id o123sm3016303qkd.6.2021.06.24.10.29.24
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 10:29:24 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id m9so400409ybp.8
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jun 2021 10:29:24 -0700 (PDT)
X-Received: by 2002:a25:2405:: with SMTP id k5mr6470962ybk.405.1624555397076;
 Thu, 24 Jun 2021 10:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <067dd86d-da7f-ac83-6ce6-b8fd5aba0b6f@arm.com> <CAD=FV=Vg7kqhgxZppHXwMPMc0xATZ+MqbrXx-FB0eg7pHhNE8w@mail.gmail.com>
 <498f3184-99fe-c21b-0eb0-a199f2615ceb@arm.com> <CAD=FV=UQBRY4hobBWVWtC8y07NLRLhpejdvUAD+7UWw-jqP2UA@mail.gmail.com>
In-Reply-To: <CAD=FV=UQBRY4hobBWVWtC8y07NLRLhpejdvUAD+7UWw-jqP2UA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 24 Jun 2021 10:23:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V4ZrUZagtE8qtRXwFEdw9FqGt-tpX-yCO3Hvi9Aw22UA@mail.gmail.com>
Message-ID: <CAD=FV=V4ZrUZagtE8qtRXwFEdw9FqGt-tpX-yCO3Hvi9Aw22UA@mail.gmail.com>
Subject: Re: [PATCH 0/6] iommu: Enable devices to request non-strict DMA,
 starting with QCom SD/MMC
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pci@vger.kernel.org, quic_c_gdjako@quicinc.com,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Sonny Rao <sonnyrao@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Rajat Jain <rajatja@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Gross <agross@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Wed, Jun 23, 2021 at 10:29 AM Doug Anderson <dianders@chromium.org> wrote:
>
> * Instead of putting the details in per-device nodes, maybe it makes
> sense to accept that we should be specifying these things at the IOMMU
> level? If specifying things at the device tree level then the
> device-tree node of the IOMMU itself would just have a list of things
> that should be strict/non-strict. ...this could potentially be merged
> with a hardcoded list of things in the IOMMU driver based on the IOMMU
> compatible string.
>
> Do those sound right?
>
> I still haven't totally grokked the ideal way to identify devices. I
> guess on Qualcomm systems each device is in its own group and so could
> have its own strictness levels? ...or would it be better to list by
> "stream ID" or something like that?
>
> If we do something like this then maybe that's a solution that could
> land short-ish term? We would know right at init time whether a given
> domain should be strict or non-strict and there'd be no requirements
> to transition it.

OK, so I have attempted to implement this in the Qualcomm IOMMU driver
in v2 of this series:

https://lore.kernel.org/r/20210624171759.4125094-1-dianders@chromium.org/

Hopefully that doesn't fragment the discussion too much, but it seemed
like it might help move us forward to see what this would look like in
code.

I'll also note that I removed a few people from the CC list on v2 of
the series because I'm no longer touching any code outside of the
IOMMU subsystem and I thought folks would appreciate less noise in
their inboxes. I've CCed a boatload of mailing lists though so it
should be easy to find. If I dropped you from the CC list of v2 and
you really want back on then I'm more than happy to re-add you.

-Doug
