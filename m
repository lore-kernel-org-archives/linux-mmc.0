Return-Path: <SRS0=CvS5=DC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2159C4727D
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Sep 2020 14:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7442C20936
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Sep 2020 14:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QZx7q7gI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgIYOTP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 25 Sep 2020 10:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728333AbgIYOTL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Sep 2020 10:19:11 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E532C0613D3
        for <linux-mmc@vger.kernel.org>; Fri, 25 Sep 2020 07:19:11 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 197so2700125pge.8
        for <linux-mmc@vger.kernel.org>; Fri, 25 Sep 2020 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Izvn14aXCOd8rlHi8gt8/prckjwG/92/E8+p6vMMqzM=;
        b=QZx7q7gI1poaxI+iNpfTHOEPysawBMN6ILpWj8VDRHvig1MWbXDH9Q/Ejh/VGdMY6V
         XhsSRSgLJ3vyBUW4G6v5lGczlnBrfrfGUTY6Io4kTHSOwwPeeq67+GUlO0pvSbpcSc8G
         UQSaYijRBt6BeZMDv8AdtAKiNqO1VevLatKGi1HCrNW5g8jU/dNWe2se7vKcQ5smC1Kh
         pE6mdkVNLv/zO4pT+cJM9rz/VL4qgjegnLWF0CSvnNA3YX8nzt9KdJQrxarNDFpNgyxb
         mdM7GAKDG1dsnTN8AV+yDCM9QF/vXMl36U6209JvGiLAPdEQelB4a/A4/bJ7gb2XykBg
         PFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Izvn14aXCOd8rlHi8gt8/prckjwG/92/E8+p6vMMqzM=;
        b=KJHsjbWytkUKbBmrj63wRdmrlXmTzESuoqCAyLrXmBuLS+aAsAWsU8D1SRbrXKFRHG
         /pwa0PvKUEdtRg6nm03KLDcXafj6mvxDZBblpDbLnMaJFr/bveQ9OFemS07FE7OteOMJ
         vRT2EVfs30KenkSMfkJE10lgLQqO+4lQvGlXIj6lyDdVW9g4Y7HFm5iOXwtpqGqr8xyo
         kpGcU8YsaFlrU2PiBCqHsigOvIXkVmtOUZ1W0t8qdva5i/VWR0c+qYPWSjRwZklw0V0Z
         p78Hjw8utVy7XEz1imbm6ukXXtSgycCyLG2KtewjSY+JPrUF3URKhTVLMfJ+Wp3aD1PX
         rEJQ==
X-Gm-Message-State: AOAM533+169FOzJL2gCnUM/sS4ncmD1RxTCLZNmeetOzPTHsek1aFXSd
        Ipmz40xDJ8USnPh1VIW1WOIjcw==
X-Google-Smtp-Source: ABdhPJwRr/FwQpe7dKk8pmg8H/cUjDmWIFuRPHGSosKhPuxMlj+z/HBIhpQTLB9cSGSc+hfMahv5og==
X-Received: by 2002:a63:e057:: with SMTP id n23mr213338pgj.87.1601043550492;
        Fri, 25 Sep 2020 07:19:10 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j19sm2930829pfe.108.2020.09.25.07.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 07:19:09 -0700 (PDT)
Subject: Re: clean up is partition checks
To:     Christoph Hellwig <hch@lst.de>
Cc:     dm-devel@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-ide@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
References: <20200903054104.228829-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7a0600d8-d886-c546-378c-5298a16e979c@kernel.dk>
Date:   Fri, 25 Sep 2020 08:19:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903054104.228829-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 9/2/20 11:40 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series add a new helepr to check if a struct block_device represents
> a parition, and removes most direct access to ->bd_contained from
> drivers.

Applied, thanks.

-- 
Jens Axboe

