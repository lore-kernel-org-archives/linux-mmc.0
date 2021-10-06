Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AA3C4332F
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Oct 2021 13:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA9EE610C7
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Oct 2021 13:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238589AbhJFNTr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 Oct 2021 09:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32052 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231557AbhJFNTq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Oct 2021 09:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633526273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+zbCfVnHe3hEOXNTzkBOuBqFXs5HnnXgmi37Lbo5cf0=;
        b=YMqDlv12XO2LnjUUBU7lDeQni7BKIxaMyHTQqVWPWXft4KFCfOMSqL12RVnRMouNTETfmf
        jrWOdwRjrRby3Jy0hPeDmK14VgYTF7la6A9qFIuKrtNXAXeMna7parq+IOeYWqalHw6Byz
        QcrNR6gRllLs4ajMGeE0CkPiRWDi6sI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-DkFlcUKXM3u7BKEygEFPRw-1; Wed, 06 Oct 2021 09:17:52 -0400
X-MC-Unique: DkFlcUKXM3u7BKEygEFPRw-1
Received: by mail-qv1-f70.google.com with SMTP id a16-20020a0ccdd0000000b003830ff134ccso2683312qvn.6
        for <linux-mmc@vger.kernel.org>; Wed, 06 Oct 2021 06:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+zbCfVnHe3hEOXNTzkBOuBqFXs5HnnXgmi37Lbo5cf0=;
        b=4JLvAMrd1HM4+gM5b7EveoADoyBREOpyL4BNYgZO6ZKKN45Fw3Ak72sTyjBXGX+VMY
         A65fq3w59gAiHhmGoLtpN2po/se+BfEjvt1LE7Dy5y100RNTF2d6gyMobr6dzhghAPEl
         9KVMqToczd9wWTjWfHN9cqjyV7cLtMNtMZgZ3J/qOrOhymRys00SB2i554f3aTT2qATK
         jHwJk4KpiRvjTBi9fKdOO8o4Rn2e1jT7a3gAMOQnllaXcysfaStEHXDI88GlOqm9lK+F
         Dgq0vlOygZbjPJ5SKk9yytNPqsYyStm/GXg+Zc4a5WO7FbVi4cSoPQzLToZ2KS88mrX9
         ZXGw==
X-Gm-Message-State: AOAM531T9SW698huIKi4FZ7Y5bqNrIFPK1pL2DJymmAweEzYkEUmtzH0
        JdygcARjwHs1KJUO3Eyk/bjdw7FYr3nnhVXO1wP+T5/3YZ6RD6jc0lupS+wng2lgz1hDKnn/Nuv
        xJ/WyN8yyNYuCznUFCDw=
X-Received: by 2002:a05:622a:180f:: with SMTP id t15mr25944905qtc.314.1633526271475;
        Wed, 06 Oct 2021 06:17:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJ/dfz8opFCb2v5qUfLE0aMcIttTRFyUR16Rj5nDfAcBalXCGeyEeOx/El3NjgM1QYp0hnaw==
X-Received: by 2002:a05:622a:180f:: with SMTP id t15mr25944862qtc.314.1633526271274;
        Wed, 06 Oct 2021 06:17:51 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id r17sm12574405qtx.17.2021.10.06.06.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 06:17:50 -0700 (PDT)
Date:   Wed, 6 Oct 2021 09:17:50 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
        sagi@grimberg.me, adrian.hunter@intel.com, beanhuo@micron.com,
        ulf.hansson@linaro.org, avri.altman@wdc.com, swboyd@chromium.org,
        agk@redhat.com, josef@toxicpanda.com
Cc:     hch@infradead.org, hare@suse.de, bvanassche@acm.org,
        ming.lei@redhat.com, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mmc@vger.kernel.org,
        dm-devel@redhat.com, nbd@other.debian.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] dm: add add_disk() error handling
Message-ID: <YV2h/iA79JhMJt07@redhat.com>
References: <20210927215958.1062466-1-mcgrof@kernel.org>
 <20210927215958.1062466-5-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927215958.1062466-5-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Sep 27 2021 at  5:59P -0400,
Luis Chamberlain <mcgrof@kernel.org> wrote:

> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
> 
> There are two calls to dm_setup_md_queue() which can fail then,
> one on dm_early_create() and we can easily see that the error path
> there calls dm_destroy in the error path. The other use case is on
> the ioctl table_load case. If that fails userspace needs to call
> the DM_DEV_REMOVE_CMD to cleanup the state - similar to any other
> failure.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

