Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07882C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Feb 2022 10:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiBPKgQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Feb 2022 05:36:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiBPKgP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Feb 2022 05:36:15 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15C22B9A33
        for <linux-mmc@vger.kernel.org>; Wed, 16 Feb 2022 02:36:03 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b9so2967626lfv.7
        for <linux-mmc@vger.kernel.org>; Wed, 16 Feb 2022 02:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DPYWkKQW0nFWmY1xKFD4WRaxOqq/BeFHyxszPN5EPVU=;
        b=sUG7rjTRD6NrI48dGWwKOWJyGgjS5g2H1DjFZUQiMmRJj/ir9Wv7S+f3pcYhwB3G21
         jgW2ghTrDeTyWExposS8pU9olgt0OSFSsKqTWvFBrZtYeR1hzrMRB/QHZbRFsmF8Z2S0
         H/h0PiEEIFA7GmMAI2JMN3sa/fyLmEXYE57MT9xMELnMPIGAArOM53KTMVRbp5J3baMB
         isLqyWoSSBY1G4sXiIcXWs7lxW91pyd5h21jcWCoFLVEL0Fbk7le1PLdPy5uxaXftMdu
         5wLQBv6dJWYyW7H1/lavO2wyNL8O5n34jBSkfOXmCyy+T54Vr7Az+AHoRojt+05MRAOP
         vMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DPYWkKQW0nFWmY1xKFD4WRaxOqq/BeFHyxszPN5EPVU=;
        b=n43WDIk/eqju10pD6/bsId8KxDxVsVVZdnqAH08VB/GYKIhmzYRvx7WRuRndlQ2xlT
         XAON/VUWEq92hH5LzgE+vxnSDOV5ZqKPiEeGYX1VoOwu+a+UD7yz2UXijk6r3zZRF9ra
         qSSPigehM6o8DkKAly3ftgqw7az36BGfdwJkcxyjdQ9Quwvy1wxpbUIf4pVVOt+2SZek
         CDRkJdnai8X/4YnPxiyhM7gaK8FanYz/PSQ/xHU1m7AxcC7l5nfhmWzCqjGQOIZTzMrS
         PUd0qJ/cXuChAtI1Eh7Sd0lLV931l282G7MMFcuxSal7IlZAc/HopvxypJGMSUBAELAZ
         e3Jw==
X-Gm-Message-State: AOAM530FQWwYMxMyBd52CE+QkTZfe+LPaYtfkmy5g9wZrUYtaE4YRfD0
        9kNRQWke+RW/jnkqaGFBQ2DhHZx6kn/h238lpORi0A==
X-Google-Smtp-Source: ABdhPJz9lTvKXYqNUYEUwJcowusuOCgV3hil3k2PW920Mo0Cq3dd/tLhknO2IA4VJElhIgGQWuFNWTFzEa2t3lXDQAk=
X-Received: by 2002:a05:6512:388d:b0:443:6066:2c8d with SMTP id
 n13-20020a056512388d00b0044360662c8dmr1552732lft.184.1645007762118; Wed, 16
 Feb 2022 02:36:02 -0800 (PST)
MIME-Version: 1.0
References: <20220216093112.92469-1-Jerome.Pouiller@silabs.com>
In-Reply-To: <20220216093112.92469-1-Jerome.Pouiller@silabs.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Feb 2022 11:35:25 +0100
Message-ID: <CAPDyKFreMJigpAgE95EgkStNrE+r+_k9iRuTXsFk6t9d66e0TQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] staging: wfx: apply SDIO suggestions
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-mmc@vger.kernel.org,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 16 Feb 2022 at 10:31, Jerome Pouiller
<Jerome.Pouiller@silabs.com> wrote:
>
> From: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
>
> Hi Ulf, Greg,
>
> The second patch of this series touch to the staging tree and to the MMC
> framework. I don't know what is the rule for these cases, but I think it
> makes more sense to carry this patch with the staging tree.

I don't believe the changes to the mmc core will cause any merge
conflict, so feel free to funnel this through whatever tree makes best
sense.

For the series:
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

>
>
> J=C3=A9r=C3=B4me Pouiller (2):
>   staging: wfx: WF200 has no official SDIO IDs
>   staging: wfx: apply the necessary SDIO quirks for the Silabs WF200
>
>  drivers/mmc/core/quirks.h      | 5 +++++
>  drivers/staging/wfx/bus_sdio.c | 8 ++------
>  2 files changed, 7 insertions(+), 6 deletions(-)
>
> --
> 2.34.1
>
