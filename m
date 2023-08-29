Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E8BC71153
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Aug 2023 15:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbjH2PUZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Aug 2023 11:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237194AbjH2PT7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Aug 2023 11:19:59 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B8F1B3
        for <linux-mmc@vger.kernel.org>; Tue, 29 Aug 2023 08:19:56 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf55a81eeaso23456575ad.0
        for <linux-mmc@vger.kernel.org>; Tue, 29 Aug 2023 08:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1693322395; x=1693927195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cor1zHUTxW7d4w3a7aWkgwMFwRQK/cqQ/TIYhq10f/w=;
        b=Xy9E7aWN3rcT7zyhntD02JgHegmlY6eZ26bun57j7TcjHNm16Kr/Q8jBFEi4n9nbKT
         MTyVN46lozXW+z/dvNuCp5Jv27P9QHq19F7lpf9YOhWoGcVH2Mbn8xaU+KVRoXyuX8Sw
         P+4lVQZOpc/PGQNHLVEiFSZoTBh+8x6OR6DXA0450Bof5dfHstUlTymAfTtYSA5BZ06B
         8cRXqI0scZ03TD+NDcD7kCFYuxDCbiQ0cq0Owxvapwp5I1IG2/Ytw6r1YY8RXnZSNNxD
         bvtu7/514Js5miIIi2SJMrGI71fEHnW+HcLmMAiYEPwRakFWZf1u1IzH9G6q8vBQJSYq
         HVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693322395; x=1693927195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cor1zHUTxW7d4w3a7aWkgwMFwRQK/cqQ/TIYhq10f/w=;
        b=aH+c0DiJq1fxGAVha0q2oQFX6In8/AoMI5ZRq6yiar4MKiwEKDKgE8J2PElCnSd6yc
         VfqmFnbvOXLA+bg6vIa4EkRUBlImn6IWUS73bxTpgQj50zG5nn9G6yP18XMiZDgBcEUe
         e979Rhvz4joNHvtFLLYS5IOoT8rLFj6JJJupfPwe8qSjt34RCUk73ZzYOOOA7ka5I9xG
         MZ4acVrlAgP8WkGyeLTP5Ab2FHLJiKWDYmRf5GzVBnXhNM2np1RUPreW1VdoDKSIySb7
         5PKqNYbYLpyk2n3rqmwwBtqeNv0oNHpXSG6zoA1wL5H+PpFuQr8hGpXLHyVS1ssecaxa
         bFqg==
X-Gm-Message-State: AOJu0YwS0cnSpSLQOpCupp+FdU86rTlXLnDQUbDrg5aFIAe8os+2ALqB
        Gchew15eN9/LVUeqXvqQpSmrvw==
X-Google-Smtp-Source: AGHT+IFrRXqA8JUTDFjZ0AWcbSs5Zzysi0dfvW9k+j75BV2qYiaMMc+h4ICBPzzSU2nDFAmQf+J3xg==
X-Received: by 2002:a17:902:ce90:b0:1bb:3406:a612 with SMTP id f16-20020a170902ce9000b001bb3406a612mr25710603plg.57.1693322395350;
        Tue, 29 Aug 2023 08:19:55 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:8dfe:7244:3174:3fed])
        by smtp.gmail.com with ESMTPSA id g15-20020a1709029f8f00b001b898595be7sm9459158plq.291.2023.08.29.08.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 08:19:54 -0700 (PDT)
Date:   Tue, 29 Aug 2023 08:19:53 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Jiexun Wang <wangjiexun@tinylab.org>
Cc:     jszhang@kernel.org, adrian.hunter@intel.com, aou@eecs.berkeley.edu,
        conor+dt@kernel.org, conor@kernel.org, devicetree@vger.kernel.org,
        guoren@kernel.org, jkridner@beagleboard.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        robertcnelson@beagleboard.org, robh+dt@kernel.org,
        ulf.hansson@linaro.org, wefu@redhat.com
Subject: Re: [PATCH RFC v2 0/4] RISC-V: Add basic eMMC support for BeagleV
 Ahead
Message-ID: <ZO4MmdNRqrye/x2b@x1>
References: <ZOy3v+YgZgU1NrWx@xhacker>
 <20230829015647.115757-1-wangjiexun@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829015647.115757-1-wangjiexun@tinylab.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Aug 29, 2023 at 09:56:47AM +0800, Jiexun Wang wrote:
> Date: Mon, 28 Aug 2023 23:05:35 +0800, Jisheng Zhang wrote:
> >On Mon, Aug 28, 2023 at 12:40:16PM +0800, Jiexun Wang wrote:
> >> Hello,
> >> I tested the patch on my LicheePi 4A board.
> >> It can successfully boot with eMMC, but when I use the eMMC more frequently - for instance:
> >> 
> >> $ while true; do /bin/dd if=/dev/zero of=bigfile bs=1024000 count=1024; done &
> >> 
> >> I encounter the following error:
> >> 
> >> sbi_trap_error: hart1: illegal instruction handler failed (error -2)
> >
> >> sbi_trap_error: hart1: mcause=0x0000000000000002 mtval=0x0000000060e2de4f
> >> sbi_trap_error: hart1: mepc=0x000000000001897c mstatus=0x0000000a00001820
> >> sbi_trap_error: hart1: ra=0x00000000000170f8 sp=0x000000000004adc8
> >> sbi_trap_error: hart1: gp=0xffffffff8136ea90 tp=0xffffffd900228000
> >> sbi_trap_error: hart1: s0=0x0000000000000000 s1=0x000000000004ae08
> >> sbi_trap_error: hart1: a0=0x000000003f9aa9bc a1=0x0000000000000004
> >> sbi_trap_error: hart1: a2=0x0000000000000000 a3=0x0000000000000000
> >> sbi_trap_error: hart1: a4=0x0000000000042248 a5=0x00000000000170e5
> >> sbi_trap_error: hart1: a6=0x0000000000000000 a7=0x0000000054494d45
> >> sbi_trap_error: hart1: s2=0x000000000004aee8 s3=0x0000000000000000
> >> sbi_trap_error: hart1: s4=0x000000000004ae08 s5=0x0000000000000000
> >> sbi_trap_error: hart1: s6=0xffffffff813aa240 s7=0x0000000000000080
> >> sbi_trap_error: hart1: s8=0xffffffff80a1b5f0 s9=0x0000000000000000
> >> sbi_trap_error: hart1: s10=0xffffffd9fef5d380 s11=0xffffffff81290a80
> >> sbi_trap_error: hart1: t0=0x0000000a00000820 t1=0x0000000000000000
> >> sbi_trap_error: hart1: t2=0xffffffff80c00318 t3=0x0000000000000001
> >> sbi_trap_error: hart1: t4=0x0000000000000330 t5=0x0000000000000001
> >> sbi_trap_error: hart1: t6=0x0000000000040000
> >> 
> >> My kernel version is v6.5-rc3.
> >> My OpenSBI version is 1.3.
> >> I tried to use other versions of OpenSBI, yet the problem persists. 
> >> Is there a possibility of any underlying bug? Your insights into this would be greatly appreciated.
> >
> >
> >Can you plz try below opensbi?
> 
> I tried the OpenSBI you provided and the issue didn't recur.
> I conducted stress test about 30 minutes and the system appears to be functioning very well.
> Thank you so much for helping me resolve this problem.

That's great!

Jisheng - are these the commits that fix the error?

d98da90a19b5 ("lib: sbi_illegal_insn: Fix FENCE.TSO emulation infinite trap loop")
39d1e698c975 ("lib: sbi_illegal_insn: Add emulation for fence.tso")

thanks,
drew
