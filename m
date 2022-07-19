Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A63C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jul 2022 19:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237568AbiGSTLv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Jul 2022 15:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGSTLu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jul 2022 15:11:50 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7D545F48
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jul 2022 12:11:48 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id r14so3787430ljp.2
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jul 2022 12:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=7SV6cxwcWEiGaJqm53YhsvXnwanf2AoDb1dJfihwiuM=;
        b=LyZaBRYjZ++sF/ivAbWDNgvWsCy3Ft14NyOoQR7nkoiDkDNe3Mm4G1ZlumVbMlr9ZK
         fonUUJOrdmfTEy2gT9ZN0sfwora6dTjtX7MBJkfekJym8CM/Qqm2YF701dlXXvNMb6D5
         EB2sI0TeWQrJoENC/9VOMGh+vw9y0qpl301yracsbYSiGwI6VM6ie+RC6kZSPqYD7TWG
         PzIESqj+r3t3zoVvLdcsD8Xsxnscvk9GqXOH4BPMYboj7OjF182DCiSAgBvKhreR2NKL
         4zzmccw4giOeaIRzlPV0d0RQdLXQFnbO8nV2jR8Qcoizo9M9KmAAYZPP11F35qb5nEgV
         S32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=7SV6cxwcWEiGaJqm53YhsvXnwanf2AoDb1dJfihwiuM=;
        b=WOIMbIlt5aBC0qI7HCYgwJ5u73NupX0vV4ALAgixOJD/YZS7ZnOmZpZsquZUSQ4g6Y
         dE94pTxejpXWbDbic1Xmv4zFs1PtvtV7WNC2Rqlhj0BrIg92FrpV0gXTZZiBCC5aBycN
         R0jI6WqMFrDho0m9mLplv0zxgyANz9S5IQa3SEfyN5W0X5rPuGtXV6D6T04vX/vtLrdH
         QmWSvHY7YOrho3WyDdgk6tbnuXhgA1tO/KDI85JUoLV+d3Y972lua8ZAJRmNDYFdhMA5
         tY/liUg3k+fDcpIuTvHzHTRYGGuveQftp9xnt3CZr2Rxl7r1bswv/0XBIHAvvfeNJdgl
         EUMg==
X-Gm-Message-State: AJIora91LUGPEanzx0pe0mKmHO5+Ol5W6TTRa0t3ofZ0PgRBmpMsVY7g
        ygWqfLVX5Wet5jZi9y0HY73uaA==
X-Google-Smtp-Source: AGRyM1uOESYS4Whck2N14ZdE9rrXhBpV/yJJwFiLzXV44VcuHgb4mlzQgO/Ey/B75J9SexIskNAR5w==
X-Received: by 2002:a2e:bea8:0:b0:25d:610f:5c02 with SMTP id a40-20020a2ebea8000000b0025d610f5c02mr14787392ljr.186.1658257906647;
        Tue, 19 Jul 2022 12:11:46 -0700 (PDT)
Received: from [10.43.1.253] ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id p15-20020ac24ecf000000b0047f6f8f20dcsm2159491lfr.28.2022.07.19.12.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 12:11:46 -0700 (PDT)
Message-ID: <5e6b3acf-1909-de42-3da7-c591e23ab221@semihalf.com>
Date:   Tue, 19 Jul 2022 21:11:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] PCI/ASPM: Disable ASPM when save/restore PCI state
Content-Language: en-US
From:   Dmytro Maluka <dmy@semihalf.com>
To:     Victor Ding <victording@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Zide Chen <zide.chen@intel.com>
References: <20210311173433.GA2071075@bjorn-Precision-5520>
 <20210726220307.GA647936@bjorn-Precision-5520>
 <CANqTbdb_h_W+8kmh6s56deA8VKn6tO1KDJaS5Yasq5RFLtGUbQ@mail.gmail.com>
 <820dff42-67e4-32d2-a72f-9e9bdb70609e@semihalf.com>
In-Reply-To: <820dff42-67e4-32d2-a72f-9e9bdb70609e@semihalf.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 7/18/22 18:21, Dmytro Maluka wrote:
> While we're at it, I'm also wondering why for the basic PCI config (the
> first 256 bytes) Linux on x86 always uses the legacy 0xCF8/0xCFC method
> instead of MMCFG, even if MMCFG is available. The legacy method is
> inherently non-atomic and does require the global lock, while the MMCFG
> method generally doesn't, so using MMCFG would significantly speed up
> PCI config accesses in high-contention scenarios like the parallel
> suspend/resume.
> 
> I've tried the below change which forces using MMCFG for the first 256
> bytes, and indeed, it makes suspend/resume of individual PCI devices
> with pm_async=1 almost as fast as with pm_async=0. In particular, it
> fixes the problem with slow GL9750 suspend/resume even without Victor's
> patch.
> 
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -40,20 +40,20 @@ const struct pci_raw_ops *__read_mostly raw_pci_ext_ops;
>  int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
>                                                 int reg, int len, u32 *val)
>  {
> -       if (domain == 0 && reg < 256 && raw_pci_ops)
> -               return raw_pci_ops->read(domain, bus, devfn, reg, len, val);
>         if (raw_pci_ext_ops)
>                 return raw_pci_ext_ops->read(domain, bus, devfn, reg, len, val);
> +       if (domain == 0 && reg < 256 && raw_pci_ops)
> +               return raw_pci_ops->read(domain, bus, devfn, reg, len, val);
>         return -EINVAL;
>  }
>  
>  int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
>                                                 int reg, int len, u32 val)
>  {
> -       if (domain == 0 && reg < 256 && raw_pci_ops)
> -               return raw_pci_ops->write(domain, bus, devfn, reg, len, val);
>         if (raw_pci_ext_ops)
>                 return raw_pci_ext_ops->write(domain, bus, devfn, reg, len, val);
> +       if (domain == 0 && reg < 256 && raw_pci_ops)
> +               return raw_pci_ops->write(domain, bus, devfn, reg, len, val);
>         return -EINVAL;
>  }
>  
> 
> Sounds good if I submit a patch like this? (I'm not suggesting it
> instead of Victor's patch, rather as a separate improvement.)

Ok, I found that a similar change was already suggested in the past by
Thomas [1] and got rejected by Linus [2].

Linus' arguments sound reasonable, and I understand that back then the
only known case of an issue with PCI config lock contention was with
Intel PMU counter registers which are in the extended config space
anyway. But now we know another case of such a contention, concerning
the basic config space too, namely: suspending or resuming many PCI
devices in parallel during system suspend/resume.

I've checked that on my box using MMCFG instead of Type 1 (i.e. using my
above patch) reduces the total suspend or resume time by 15-20 ms on
average. (I also had Victor's patch applied all the time, i.e. the ASPM
L1 exit latency issue was already resolved, so my test was about the PCI
lock contention in general.) So, not exactly a major improvement, yet
not exactly a negligible one. Maybe it's worth optimizing, maybe not.

Anyway, that's a bit of digression. Let's focus primarily on Victor's
ASPM patch.

[1]
https://lore.kernel.org/all/tip-b5b0f00c760b6e9673ab79b88ede2f3c7a039f74@git.kernel.org/

[2]
https://lore.kernel.org/all/CA+55aFwi0tkdugfqNEz6M28RXM2jx6WpaDF4nfA=doUVdZgUNQ@mail.gmail.com/

Thanks,
Dmytro
