Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5419BC433ED
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Apr 2021 15:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30DA86136A
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Apr 2021 15:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353344AbhDGPHW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Apr 2021 11:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242586AbhDGPHW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Apr 2021 11:07:22 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AC8C061756;
        Wed,  7 Apr 2021 08:07:12 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id mh7so18276451ejb.12;
        Wed, 07 Apr 2021 08:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DMi90Bi1B5eEKIW6qtlBkubiu414LxmGczys0i5jgMk=;
        b=gNQG8lxuAYON632rgm2noHLWPLKbWXU1NsupWZu/radPDfcVLuWIS5qmXS44L9v2pN
         atrveYSKSIzIijbETOpwSGofIs1jknTltXodL17PT24VLRLG7TvYNvXiqeoES/Gz++PH
         wQfUaKUeenkEEWqix0/iDqFIQi4D92OVV26MqG5Q4mZIn0Z9l0OcZJNURrezdd1nek0J
         /39PUdT8YTHGPe4FvrSurEHrtbIIjMWICrK3pszRTyde/bq+V0DjeWZi0+IHPvx3ob5j
         hjqo3AUDukUSs8wbqcY8WgoZ/jeyRAs7n/OEt0w+I6/6OPdTnNnS4eN4WsDygvQLOvDZ
         lPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DMi90Bi1B5eEKIW6qtlBkubiu414LxmGczys0i5jgMk=;
        b=dk1zntqabD8KxlpNg2TaH4t5ocGWLjwU9Qx+3BX5pSmPUV41Vy1XAWhhEDlvED3ejV
         bD9Y8p7XbyenZtuaMFRZUISgwBuXGyoQ0EJ+3fAWJFFjpgscezrZQs437aGHVg3hr1NX
         /upIg/9HucgFW1Gg115L6/0DJZRtSBAHiMY2bXthsYS95exqt0vhhKUnZHCPVJDBycex
         Iufu2rrwu3/b4/BFzZFg70G5EADh8MKttx0WdamzfPsp/J3GFuwT4asbxGNJF4zE/rZq
         N+GOTYBuTSqCVCVOAZFYdrGJzuhtOb9LuHeyLfpgwcR4B+EdCDmtAJ32+dc/OtBSuxoP
         HknQ==
X-Gm-Message-State: AOAM531J8+hOYVrH91sMn0bRBPXDkmZLjDbvdHzYP4+A4HAiY66/jw3h
        R6uS3jsBiKe4Ow4Cr0BYNBg=
X-Google-Smtp-Source: ABdhPJzjG5+vMalTo5MF4+sxjPdA2bO0Qz5I9laTTPnuMeEiykLdz9SCx7bfzkG4imeHbwoJ/is/2Q==
X-Received: by 2002:a17:906:4e8a:: with SMTP id v10mr4170803eju.6.1617808030878;
        Wed, 07 Apr 2021 08:07:10 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id gn19sm12436243ejc.4.2021.04.07.08.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 08:07:09 -0700 (PDT)
Date:   Wed, 7 Apr 2021 17:07:44 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Kamal Mostafa <kamal@canonical.com>
Subject: Re: [PATCH] mmc: sdhci-tegra: Add required callbacks to set/clear
 CQE_EN bit
Message-ID: <YG3KwJdljfJdawDQ@orome.fritz.box>
References: <20210407094617.770495-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MLJd7CPH3Lqt6IQZ"
Content-Disposition: inline
In-Reply-To: <20210407094617.770495-1-jonathanh@nvidia.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--MLJd7CPH3Lqt6IQZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 07, 2021 at 10:46:17AM +0100, Jon Hunter wrote:
> From: Aniruddha Tvs Rao <anrao@nvidia.com>
>=20
> CMD8 is not supported with Command Queue Enabled. Add required callback
> to clear CQE_EN and CQE_INTR fields in the host controller register
> before sending CMD8. Add corresponding callback in the CQHCI resume path
> to re-enable CQE_EN and CQE_INTR fields.
>=20
> Reported-by: Kamal Mostafa <kamal@canonical.com>
> Tested-by: Kamal Mostafa <kamal@canonical.com>
> Signed-off-by: Aniruddha Tvs Rao <anrao@nvidia.com>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--MLJd7CPH3Lqt6IQZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBtyr8ACgkQ3SOs138+
s6Gc3A/+OGjGBSu6DmmRhG25bPJqJTS6udCn0nIbbTgme6IMj4BvdH7z4GxX3viH
yGeKA2Ws3vv71lOST//HqJlUnVlcVC1y/vLlC07NnQ8a+csVehGF/1SOW/hmc3Vw
wF5nAKSTdzttlLm0j3yxsfIaw7l2JXh3Q4Snd/Nj0jR6fhw3dFcwTcn4RGI+qbbt
O30+luDa0U4vmlVPyzlkabF1A28YfJ7lzE6bbFslwwyBDirJEwBvipG+1ys4ARU5
A/XoDF03V2NMxY5LceHf/Ef6UbWOsV1+BDFC01k7roQKVeYmLa6oA7PMT9e9uR03
2Ejb5SOAcLuc/BQTHoaQxLJaHUiBipYgw5JO+IGq36CSxH1OnYbT2rTZv1A7btq4
bFiT4CeORks3d6fWsm0UFUyvNAGoCx9JnVnxIWJPXNQNccF/MAA8SUFMQjW6HTyG
mba4A3HGK3SjNn31Cl2y+fYDj8sQhYz3FUvtH/PPZOpgmIA95VLRSeV0sUzB5Dgn
8129mHHTQR+stlzmkDVcyjtvTXnORXGvDiDX7JVChky0OQLQBGxM7WU814EYmSaV
5m2OflVzRkb6pFlRsuXShqEZwvMbysrwbci5vXKJ6fh2SD1z/RNqtiomeTum6vj0
YlK4VsCK0VPJseFxu/NVEw2CJ7/GXo9Erm0+jAkixfUK9VjUXoM=
=JaU+
-----END PGP SIGNATURE-----

--MLJd7CPH3Lqt6IQZ--
