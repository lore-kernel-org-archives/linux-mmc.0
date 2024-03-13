Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD701A59
	for <linux-mmc@vger.kernel.org>; Wed, 13 Mar 2024 12:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710333873; cv=none; b=nF9LBAJajn+jGlUXFMs4g8i6umes6lp/A6IPsHX05bdD7pkaCQUT/9sUOLXTJ/X4xjFHjy/of9iPziIfcUgFQpavBYchfAOs2yR0Cn8oXgAgB5lZYxpAMSYUJcosJ3SrCT6aE8vHrgXiQlXVBXLFvfAiX4lVaKSSZysElUkBT74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710333873; c=relaxed/simple;
	bh=Za+VCEZ7S1X7UvcSzunReZXA5L87+bWTEL0KAILM9pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/L3r5aDmYuA44S0tBJjlUkg/aSMfBy5pWDtx/hOi2peazVZkiXtex4hhO4lTSOfD/fSIWjAW7UHi84qnPSkgPugdDvomDZZ1bZLTycxnwbDBEdzmj6PewduPtwfXGhEHZKoMH7WlV2ausEdYXd3YqdLHfM3ie7nLZu4mMjhImk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jLkAuukw; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLkAuukw"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d27184197cso86877171fa.1
        for <linux-mmc@vger.kernel.org>; Wed, 13 Mar 2024 05:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710333870; x=1710938670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yOO7jlanZ1s4DVno7gfiEjdqFSy0vceCR8JXMxse3tk=;
        b=jLkAuukwhFY2pO+z/VzUF6nFK87bVL8OBGDyGT2L1IAoOPLkGNZ4bH7kxNQFfneqy6
         cKfQ7nTT7I9KAI10gfDQbZXuFxFSS/WsUdWDACM9YctnncN2Qo0S7PhGBHvFcDmRAkAu
         84wRIY9edp9rB8wPLegKqdcF5xQvKIBxjaDHdkJFW3nC2mX2hZw3BVqQWePNDHulopCf
         U4/jFvZeW1eDgraxjTrlPnZmkztU1R7vMHDYW2OgNIVcu6G6M2K1Y+ZJrtBEYBG+NRhD
         WbpphCYVHMuvaQTSI4qWaCDIkX6oNzb+eYITjVYkIdvnYBLBK/zpPTYOLnmbrMzETuSh
         Y0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710333870; x=1710938670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOO7jlanZ1s4DVno7gfiEjdqFSy0vceCR8JXMxse3tk=;
        b=sZvUVxmhT4uSIEURiLHICmY0LAGyOPHeOaKndXsC8Ww00Wiv7dci5lLl5xu/gyJAYV
         f7A6mQ/lIU8Z9vna446yO6ISOxstXE+FgPpCZqehhZHA937/vvCVoGWVDiS7Z7pXn5BJ
         K+qQTKzhw50mxT4uJROA39YBrudEy8Z/6N4lng70iqgo2dBDz4VBVahHPYgap5Gt2C2+
         3a2pxa2HwERRwvQ8XkV4RqTB40cdWuQBbNeZ1wb+0a7oC3kYFyhsMlV7N4LFKZnfZd+C
         PjfF5c1eV9DUq15eI1fZ5DoIyIXgy85SyZ/iGl/9EtnD+Vh38bmXzgnMmTOycEGMjBKa
         RhAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSOIS6qHtj0Cy1319sgXw5idKcr20Cltl/CLA5TrF87m72W1HoRTilaDFsP/3UHdnz4a4aUoW/KlbTDkplmscWhNmXMaXkKRe7
X-Gm-Message-State: AOJu0Yw7CtxqFbDquKotPaI95DREH/wOUguDnnkOim0ffno+tSXk2597
	xwQ5gkcctD7CuvEetUEGnn8hBMka5pafZ1Wcyc9f4djB8MnZgDs0nc6rD2RhK08=
