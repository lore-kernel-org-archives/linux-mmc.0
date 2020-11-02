Return-Path: <SRS0=jIX3=EI=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238A0C00A89
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Nov 2020 15:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB54C208A9
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Nov 2020 15:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vszG8vy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgKBPCi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Nov 2020 10:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgKBPCi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Nov 2020 10:02:38 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D32C0617A6
        for <linux-mmc@vger.kernel.org>; Mon,  2 Nov 2020 07:02:37 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id u7so7586187vsq.11
        for <linux-mmc@vger.kernel.org>; Mon, 02 Nov 2020 07:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gs96h025HZv6zxfLuQ7GPYuN1g7s81PAtEbZmQJN9Lw=;
        b=vszG8vy6AU5KXzG6+gdbGthzztozuNN71YIhOKk5pKVlqqyJvKHO2UbG3QO+IDjbU3
         lvVbPO++HwE74xPSNbJ3oKSffKH4+jM/GZbBtyXtiPY7PAaqgCEYKdoSB/TdZISFotgr
         xW1JmwsfRIbYlMKayfm4599inE6uVt5JwiwpyaDEHBbZB8iXo8+bNRiD6YIH97nNcIP1
         Hfn57HhayYjFxF1/wOTM6q8Xh1FOKooTLXmdTMulTprdIkidniSoydcnaI+50ZecwHJ5
         U8IFfnqom1NanWXMpmZa/DBlOVmAIzUPyFKRKsn3OmFzD6t5rA7cI+gXe+LvzqDvcq2K
         eMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gs96h025HZv6zxfLuQ7GPYuN1g7s81PAtEbZmQJN9Lw=;
        b=bm7A6lIIN7dHCx4KeHRSDd+hfubLvkJFp3xrfBO2c4al2yIx3yOHz4suq2kxFlXBY9
         cOcJWQbFNPbntb32nEtSidwlw39xF8YIA6hoq7rxdu33QRKFYgreQun5w4bdECyEnFzY
         O7G38SgT6M9KkQGtC6d22+85wEG4pTTgQ+F8lr7qru1d+1Qpvj1aLRmHjiSE/Y6bfG7c
         0gKEIrKBoHh17/uomqx8LvdHG3FpwStMtSkFMYGQGiv55EoFxBrEquHPk6eHdXpgpPH9
         B3z4ByKzD/VJlDDOMz4nft4uUfzLdow7Tq1xvWUk4QLQ8nG7yL2WlbU+tia+kUVaP1QN
         7/1g==
X-Gm-Message-State: AOAM533s4ui3wwTdfGoOPpoM6A61vrEwHBPj05NpFyspa+S+icSYXZ3c
        k2aZef3EGhgXOkoJ3uKcSUwzkEaNpXtpNSP0L14L8A==
X-Google-Smtp-Source: ABdhPJzBmFOst+ae5ltttYBa9PfDVFWaUh1XOmVWONToeZg5bYsVuquTqcFKv5fua9EN2fsE8dOyGeoGPKmL61VN938=
X-Received: by 2002:a67:ec9a:: with SMTP id h26mr14745308vsp.34.1604329356567;
 Mon, 02 Nov 2020 07:02:36 -0800 (PST)
MIME-Version: 1.0
References: <59a5676c-cbf7-4a8e-ace1-f079e09d21a8@gmail.com>
In-Reply-To: <59a5676c-cbf7-4a8e-ace1-f079e09d21a8@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Nov 2020 16:02:00 +0100
Message-ID: <CAPDyKFocOzHfaZyGPJbUDMiTrV1DoEUjdu7TMN5B1wPjBiBS2Q@mail.gmail.com>
Subject: Re: [regression, bisected] no MMC on rk3399-gru-kevin with 5.10-rc1
To:     Vicente Bergas <vicencb@gmail.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <treding@nvidia.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 30 Oct 2020 at 23:04, Vicente Bergas <vicencb@gmail.com> wrote:
>
> Hi,
> commit 21b2cec61c04bd175f0860d9411a472d5a0e7ba1
> mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v4.4
> broke booting rk3399-gru-kevin.
>
> The kernel waits forever for the root device to appear on MMC.

Waiting forever sounds weird to me.

> Removing the line containing PROBE_PREFER_ASYNCHRONOUS in
> drivers/mmc/host/dw_mmc-rockchip.c fixes the issue.

I am guessing when we enable async probe, we reveal some other
existing error. Or, perhaps the rootfs mount point become wrong?

Would it be possible to share a boot log (before/after) with some
driver probe debugging enabled?

Kind regards
Uffe
