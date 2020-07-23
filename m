Return-Path: <SRS0=muGE=BC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5EDC433DF
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Jul 2020 07:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A67EF20771
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Jul 2020 07:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrUj0NYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgGWHRt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgGWHRs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jul 2020 03:17:48 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50114C0619DC
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2020 00:17:48 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n22so5264750ejy.3
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2020 00:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qyHrcsrwsfYaNfS6dumG4CyG3QYTNE/u+d1zSR/uPPA=;
        b=YrUj0NYNgWSzj/wATFLNlAhpKyV0QAh0nOAHzkO64e03hKYWyskkLGaA75/kScAfBZ
         SSbzSAx/n7ws5LURSdE6KVWYvk8pt/bbSSp0NAdCpULQCYve36E4P5sg0/llapwQB4Ei
         rRhdOd3GR3ODPrtVTZjahgyQ4rMG0QJfl2XReqWi9mvvpna+1+Iy+AOR25oRkM5k/v9M
         oIH4Fg6ax54CSr7Ahth793CuBPwUn/WEL8mOOBS9Zx1HcbTVr4WQkd/RDDe16AG8WFCk
         gtvkW2avo5gmi3Ha8qvRwEtB0NYPLJhsElcandIUcZZCtPG0GbadcwPNT8P/nL9bj0Zo
         qs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyHrcsrwsfYaNfS6dumG4CyG3QYTNE/u+d1zSR/uPPA=;
        b=iH62lEv9eZJuhjFzIhUoNs83WzbvKHe3xs6H6J8R3s3SB7Uprpk8oc/wJnLMfSNmoM
         PipedLL5OoDVp1+uO/gemAtJ4z/rUju3/XnyFnYCB7MsVTufXFjFU83IVh2i+fyWJvTg
         AZG6L0ni7trTdzuMzlZVpjPk+J6VFE7v+RIz49fNiSwMlTIdsnWMUNLSv7uKffNVxeD0
         z7Ktj0Rk1XbfiJj3hH98eEcPOXKv6aCXyT1ktMewpmNykJdX3yqKrvxC488VTUsA/P+n
         HXhjBXCbV17iJlr4hqoNr+VOXYZlOBLE2VCb1SK5DUDGib0GwefO4UU3/YeKbcN7dL/m
         Qhnw==
X-Gm-Message-State: AOAM53163ohGip7dYqYZU2thUYw1yjkw1U8cOvpx8bSBQqR5/ncNwRvH
        lfsCuAy/od5KOqO+qprFMQfC2ZEVj8VahzGRi9MnXA==
X-Google-Smtp-Source: ABdhPJwCeVelEsIOej3wNkcP9Ntgi2vBG4kgAikeipDd548cnyc7UHRj1oGbnytiH7qGkgJgacZdEytbyAF6fLx6GpQ=
X-Received: by 2002:a17:907:20af:: with SMTP id pw15mr3245019ejb.204.1595488666518;
 Thu, 23 Jul 2020 00:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAPDyKFrW6tXMVa_P=iAPk4FurH9+MGOvJiT7m8B72kz7p0-BnQ@mail.gmail.com>
 <20200401221453.267360-1-patrick.oppenlander@gmail.com>
In-Reply-To: <20200401221453.267360-1-patrick.oppenlander@gmail.com>
From:   Patrick Oppenlander <patrick.oppenlander@gmail.com>
Date:   Thu, 23 Jul 2020 17:17:35 +1000
Message-ID: <CAEg67Gk5XRJSM23JTP2FnKXP6iyP8_WU6UHhopdhyTw3tVLOHg@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: Fix scaling of cache size
To:     linux-mmc@vger.kernel.org
Cc:     chris@printf.net, Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Ping?

Kind regards,

Patrick
