Return-Path: <SRS0=aSBx=AS=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2788C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jul 2020 12:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7934420578
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jul 2020 12:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxjoivZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgGGMpA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGMo7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jul 2020 08:44:59 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9D6C061755
        for <linux-mmc@vger.kernel.org>; Tue,  7 Jul 2020 05:44:59 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u25so24651201lfm.1
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jul 2020 05:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XoAI4QLYoTXCLy1fapT0ahtDuiwoiIQSeb+22mAXJW0=;
        b=KxjoivZwJem0wMt8SdVJy95ATPbfBGIx7UVPlN221PDOpav8AeX6CAL5FfUKTbyL/o
         S7fLUlmhcJU+odY0+QtJ3IinR6mfCiPtQD8JpJI1bdtaKNnu2emBHw3a0AZbtrrj6KCg
         /+7uAe4Y7j7DlRAHm75zDQ5ElERAqnld/SxJ9we1i8Rw3drajnFZpz9gXwpYUG9o/hMF
         2cxmX9xwIJFSz/ifoifDlQab7FZz6b3XzYUapw0obDqv0xrqlv8ss2su+UJnrx9NHiFk
         bsprW2RIHT5l1QCExKUmr/e2gH/pSp6zdd+b3VBccdB4TbKDb0ZvtM3a1T4h7IY3wjoi
         ud4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XoAI4QLYoTXCLy1fapT0ahtDuiwoiIQSeb+22mAXJW0=;
        b=kJRd+QL9ZEgvm9xWZ0Evv9T/YqXYrXZASnqvMOLYUh2N2AOQIbiQqZV9+nSinDimjr
         PDPhbcVyukKG0klFKUvFCbt1Qwq1gGzcOZ8eTALrgPckJzaqw5YSaoV44yH+ovitdkew
         gt2rA1KxucnoQ1egtXGqJ7O3Yxoi24zG/xjMn22PJzDI6oTGDZ3Mjwy+tXyuBwBcjjzc
         AnCufAHb37VPklSxVJjEREyoiewTWGI4hw+rImLPVxBZFgVt0vWj1BBcpJOHKRBbgMjb
         rIhuaccMgg6jZ1dDQ57U/sjOTc7e77157xSDuiStwKCJHDQdklV5i9iIyXigbRxGmIMp
         vwqA==
X-Gm-Message-State: AOAM531ll6/sTYhiGhWcAlLiCqLsB/AAj8Z+16S6Z/TrDfJyxnaqEo6x
        3mvCsr7N8++AK2Pc9TyVPjaNIg/jTY6DAvmKn1w=
X-Google-Smtp-Source: ABdhPJyrP6NtyDCwuy4BqWui+dyDFwBH/e2UQ5b1gu83ejGn6nh54f4rQm3RFu1GuGBca/5Mro2LoW92kkj+RkpSsNY=
X-Received: by 2002:a19:14e:: with SMTP id 75mr33148401lfb.7.1594125897594;
 Tue, 07 Jul 2020 05:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5DMMCZPfwNbTaG8_iQhWg2K1XeO719nSA0Gsf2ywHy4jQ@mail.gmail.com>
 <20200205092653.GB2737@bogon.m.sigxcpu.org> <CAOMZO5AAzK0QprHpKHaFOANjspJKd_4YaoMqAoGYG4KftcyiYw@mail.gmail.com>
 <VI1PR04MB5040A046E5D93265AE636B29901C0@VI1PR04MB5040.eurprd04.prod.outlook.com>
 <VI1PR04MB504091C7991353F6092A8D91901A0@VI1PR04MB5040.eurprd04.prod.outlook.com>
 <CAOMZO5CkSSidzLUSBUvJNAio3SnmU-fisTbDCiLN9v1EjS+HHQ@mail.gmail.com> <5ad361195f2e191484c8a231be0f5a07@akkea.ca>
In-Reply-To: <5ad361195f2e191484c8a231be0f5a07@akkea.ca>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 7 Jul 2020 09:44:45 -0300
Message-ID: <CAOMZO5BarV1=6rx9L_hkJJLUQSicwPNUO4HFKWAXSQ6n0N+Kzg@mail.gmail.com>
Subject: Re: sdhci timeout on imx8mq
To:     Angus Ainslie <angus@akkea.ca>
Cc:     BOUGH CHEN <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Angus,

On Tue, Jun 30, 2020 at 4:39 PM Angus Ainslie <angus@akkea.ca> wrote:

> Has there been any progress with this. I'm getting this on about 50% of

Not from my side, sorry.

Bough,

Do you know why this problem affects the imx8mq-evk versions that are
populated with the Micron eMMC and not the ones with Sandisk eMMC?

Thanks
