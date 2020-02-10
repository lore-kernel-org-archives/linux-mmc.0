Return-Path: <SRS0=yrVg=36=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5CDC352A5
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Feb 2020 19:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546CF20842
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Feb 2020 19:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e9afxVCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgBJTlV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:41:21 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35431 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJTlT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Feb 2020 14:41:19 -0500
Received: by mail-pf1-f195.google.com with SMTP id y73so4213271pfg.2
        for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2020 11:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=7ivqNM+XNnF2NduI9XPvPsjcawkQDDIuJxxbUTZS70I=;
        b=e9afxVCBltANlhIP0TTphK41BACkirOo7MmnkUOHrwI8/ONL4gUNJW+/jlutjgIyTM
         m9iTPLTxC1GUGwK7rlEsp/ZfgE+POtAnN0+2wd/9XPHTH9R5VZ+NRsKBCVx9lYgoGZn9
         sZmgX4+usRBPoE8eCS2k/9rH0l4pzMF+f4BL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=7ivqNM+XNnF2NduI9XPvPsjcawkQDDIuJxxbUTZS70I=;
        b=m/sC2HhT6Bn4ZN2Oy5BPk2d5iq1MQRmNgB7pU2aQjhvmdvr0+fXP+sM9Sf15Munfp6
         zkofFIGxe+D0OXZ83qCDI2VfDK657E2Dmb5U29LychSrJCEvigX7Uo8o1uyqJ/iT6Lyx
         IIfXR2HbDWhCY+kLPwyh+849OQrg1QTnIQITxrXRSSV3liwaHmuc9vcd8HEhiMok6gFU
         zcuPS6Bb9FVZ3hF5UKytx94rJhUfOF3PZpuD/Wgx6pIM0sDn9flTY5MftNnf72ZvXDDW
         Z+dxtUj87saxlD9QFCfBsLYv0xhGWU40F/3dYHcB4yZsW91cMEvoclKkmGyYHXrtXOw4
         cXCw==
X-Gm-Message-State: APjAAAWG8qWgmd3GH468oPfCAFlXwVDSAbSs4lc0kaH3VVUnzjcSy4in
        5kSryK7Plf4hZgWJeqqSk29Zjg==
X-Google-Smtp-Source: APXvYqyL3xU2GxC0ppxiK1j1x5dqjfCDDqBmdVXIr+06LB0Gb7x6nvbyw6kgjLFqdzL7dOSmuxanxA==
X-Received: by 2002:a62:e91a:: with SMTP id j26mr2645081pfh.189.1581363677533;
        Mon, 10 Feb 2020 11:41:17 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 199sm1276209pfv.81.2020.02.10.11.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:41:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1581081650-22228-1-git-send-email-sbhanu@codeaurora.org>
References: <1581081650-22228-1-git-send-email-sbhanu@codeaurora.org>
Subject: Re: [PATCH V2] mmc: sdhci-msm: Update system suspend/resume callbacks of sdhci-msm platform driver.
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     asutoshd@codeaurora.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, cang@codeaurora.org,
        rampraka@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>
To:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        adrian.hunter@intel.com, mka@chromium.org, robh+dt@kernel.org,
        ulf.hansson@linaro.org
Date:   Mon, 10 Feb 2020 11:41:16 -0800
Message-ID: <158136367603.121156.1867941302835915258@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Quoting Shaik Sajida Bhanu (2020-02-07 05:20:50)
> The existing suspend/resume callbacks of sdhci-msm driver are just
> gating/un-gating the clocks. During suspend cycle more can be done
> like disabling controller, interrupts and card detection.
>=20
> So updating the system pm callbacks for performing these extra
> actions besides controlling the clocks.
>=20
> Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
>=20
> Changes since V1:
>         Addressed review comments

Please don't write this. Instead, describe what's actually different so
the reader doesn't have to go figure out what the review comments were.

> ---
>  drivers/mmc/host/sdhci-msm.c | 50 ++++++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 48 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index c3a160c..e30c8a3 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2159,9 +2159,55 @@ static __maybe_unused int sdhci_msm_runtime_resume=
(struct device *dev)
>         return 0;
>  }
> =20
> +static int sdhci_msm_suspend(struct device *dev)
> +{
> +       struct sdhci_host *host =3D dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host =3D sdhci_pltfm_priv(pltfm_host);
> +       int ret;
> +
> +       if (host->mmc->caps2 & MMC_CAP2_CQE) {
> +               ret =3D cqhci_suspend(host->mmc);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ret =3D sdhci_suspend_host(host);
> +       if (ret)
> +               return ret;
> +       /* Disable pwr-irq since SDHC would be inactive */
> +       disable_irq(msm_host->pwr_irq);

Why do we need to do this? If it's inactive then the irq won't be raised
by the inactive hardware. Given that we're going to suspend the device,
the irq won't matter unless it's marked for wakeup. Please remove this
irq enable/disable logic, or explain why it's really needed.

> +
> +       return pm_runtime_force_suspend(dev);
> +}
> +
