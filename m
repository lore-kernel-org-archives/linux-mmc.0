Return-Path: <SRS0=oKGY=AH=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62E1C433E1
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Jun 2020 15:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9542D20702
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Jun 2020 15:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="aXUNBRHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbgFZPx4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730119AbgFZPxy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jun 2020 11:53:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2075CC03E97A
        for <linux-mmc@vger.kernel.org>; Fri, 26 Jun 2020 08:53:55 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s1so10883694ljo.0
        for <linux-mmc@vger.kernel.org>; Fri, 26 Jun 2020 08:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wS3ZoLwVxMYE5aOSMJlL4wxZx5NfasIcwsCreNsKCHg=;
        b=aXUNBRHApb/d4chCFqPEAPBCerd3HA1AvzgBAtxqWUNfOP2ounPi0BGuHU/6m1fMLy
         iZUgVzdo4eoyvRyCiukLyt5m7teU8Bt/nXESIblqrPBS8siY3NlycbomLgD6F4O97yVX
         Yc6EqjHlhno2UoZfMpghdRCPxOK8hvq8MMShIZpLFyWt+ICmU5qANsip6istpwh2ATbS
         7TJoAXNg7C+bWwqwIZ2bFiKsNqC4/dosBpHgjQKhtBrYHYNiUoePWmDXvonUWiz36CvB
         SBybpbeMe/pSr54YHQuY0qFNbrQn5/1Pu5ViKf1lJa4+hB4rJnGLh5593rzpjFuoFwXO
         B5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wS3ZoLwVxMYE5aOSMJlL4wxZx5NfasIcwsCreNsKCHg=;
        b=AkTUAhG2AIBhPeHaL4HFvPxMLsx1BlfxQFVL/BOSvd+RHC7anPJ3OhcKdpSHgO2k43
         43jHy4ji/zQKLwia+6N+38GToycyG0UW2E6JX91kgYtKtWeQW6AsoohB5meV5Hp53MJa
         23QKVDYxnNEMltiwvno4VlFZoNlvea84hoXgJpAgBhw2Y88bhKd/X0zpDEYtpEay10xS
         Y/7ECHoctrQASVyiVK1yId9/NbZ2cokRKKgMaHSg4cngS8yh9iqkp+4jTkaKemAsHk8J
         lGrdP01q9dQz9oNgT8CwPhPEvgKbhctUNfhcDA3fjRFTOF/2A+MoRwFId7AASXpBooR6
         wvRQ==
X-Gm-Message-State: AOAM530Lp6uzZlStD4xUM6hSGp+SCvX4Eve+cjnKNfIOhZMfQdtgC4fu
        hGvZGfAhE0oi7NIThTuPc332pQ==
X-Google-Smtp-Source: ABdhPJxVanab6IRVSKzmHEyKsqu6Hh1aLxUPDUAS04E63YfmDijCpVv/qdoDyztglfWI0L3Z931Ieg==
X-Received: by 2002:a2e:a548:: with SMTP id e8mr1822890ljn.76.1593186833518;
        Fri, 26 Jun 2020 08:53:53 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:4807:b213:5663:e485:3cf8:764f])
        by smtp.gmail.com with ESMTPSA id d6sm2733412lja.77.2020.06.26.08.53.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jun 2020 08:53:52 -0700 (PDT)
Subject: Re: [PATCH/RFC v4 3/4] mmc: core: Call mmc_poweroff_nofity() if
 regulators are disabled
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        ulf.hansson@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <1593163942-5087-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1593163942-5087-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <059bced3-00d3-cf2e-6628-a8c9f1544909@cogentembedded.com>
Date:   Fri, 26 Jun 2020 18:53:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1593163942-5087-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello!

On 06/26/2020 12:32 PM, Yoshihiro Shimoda wrote:

> If regulator_is_enabled() of both vmmc and vqmmc returns false,
> _mmc_suspend() should call mmc_poweroff_nofity() instead of
                                          ^^^^^^
  That hard word again. :-)        

> mmc_sleep().
> 
> Note that this is possible to happen when the regulator-fixed driver
> turns the vmmc and vqmmc off by firmware like PSCI while the system
> is suspended.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
[...]

MBR, Sergei