X-Google-Smtp-Source: AGHT+IGcX6Ws5WLS0MGStavpcaVla6Yz/0oXjBMk6ZFJv9SJfyEjmN8hpjmx51BXUWcEyThJM8Ze5w==
X-Received: by 2002:a05:651c:141e:b0:2d3:3e83:8309 with SMTP id u30-20020a05651c141e00b002d33e838309mr7095665lje.19.1710333869822;
        Wed, 13 Mar 2024 05:44:29 -0700 (PDT)
Received: from nuoska (drt4d6yywjht56pm8q3st-3.rev.dnainternet.fi. [2001:14ba:7430:3d00:1239:a19d:315c:6ddf])
        by smtp.gmail.com with ESMTPSA id a20-20020a2e9814000000b002d45ad8efdesm703331ljj.106.2024.03.13.05.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 05:44:29 -0700 (PDT)
Date: Wed, 13 Mar 2024 14:44:27 +0200
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Avri Altman <Avri.Altman@wdc.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Daniil Lunev <dlunev@google.com>,
	Asutosh Das <quic_asutoshd@quicinc.com>
Subject: Re: [PATCH v4] mmc: core: Use mrq.sbc in close-ended ffu
Message-ID: <ZfGfq-E5iCINAEeW@nuoska>
References: <20231129092535.3278-1-avri.altman@wdc.com>
 <CAPDyKFqsyp=isawJKH0Q7Qqxqtkx=gmPZru9NnK-ndV20VRmFA@mail.gmail.com>
 <Ze8OXcCA_BCN2MVE@nuoska>
 <DM6PR04MB65751092AB94DDC87FE9505EFC242@DM6PR04MB6575.namprd04.prod.outlook.com>
 <Ze8eYFW4yZKcWxdo@nuoska>
 <CAHUa44Eptk+Mvf+vWReCACq6DLCSry0wT2U4aewq==4Q2Z1HCA@mail.gmail.com>
 <Ze8mICZ_22mV4jGQ@nuoska>
 <DM6PR04MB657544B8D60209776E674156FC242@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAHUa44E9qgFrdORQ4zdnHdqb1Dpo8ODk1ioquXNe8tJA86fWrA@mail.gmail.com>
 <ZfGSJBuBdzkoooYs@nuoska>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfGSJBuBdzkoooYs@nuoska>

On Wed, Mar 13, 2024 at 01:46:44PM +0200, Mikko Rapeli wrote:
<snip>
> Fix will be to initialize mmc_blk_ioc_data->flags in all cases. Would this be fine as
> a catch all initialization for mmc_blk_ioc_data?
> 
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -413,7 +413,7 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
>         struct mmc_blk_ioc_data *idata;
>         int err;
>  
> -       idata = kmalloc(sizeof(*idata), GFP_KERNEL);
> +       idata = kzalloc(sizeof(*idata), GFP_KERNEL);
>         if (!idata) {
>                 err = -ENOMEM;
>                 goto out;
> 
> I think this is a sensible and future proof way to go.
> 
> Then, the second flags check for MMC_BLK_IOC_SBC is accessing array using
> index i - 1, but is not checking if i == 0 which results in data[-1] access.
> I think this should be fixed with something like:
> 
> -       if (idata->flags & MMC_BLK_IOC_SBC)
> +       if (idata->flags & MMC_BLK_IOC_SBC && i > 0) {
> 
> Would you be fine with this?

In addition to these, is the original patch correct also when idata->rpmb is not true
but prev_idata is? I have no idea of the code but this looks a bit suspicious.

@@ -532,7 +544,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
                        return err;
        }
 
-       if (idata->rpmb) {
+       if (idata->rpmb || prev_idata) {
                sbc.opcode = MMC_SET_BLOCK_COUNT;
                /*
                 * We don't do any blockcount validation because the max size
@@ -540,6 +552,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
                 * 'Reliable Write' bit here.
                 */
                sbc.arg = data.blocks | (idata->ic.write_flag & BIT(31));
+               if (prev_idata)
+                       sbc.arg = prev_idata->ic.arg;
                sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
                mrq.sbc = &sbc;
        }

Cheers,

-Mikko
