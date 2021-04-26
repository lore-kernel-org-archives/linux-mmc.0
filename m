Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D20C433ED
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Apr 2021 08:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42398610C8
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Apr 2021 08:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhDZI0S (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Apr 2021 04:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbhDZI0R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Apr 2021 04:26:17 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328B6C061574;
        Mon, 26 Apr 2021 01:25:34 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id w20so698436pge.13;
        Mon, 26 Apr 2021 01:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jQWKwPGTMFGJm+uWgEIF87JnJjFNAJL/m8Q6ObzH+Yk=;
        b=YTLVEqNZnFp898icZZIjFJYPF1GwzfEQ2oQbBZUDecL/Zs7+lYJjHRhYQlKttdHbR1
         JRqITjQR4nTBHUtFNvt2t3SdZ2lvDCeTdZ0SJGM+DNI/KYpZBhTYFRMy2d+4iYp6Txr/
         o9OlNjYjQL330HE9TVy26wcj9nCpenHBsy7C/PahCeuQE02XjeE/fD54gKI4sbloSBZ6
         WuQ5rLHkso8g/Wx2up/GgsCXMVjlsb1h7M0rBQhXLyDubpqFdZJCnH/TL42iHPKKUDva
         QAY0BtYv9Dbnewm6cuvyjTpkg67Oj+9G+iTnikXX15WvAYU+6g7k4IBdWThBTrIZAiHg
         frCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jQWKwPGTMFGJm+uWgEIF87JnJjFNAJL/m8Q6ObzH+Yk=;
        b=Q0nMAdTQE9XLm6lAiuoepqpcLFkI5e7BUkPGD+9dcA28FSvLrKNrEODuZdh8M7dgNi
         E9ZKp3MZojlDCIpFtgUvoO+cBDHceOx0QZaDQyg+235R0iuWLhGqHoT1uynrzYciDQEC
         ATvVLqNlZoIvVyUuOFCglq+dgwUvTWnpi90pcuNWOSqKNz0fJIoJh5eMhiX99I3dWm9B
         A/XoWgcoxfmn9OyugzSNMMryso2CiUm0NQ7CbZdUbb+pOBLA6dHTUijNuP2S/+gAIx0N
         Bz4LESj7ABSwqB8CHhmmpsQbsXFRs/GZbK9mNX5cg3bvltObOpEgPix37bOQRA58uUfY
         mtIQ==
X-Gm-Message-State: AOAM5323NL/4UpTHDS9KLPLc1o9yumwYi72jw3yJdN7VUoLnWQbjf/R+
        wVVlSmbqPFKSriHajKjU+7I=
X-Google-Smtp-Source: ABdhPJzg+FvvaI1gfWjnjrqTCUdrmfoILYPZaaXfOkn59Rn+vg5oqctdgdIKYxmDJjFpODrKYohpxQ==
X-Received: by 2002:a63:3c59:: with SMTP id i25mr15573515pgn.366.1619425533827;
        Mon, 26 Apr 2021 01:25:33 -0700 (PDT)
Received: from soma ([121.99.145.49])
        by smtp.gmail.com with ESMTPSA id n25sm10558132pff.154.2021.04.26.01.25.29
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 26 Apr 2021 01:25:33 -0700 (PDT)
Received: by soma (sSMTP sendmail emulation); Mon, 26 Apr 2021 20:25:26 +1200
Date:   Mon, 26 Apr 2021 20:25:26 +1200
From:   Daniel Beer <dlbeer@gmail.com>
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     adrian.hunter@intel.com, ben.chuang@genesyslogic.com.tw,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        ulf.hansson@linaro.org
Subject: Re: [PATCH] mmc: sdhci-pci-gli: increase 1.8V regulator wait
Message-ID: <20210426082526.GA16240@nyquist.nev>
References: <20210424081652.GA16047@nyquist.nev>
 <20210426073251.7726-1-benchuanggli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426073251.7726-1-benchuanggli@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Apr 26, 2021 at 03:32:51PM +0800, Ben Chuang wrote:
> > The driver currently waits 5ms after switching on the 1.8V regulator for
> > it to become stable. Increasing this to 10ms gets rid of the warning
> > about stability, but most cards still fail. Increasing it to 20ms gets
> > some cards working (a 32GB Samsung micro SD works, a 128GB ADATA
> > doesn't). At 50ms, the ADATA works most of the time, and at 100ms both
> > cards work reliably.
> 
> If it is convenient, can you provide the appearance pictures and product
> links of these two cards? We want to buy them.

Hi Ben,

The first is a Samsung EVO microSDXC 32GB:

    https://www.samsung.com/nz/memory-storage/memory-card/evo-plus-microsd-card-95-mbs-sd-adapter-32gb-mb-mc32ga-apc/

The second is an ADATA Premier Pro SDXC UHS-I U3 Class 10 (V30S) 128GB:

    https://www.adata.com/us/consumer/289

The images on those two pages match what I have in front of me here.

Cheers,
Daniel

-- 
Daniel Beer <dlbeer@gmail.com> http://dlbeer.co.nz/
PGP: BA6E 0B26 1F89 246C E3F3  C910 1E58 C43A 160A 553B
