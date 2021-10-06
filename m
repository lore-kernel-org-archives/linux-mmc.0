Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB8BC433EF
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Oct 2021 13:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1735761075
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Oct 2021 13:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238940AbhJFN07 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 Oct 2021 09:26:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60654 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238810AbhJFN0b (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Oct 2021 09:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633526678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PhQKrj6CTy/IMZheSbTjJtRay2DZf3eElNhZxG86YDA=;
        b=J95UXzND/A+4XtsnnEnVOriH/mqlUv+LTOgiPmnHBEc3YOkCTeAShVdazLn5/4Eh/Q/l4g
        /02uzYfVApiveNEG+2f9Bnk3DpCofQd1K7FmnC5jE/BuixBhb75D8DOVIcFB+o6gczev7a
        XEzSVck/rVBXXfAXUGvuox+mq14DvxQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-XY4BsrJfPayE_SjuhxLLnA-1; Wed, 06 Oct 2021 09:24:37 -0400
X-MC-Unique: XY4BsrJfPayE_SjuhxLLnA-1
Received: by mail-qt1-f198.google.com with SMTP id y25-20020ac87059000000b002a71d24c242so2321239qtm.0
        for <linux-mmc@vger.kernel.org>; Wed, 06 Oct 2021 06:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PhQKrj6CTy/IMZheSbTjJtRay2DZf3eElNhZxG86YDA=;
        b=g3CTuR7evMajrW4pvSKSK4w1ywVWGzGz3/BrF985IOxq1LHUyS59Jm6vwHoLGqCYE+
         WaXyMJhNA3cRMbNO5LdMo2sAgHMya65zV4DsX2Wcc1sfzTqpNMAaD2cSujWZTEgjffsx
         BAOYLWD0f/txvsQT1e6CMJdIbup3y1PjGMjhqF5xI56FKa9bnofmfPZOO1OgtVTb5SRf
         ILVOz18E8OdFxN3F8lKm++C9lxtU9fMEbcItjwqgv/beMqTLwABemfytflB/VmuwnlXa
         oi0WfdbnmAAUxfVWdcdQWJ+0pp4XuHdVq/unMydp7o3X5DGC5jNd34UL5LPn9EFjkphc
         2JIA==
X-Gm-Message-State: AOAM531WebIshcRysdBFKU7o+tiFq4C986RTpszDPCjjMZ5rtJ/441uP
        AxYU6+EwqtmWEWkOr5CaMNrlutKqHXW6AvtPbu7Tm8MZM2KL+6BqzfMEhhoKoB11ZNnTHzmjCDh
        1Rm4DMvy1IdIcInRIfGU=
X-Received: by 2002:a37:9d16:: with SMTP id g22mr19915881qke.158.1633526676976;
        Wed, 06 Oct 2021 06:24:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwU5K9sLtf2F8/ZVmQbICWiONRseEkHUAhaNdvw8PixzCkidZf3Sgubc2NbR+xRlb/+oJjIrw==
X-Received: by 2002:a37:9d16:: with SMTP id g22mr19915860qke.158.1633526676823;
        Wed, 06 Oct 2021 06:24:36 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id s14sm5011152qtc.9.2021.10.06.06.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 06:24:36 -0700 (PDT)
Date:   Wed, 6 Oct 2021 09:24:35 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Satya Tangirala <satyaprateek2357@gmail.com>, dm-devel@redhat.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v4 1/4] blk-crypto-fallback: properly prefix function and
 struct names
Message-ID: <YV2jk1su5caAZmVP@redhat.com>
References: <20210929163600.52141-1-ebiggers@kernel.org>
 <20210929163600.52141-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929163600.52141-2-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Sep 29 2021 at 12:35P -0400,
Eric Biggers <ebiggers@kernel.org> wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> For clarity, avoid using just the "blk_crypto_" prefix for functions and
> structs that are specific to blk-crypto-fallback.  Instead, use
> "blk_crypto_fallback_".  Some places already did this, but others
> didn't.
> 
> This is also a prerequisite for using "struct blk_crypto_keyslot" to
> mean a generic blk-crypto keyslot (which is what it sounds like).
> Rename the fallback one to "struct blk_crypto_fallback_keyslot".
> 
> No change in behavior.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

