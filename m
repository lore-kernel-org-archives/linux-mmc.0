Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FFACD8C8F
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Oct 2023 14:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjJJOc4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Oct 2023 10:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjJJOcz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Oct 2023 10:32:55 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FC599
        for <linux-mmc@vger.kernel.org>; Tue, 10 Oct 2023 07:32:53 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d8a000f6a51so6177157276.3
        for <linux-mmc@vger.kernel.org>; Tue, 10 Oct 2023 07:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696948372; x=1697553172; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0520DPBn2d5OaBxBSqjJ1HUwBUVPXbwN37sf3npMaeM=;
        b=rxHWaFVvjAezddsWDTyRpKnw4Q3jp/QPWJTVkN1a/NaZFhxuJBvoT0ge5GdB0ZD5ul
         /t/PZX9r9/otiFuEpjk3PTBBOzXITCGfWTo78o438cc3tvTsjDUFMqNVn9gEtF/m19B1
         AiqQ6/SxUpmur+yRtodDG2SMtmFNxZorotRmdwjkqL+6oFsGE5xAuapQWmVfAZGpurR9
         aD/+pbusXxM/r69H9TdTZy4F48YJVAHyOioHoAlyTIZNH8yIFBmymVdsmZbS0fg9Cqf2
         PmNiGGdfqEU1pelMg50wI14IUliyfADDo/28opxoRisxlDy/bCcZInMTIMF2ltrbO4ua
         GXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696948372; x=1697553172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0520DPBn2d5OaBxBSqjJ1HUwBUVPXbwN37sf3npMaeM=;
        b=JL20blPty0DD3rMSXRrYOwxwevskhVpFkvp0I6usVeS9ViXk3PLo6f5ADZkLSkFEFq
         aapIlpDZMX+xB0lp4D388U7v+1uztb9dymkR57BAWYG0UvIUEunxVelxlgaZ4jDh99tf
         q7VHoiOtn9SGJchc5lNlicZRV2La/2BmZa5t5g0u3F/qUu6f/XyX+waGrNl5yIWdT/Pw
         mXVhYSdKUuwKbWUjhSe22Ge1uSxjlYH2pq04dEzYHbym8TvG1/paB47vFW9p9WdXdXTN
         AX9Z6JcJ49HWHt3m9fZuxIRvML5R3A7DZDX1aeUItXdPKOnx7vf1p63AjZaRmQVO2ptb
         VF0w==
X-Gm-Message-State: AOJu0Yy4sBv5cK9fub/V5i3BE42N0jdoFu2ong4FG25SqiyhNl0Si0W8
        UeXjqqP5DzNE+/rWAMUxrw9BhkfBvsn4qEA540GY/aNOkgUhYctI
X-Google-Smtp-Source: AGHT+IEuMGlBhla72r7JvgVM+XvRIpYprzEyqU2OEMI7ajixBG1dMa6O0F0aeenPmBpE9UTSQ7mMlGw4qIrgX+vAZK4=
X-Received: by 2002:a25:cfd7:0:b0:d9a:3d72:bfab with SMTP id
 f206-20020a25cfd7000000b00d9a3d72bfabmr3506558ybg.40.1696948371094; Tue, 10
 Oct 2023 07:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230928180658.1795491-1-avri.altman@wdc.com>
In-Reply-To: <20230928180658.1795491-1-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Oct 2023 16:32:15 +0200
Message-ID: <CAPDyKFrhZP-8xR+6Hit5P7zjzaVfaoC66_GVC6oBEGugf-NFrA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mmc-utils: Revamp CSD register parsing
To:     Avri Altman <avri.altman@wdc.com>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 28 Sept 2023 at 20:08, Avri Altman <avri.altman@wdc.com> wrote:
>
> Dust-up this old code that practically left untouched since lsmmc got
> merged into mmc-utils.
>
> The first 3 patches are mostly cleanups, where the 4th is fixing a
> capacity calculation bug.
>
> v3:
>  - Add Avri as co-author to the 4th patch with Gang
>
> v2:
>  - remove the first patch from the original series that got accepted
>  - Fix an ARM64 compilation warning
>
> Avri Altman (4):
>   mmc-utils: lsmmc: Simplify prinitng manufacturer name
>   mmc-utils: lsmmc: Simplify interface processing functions
>   mmc-utils: lsmmc: Disintegrade print_mmc_csd
>   mmc-utils: lsmmc: Fix emmc capacity calculation
>
>  lsmmc.c | 1554 ++++++++++++++++++++++++++-----------------------------
>  1 file changed, 725 insertions(+), 829 deletions(-)
>

Applied to master, thanks!

Kind regards
Uffe
