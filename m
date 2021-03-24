Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D17C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Mar 2021 15:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 535F061A09
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Mar 2021 15:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbhCXP5z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Mar 2021 11:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236815AbhCXP5g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Mar 2021 11:57:36 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EFBC061763
        for <linux-mmc@vger.kernel.org>; Wed, 24 Mar 2021 08:57:35 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e33so14926307pgm.13
        for <linux-mmc@vger.kernel.org>; Wed, 24 Mar 2021 08:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=vkGG8bUzJ/OVR7TWK+g6aM9CPt6H+03+5FXXpdHLRXs=;
        b=mFfsg9CAhQ7vrBj3AZE/UKgwUhB0vOhtTEJxJtcvtrmX5cDKoWu7XdE57pPpInQOZf
         xCeMurZmoMNVn9ddCq4uCcfafMu9J6oj8FV5hE8C6qU0sFzWz1Iu6vzIVha3BM9rGmqt
         1EMaYSdqLIjIECrj4UXq2PinIH4dQ0qlvl/FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=vkGG8bUzJ/OVR7TWK+g6aM9CPt6H+03+5FXXpdHLRXs=;
        b=e6Qn+lqRTK7laliMrpfEJgW10IgtR/wT6GeoQHCG/qJXhRvy5SzvfNi8FwvcmdN0eP
         K4VPERzzEd2QGKx7wI6P0gA9i0Wj8u0gQtcdnVOBmtKE7pK9kfxzz+32aYDArWLV629y
         rcDw5paXZ6138i4kMq2P3NnEXUtiTDB4QaR0jMNEC8yb8TiisCIkk29i5CagGJjHKWca
         xvrDY5ZM5AakV5UvXEO6v8rrHT13h5bd9XOU7X4f3uRJOWfLbTnyrFMpRpHg8qsAeMiO
         m6K9b4X2pv1TpCF3gx3Hy2x6SgXcAk4EJvn3come8z9iLTl3IjlJdOMneiJiqy+m8gYY
         uZVg==
X-Gm-Message-State: AOAM532N/GcZymjWnmByOx73kNcsr+/V2d80R47ymVQJ8Uga0yHP6m1D
        9LoizZYF5kVno3pLzbzaznJuLYrUQYGX6A==
X-Google-Smtp-Source: ABdhPJzq3OI2MiKQe4UaXXrUM7c98RiM4f9SWoEhpyTP/B/upNfcZwdR113tblS99Z4fyKv3gVr5dQ==
X-Received: by 2002:a62:3085:0:b029:1ec:a570:682c with SMTP id w127-20020a6230850000b02901eca570682cmr3868415pfw.28.1616601455443;
        Wed, 24 Mar 2021 08:57:35 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:84ac:62f7:16a8:ccc7])
        by smtp.gmail.com with ESMTPSA id j3sm3055731pfi.74.2021.03.24.08.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 08:57:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <363c5b7d9baca5a010552137f80a1cf4@codeaurora.org>
References: <1616264220-25825-1-git-send-email-sbhanu@codeaurora.org> <161648289959.3012082.11356063123403968180@swboyd.mtv.corp.google.com> <363c5b7d9baca5a010552137f80a1cf4@codeaurora.org>
Subject: Re: [PATCH V2] arm64: dts: qcom: sc7280: Add nodes for eMMC and SD card
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     adrian.hunter@intel.com, robh+dt@kernel.org,
        ulf.hansson@linaro.org, asutoshd@codeaurora.org,
        stummala@codeaurora.org, vbadigan@codeaurora.org,
        rampraka@codeaurora.org, sayalil@codeaurora.org,
        sartgarg@codeaurora.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, sibis@codeaurora.org,
        cang@codeaurora.org, pragalla@codeaurora.org,
        nitirawa@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org
To:     sbhanu@codeaurora.org
Date:   Wed, 24 Mar 2021 08:57:33 -0700
Message-ID: <161660145349.3012082.16210818967187877873@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Quoting sbhanu@codeaurora.org (2021-03-24 08:23:55)
> On 2021-03-23 12:31, Stephen Boyd wrote:
> > Quoting Shaik Sajida Bhanu (2021-03-20 11:17:00)
> >> +
> >> +                       bus-width =3D <8>;
> >> +                       non-removable;
> >> +                       supports-cqe;
> >> +                       no-sd;
> >> +                       no-sdio;
> >> +
> >> +                       max-frequency =3D <192000000>;
> >=20
> > Is this necessary?
> yes, to avoid lower speed modes running with high clock rates.

Is it part of the DT binding? I don't see any mention of it.
