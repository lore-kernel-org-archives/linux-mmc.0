Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE08C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Dec 2020 23:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9F123E54
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Dec 2020 23:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393134AbgLJXSs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Dec 2020 18:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393033AbgLJXSR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Dec 2020 18:18:17 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB74BC06138C
        for <linux-mmc@vger.kernel.org>; Thu, 10 Dec 2020 14:34:33 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id 125so166007pgf.10
        for <linux-mmc@vger.kernel.org>; Thu, 10 Dec 2020 14:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=wAy9QWmSbAjP+1vzLoCprV0JhS6b3tOG3oKCIiePlHY=;
        b=XoppR/t/VsHPixKkpY66yhU1MxaWjuDNxJNdhQnrk/nxTkfsAhaW3JhJt81/Ot9As2
         zilGS/RGnAisEXNhWUIjdpLIYuVEqe4HKXpstyCJVhqHpKc8B6Ziox6EDo4MNLVJiDJ/
         ut7zdSeJiDNd5LIpYZOXcteDS1idKVeUsbgMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=wAy9QWmSbAjP+1vzLoCprV0JhS6b3tOG3oKCIiePlHY=;
        b=WT/mssz/NDIXkM3jWqgrtUMuEgmjM3efExtHGaR/1igBxWprOC3nkIDe6Dp3v6C34z
         /Puy8H2xTv9KY077mumSRJVJp29N8hSFyg6cdcTDZ96bR+hsRlM0bR6v4iKLGOVuWL0y
         ZKg2VKfiQZFNUG5pb71e4fUbPEsXi9IF86eiaV6bkC6zWWUB3gX6t+mnx1goHecMGtxy
         1A3F1PUQPDV2xp4ncjHcWIkWoua0PSeew7GXLBstfC5pDH5k1wAcgXWgWn5M2oxS2y+o
         NqNfgPx48DBQklj98Z+WG/CNEFO7G+8koWsOIJ0VCSW5bBfDSCJQe20Fb2D6hEUjvA72
         Jtlg==
X-Gm-Message-State: AOAM531BfVFZ/P6u8fqISYIWuiAJszSXJ/IiQfxpDHrygx+CRNumilUU
        69pDKuoAqjuSKZhi/rHB8TEaxMTiFFfLvw==
X-Google-Smtp-Source: ABdhPJyCchftowUz5XPIXXQ53pvevHKPmlYhW+5uT6/c1SRldRP+CzB/QN4Ty5ZkR8Vnub1SqvrbGA==
X-Received: by 2002:a63:2406:: with SMTP id k6mr8556983pgk.453.1607637438657;
        Thu, 10 Dec 2020 13:57:18 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id u124sm7831835pfb.171.2020.12.10.13.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 13:57:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201210132745.v3.1.Iec3430c7d3c2a29262695edef7b82a14aaa567e5@changeid>
References: <20201210132745.v3.1.Iec3430c7d3c2a29262695edef7b82a14aaa567e5@changeid>
Subject: Re: [PATCH v3] mmc: sdhci-msm: Warn about overclocking SD/MMC
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     vbadigan@codeaurora.org, Taniya Das <tdas@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 10 Dec 2020 13:57:16 -0800
Message-ID: <160763743676.1580929.8043645391758481751@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Quoting Douglas Anderson (2020-12-10 13:27:52)
> As talked about in commit 5e4b7e82d497 ("clk: qcom: gcc-sdm845: Use
> floor ops for sdcc clks"), most clocks handled by the Qualcomm clock
> drivers are rounded _up_ by default instead of down.  We should make
> sure SD/MMC clocks are always rounded down in the clock drivers.
> Let's add a warning in the Qualcomm SDHCI driver to help catch the
> problem.
>=20
> This would have saved a bunch of time [1].
>=20
> [1] http://lore.kernel.org/r/20201210102234.1.I096779f219625148900fc984dd=
0084ed1ba87c7f@changeid
>=20
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
