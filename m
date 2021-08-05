Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633B9C4338F
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Aug 2021 11:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 414C461102
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Aug 2021 11:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241095AbhHELid (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Aug 2021 07:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241085AbhHELic (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Aug 2021 07:38:32 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE36C0613D5;
        Thu,  5 Aug 2021 04:38:17 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id a93so8525718ybi.1;
        Thu, 05 Aug 2021 04:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4sNrBXG3cmsa/j58MXPnQY+ureLEZb7SFaI4axcJxYI=;
        b=H8OXe89Tmp4MidjEkZBmS7XtFY8sjphNOTOYu9/ij5S66Qb3c5KocBgfP01ZQVagyh
         YrrqdxdrFzx0Qarw6B0M/H8U6W90XFtHPJm+7R14WRuhZnFuLVbau51Yf3JGUmZiRA8X
         Ii1eYJof4JY4Ea2+kyrX8z+3hcxUUvY5fX1S04QPozNHNjQ5Txh0XfnIbPgB/04sjk5G
         3XwB75A4357/Rk3X4oMa8FCNaq+hqukWR/XlDQFtE3AAhKNkb4OECHprlgQENXZs5VIm
         IGQMJSwhWkm6JIv6mlKXTg777F1U3shiJoBNX6at1WMOE2aVZ3s0i9jeY9WRfuP1BXGA
         yZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4sNrBXG3cmsa/j58MXPnQY+ureLEZb7SFaI4axcJxYI=;
        b=K+d7gL7w3qeiPqnNQpbs2djulssDzX5KEUHHaytqgmkXzAL7C681gO/RWfgw2gHswd
         FVlHCptQKdrXo3IlU1G/+Vv7VwKmjJpON2NbHp44Ga4U3uX9mFSiiHM14TL88nuk5qJA
         rvq8DOwl+g2dkTrWIv16A0uLHa43ZvJhFib9uRozQejq53vaFmSW6uOkUfuutgZSuoMf
         CYzuY0kebsR+wfgC+AOMFnNMHACHiXJtanmqFANCqt8t05UZODHsHuyXOPtExF0Rs51m
         P2RNpKmYHZS5z8LwIB0oapYEeAHazCGDF2nBiIwCrzRSV0svUPxRteLrMmpshS5pjh8s
         r4JA==
X-Gm-Message-State: AOAM531reMHzhbc6WJxKTXhFP/dy8Nj3G2rc31YdciU8IOne08vOaaCu
        J8J+h1/+ikP6er0xQM+iZnZ00hBbZM/9hcdFLyk=
X-Google-Smtp-Source: ABdhPJzNaVthwQzy/5Yu04j/gS54ZLHj33w/D2H88qsv5NOCWA4KIoWAOx6COVtIiUVpXk1pr1ta8u9P0brUJ/vhurE=
X-Received: by 2002:a5b:108:: with SMTP id 8mr5534615ybx.174.1628163496897;
 Thu, 05 Aug 2021 04:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210804143357epcas1p1c67eca591d8bb557c11b8175baaa8550@epcas1p1.samsung.com>
 <CAMdYzYrx8pgeyK7u=kcopZ+Wae+fQdr_uM4AuVjqWKfZYikgcA@mail.gmail.com> <a9aa636e-326f-a848-dd69-41df87c013af@samsung.com>
In-Reply-To: <a9aa636e-326f-a848-dd69-41df87c013af@samsung.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 5 Aug 2021 07:38:06 -0400
Message-ID: <CAMdYzYr9PX-9=kkCAfGe8Q0-D+gRo_qCwse8SiGVsmod7fffiA@mail.gmail.com>
Subject: Re: [BUG] mmc_regulator_set_ocr can't cope with regulator-fixed
To:     Jaehoon Chung <jh80.chung@samsung.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Aug 5, 2021 at 5:59 AM Jaehoon Chung <jh80.chung@samsung.com> wrote:
>
> Hi,
>
> On 8/4/21 11:32 PM, Peter Geis wrote:
> > Good Morning,
> >
> > I've encountered a fun issue with the dw-mmc driver while working on
> > enabling support for the Quartz-64 Model A.
> > The regulator-fixed driver supports enabling via a gpio, but does not
> > have the ops to set voltage as it is fixed.
> > The dw-mmc calls mmc_regulator_set_ocr for vmmc, which attempts to set
> > the voltage first but fails due to the lack of the voltage ops. It
> > then bails returning -EINVAL.
> > This leads to the following message :
> > dwmmc_rockchip fe2b0000.mmc: could not set regulator OCR (-22)
>
> What is vdd value (ocr_avail value) on your target?
> I didn't see its case until now. If there is a real bug, I will try to check again.

What brought this front and center is actually another bug with the
dw-mmc-rk driver (I don't know if it affects other dw-mmc drivers)
vmmc is 3.3v on this board, but with broken-cd set polling causes the
following splat constantly.

[   30.719846] dwmmc_rockchip fe2b0000.mmc: could not set regulator OCR (-22)
[   30.720488] dwmmc_rockchip fe2b0000.mmc: failed to enable vmmc regulator
[   30.763736] dwmmc_rockchip fe2b0000.mmc: could not set regulator OCR (-22)
[   30.764379] dwmmc_rockchip fe2b0000.mmc: failed to enable vmmc regulator
[   30.778231] dwmmc_rockchip fe2b0000.mmc: failed to set rate 300000Hz
[   30.795042] dwmmc_rockchip fe2b0000.mmc: failed to set rate 300000Hz
[   30.798735] dwmmc_rockchip fe2b0000.mmc: failed to set rate 300000Hz
[   30.816591] dwmmc_rockchip fe2b0000.mmc: failed to set rate 300000Hz
[   30.820303] dwmmc_rockchip fe2b0000.mmc: could not set regulator OCR (-22)
[   30.820944] dwmmc_rockchip fe2b0000.mmc: failed to enable vmmc regulator
[   30.834794] dwmmc_rockchip fe2b0000.mmc: failed to set rate 200000Hz
[   30.851606] dwmmc_rockchip fe2b0000.mmc: failed to set rate 200000Hz
[   30.855264] dwmmc_rockchip fe2b0000.mmc: failed to set rate 200000Hz
[   30.873197] dwmmc_rockchip fe2b0000.mmc: failed to set rate 200000Hz
[   30.876908] dwmmc_rockchip fe2b0000.mmc: could not set regulator OCR (-22)
[   30.877549] dwmmc_rockchip fe2b0000.mmc: failed to enable vmmc regulator
[   30.891396] dwmmc_rockchip fe2b0000.mmc: failed to set rate 100000Hz
[   30.911704] dwmmc_rockchip fe2b0000.mmc: failed to set rate 100000Hz
[   30.915586] dwmmc_rockchip fe2b0000.mmc: failed to set rate 100000Hz
[   30.948637] dwmmc_rockchip fe2b0000.mmc: failed to set rate 100000Hz

I looked through the code path and if the OCR voltage is set to the
fixed regulator voltage it should just return success. I think I need
to change that error to output the voltage it tried to set, just to
see if something weird is going on.

Also, I've got a possible fix to the dw-mmc issue, the following patch
changes the behavior to only enable a fixed regulator, not try to set
the voltage. It's a split between the behavior when vmmc isn't defined
at all and when its a variable regulator:

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index d333130d1531..b30102980261 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1446,11 +1446,13 @@ static void dw_mci_set_ios(struct mmc_host
*mmc, struct mmc_ios *ios)
  switch (ios->power_mode) {
  case MMC_POWER_UP:
  if (!IS_ERR(mmc->supply.vmmc)) {
- ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
- ios->vdd);
+ if (mmc->ocr_avail > 0)
+ ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
+ else
+ ret = regulator_enable(mmc->supply.vmmc);
+
  if (ret) {
- dev_err(slot->host->dev,
- "failed to enable vmmc regulator\n");
+ dev_err(slot->host->dev, "failed to enable vmmc regulator\n");
  /*return, if failed turn on vmmc*/
  return;
  }

>
> Best Regards,
> Jaehoon Chung
>
> >
> > This can be fixed by switching to regulator-gpio for the vmmc supply
> > to the sdmmc controller, however the sdio controller vmmc is provided
> > by a fixed regulator that is always on. Obviously the regulator-gpio
> > isn't an option, as it has no gpio to enable.
> >
> > Removing the vmmc phandle from the sdio node is an option, but then it
> > doesn't fully describe the hardware (it's also a non-standard 4.4v).
> > I had considered changing the check in dw-mmc.c [1] to continue in the
> > case of -EINVAL, but there are other places in the regulator framework
> > that can also return that and it doesn't address the underlying issue.
> >
> > As such I'm reaching out to the experts to see what the best course of
> > action is here.
> > Please weigh in with what you think.
> >
> > Very Respectfully,
> > Peter Geis
> >
>
