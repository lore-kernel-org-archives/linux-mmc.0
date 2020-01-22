Return-Path: <SRS0=yZYV=3L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DC3C33CAF
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Jan 2020 16:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF5A24656
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Jan 2020 16:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g5mzDL6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAVQ5a (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:57:30 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41794 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgAVQ5a (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jan 2020 11:57:30 -0500
Received: by mail-pf1-f196.google.com with SMTP id w62so118638pfw.8
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2020 08:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=9LNpISLBBtmZPXNKsiH0lufw2QrgHH3oOxpdWJdbgPM=;
        b=g5mzDL6dVlGjCnPBzczWoxg5k4Yh5gc+T56tvHgovpgDUdYThPuIT0D0uBdiOhPJXy
         X8GtFl/rC8JO/xwNRXhAChPXrR8k304gYvr12LD4euWJePnIuCGX9/wezUK7T86twNFl
         61BHtu0trihkmhYsv3/EVWFi5ybajHZY2ZGwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=9LNpISLBBtmZPXNKsiH0lufw2QrgHH3oOxpdWJdbgPM=;
        b=YOYM0pqwDQbj39kFqXcImkkCwXisQM2ai1BM6XRqHs3QQZdj7HkUh8lirvuS/zWDQM
         yUAV0PDkfmeMldgxfEhPRXwUK0y4tuemknqRTaQj9xn79VlJOjTvK5w3xQJwHEfbTtf8
         ypzMn2VPILlvQMwu5T8Pj+Ax/J1TE+a1iO6kiY4y9JD/7ibTm47KhtVJjmAQVneuRlwm
         e1TSCwxHfWKalvIPff+fs3VgCVZ8iHQtg4+KfylxkSS3wj1fEc1aQMu4P2H1fplW+IZ9
         +C7akVok9/wKzeCGptMDTcHtTRstns8Etf0wIcISDMDhrYkCdwaBtJcqgugzEgjTHJKR
         PFOg==
X-Gm-Message-State: APjAAAWz3mc21H21IPGjUsBvbJRkdXXvUU5lcDyfbme/Uepp45SMJNWc
        q3GsS15vckZr30EYMflxAg/6Xg==
X-Google-Smtp-Source: APXvYqwTvQymP17CF0MbRVMcbMrpGvYkD/WLGbAlHkqEbbOryCDsRTj2ir6Av/MFbAe390j8UEXyoQ==
X-Received: by 2002:a63:1c5e:: with SMTP id c30mr12399716pgm.30.1579712249359;
        Wed, 22 Jan 2020 08:57:29 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id o23sm2480108pgn.17.2020.01.22.08.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 08:57:28 -0800 (PST)
Message-ID: <5e287ef8.1c69fb81.cacd.4c1b@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1579617022-13031-1-git-send-email-sbhanu@codeaurora.org>
References: <1579617022-13031-1-git-send-email-sbhanu@codeaurora.org>
Cc:     asutoshd@codeaurora.org, stummala@codeaurora.org,
        vbadigan@codeaurora.org, sayalil@codeaurora.org,
        cang@codeaurora.org, rampraka@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>
To:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        adrian.hunter@intel.com, ulf.hansson@linaro.org
Subject: Re: [PATCH V1] mmc: sdhci-msm: Add system suspend/resume callbacks
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 22 Jan 2020 08:57:27 -0800
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Quoting Shaik Sajida Bhanu (2020-01-21 06:30:22)
> Add system suspend/resume callbacks to sdhci-msm platform driver.

Yes, but why? There are already suspend/resume callbacks so this is
replacing them too.

>=20
> Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 47 ++++++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 45 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 71f29ba..4984857 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2028,9 +2028,52 @@ static __maybe_unused int sdhci_msm_runtime_resume=
(struct device *dev)
>         return 0;
>  }
> =20
> +static int sdhci_msm_suspend(struct device *dev)
> +{
> +       struct sdhci_host *host =3D dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host =3D sdhci_pltfm_priv(pltfm_host);
> +       int ret =3D 0;
> +
> +       if (host->mmc->caps2 & MMC_CAP2_CQE) {

It would be nice if this if check was rolled into cqhci_suspend so that
all the callers wouldn't have to check it.

> +               ret =3D cqhci_suspend(host->mmc);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       disable_irq(msm_host->pwr_irq);

Why is the irq disabled? Please add a comment.

> +       ret =3D sdhci_suspend_host(host);
> +       if (ret)
> +               return ret;
> +
> +       return sdhci_msm_runtime_suspend(dev);

pm_runtime_force_suspend() does different things than just call the
runtime suspend function for the driver. For example, it disables
runtime PM on the device. Can you explain in the commit text how this is
a correct conversion?

> +}
> +
> +static int sdhci_msm_resume(struct device *dev)
> +{
> +       struct sdhci_host *host =3D dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host =3D sdhci_pltfm_priv(pltfm_host);
> +       int ret =3D 0;
> +
> +       ret =3D sdhci_msm_runtime_resume(dev);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D sdhci_resume_host(host);
> +       if (ret < 0)
> +               return ret;
> +       enable_irq(msm_host->pwr_irq);

Same question here about irq. Deserves a comment.

> +
> +       if (host->mmc->caps2 & MMC_CAP2_CQE)
> +               ret =3D cqhci_resume(host->mmc);
> +
> +       return ret;
> +}
> +
>  static const struct dev_pm_ops sdhci_msm_pm_ops =3D {
> -       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -                               pm_runtime_force_resume)
> +       SET_SYSTEM_SLEEP_PM_OPS(sdhci_msm_suspend,
> +                               sdhci_msm_resume)
>         SET_RUNTIME_PM_OPS(sdhci_msm_runtime_suspend,
>                            sdhci_msm_runtime_resume,
>                            NULL)
