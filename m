Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796A2C64E7C
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Dec 2020 01:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A43A22228
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Dec 2020 01:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgLCBaK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Dec 2020 20:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgLCBaK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Dec 2020 20:30:10 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1BDC061A4D
        for <linux-mmc@vger.kernel.org>; Wed,  2 Dec 2020 17:29:24 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id q10so362133vsr.13
        for <linux-mmc@vger.kernel.org>; Wed, 02 Dec 2020 17:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fd/GRD9cyxAWL0iNFB8pBucV96AYVJpP+i+zKUmbx0M=;
        b=b8rb2+6vQ9VKN6FCi69FvHejkt9pxiQleJb7BmtYl7hCd/cr2V5fmKhrqXcHNjRXvo
         eejyaRxKYVc28uD0tDGZaLmX8XkYNZEiveN7to+V0u8BbI4Pj7XmxK3V+YVN3aQmYQto
         CmiNyn7qzTD5Z1Gj35MgZXgCQ7WiCDXMmEE6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fd/GRD9cyxAWL0iNFB8pBucV96AYVJpP+i+zKUmbx0M=;
        b=Xo7Gwc85b2PZX4H4hCVG4f3clxXCWOmIEGLvTI/ZpFmV1MbM9NMTr2DjpFlKTkpHX3
         3zjJMc6rsK1WnhE8V5sXlj3WxA85NRC5A8QwEzefqjCukI5OOeDwI5MfcFZRDgkHTHso
         ZMCfkbQtqMt9zkhjubRlX0NI8W1QQWB86Ywm21J/aDgmmZZS0UQ0aL5PaUw2Zsr7EcX8
         xOoFthnfU8RKrUnFeb9Xq6LB93ddbwHssZIUO/yPtVn3CBc3+suDm6o6bzBvgPdR3SOv
         LIRxF5h44okhXrxA4U5BKZbQea6z4cERiCONS/qEoxQiEwO9o5qmIgyMJvIz7un+BOKl
         3U9w==
X-Gm-Message-State: AOAM530WnJZd8KJjmXiaUVSu48R1XpPHWa8S/Mo0O/HjIL1aT8+MQN0F
        tRptgQu0crH0N+tCVILkgDprlTjGS8GVR9whGqJSBg==
X-Google-Smtp-Source: ABdhPJwnzZgt4PVfjCTCg+tkzqA9yIGlP8pZu6dqJXQE+Mou1h6Gm+tLzjrrviJw+tPJmXRc14VK37OMb134aBXt+Yg=
X-Received: by 2002:a67:2783:: with SMTP id n125mr761689vsn.47.1606958963527;
 Wed, 02 Dec 2020 17:29:23 -0800 (PST)
MIME-Version: 1.0
References: <20201118063405.24906-1-wenbin.mei@mediatek.com>
 <CAPDyKFpHAWBtxLOOvvqmAYFAwCsV66s_LzzVJg-zfXH5QE++Ng@mail.gmail.com> <1606266655.11864.7.camel@mhfsdcap03>
In-Reply-To: <1606266655.11864.7.camel@mhfsdcap03>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 3 Dec 2020 09:29:12 +0800
Message-ID: <CANMq1KBwtZNgkK5mEUdOk4sq05aXqQ59QsqYqapPqQr7DEWgMA@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: Add system suspend/resume interface
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This causes a 0-day warning (on our chromeos-5.4 backports but I don't
see why upstream would not be affected):
https://groups.google.com/g/cros-kernel-buildreports/c/MfS3SInT5jg/m/Hkzxh_U7AwAJ

Didn't look at the details of the config, but SET_SYSTEM_SLEEP_PM_OPS
is a noop if CONFIG_PM_SLEEP is not set (while SET_RUNTIME_PM_OPS is
noop-ed by CONFIG_PM).

So I guess msdc_suspend/msdc_resume should be guarded by
CONFIG_PM_SLEEP instead of CONFIG_PM.

On Wed, Nov 25, 2020 at 9:12 AM Wenbin Mei <wenbin.mei@mediatek.com> wrote:
>
> On Mon, 2020-11-23 at 17:06 +0100, Ulf Hansson wrote:
> > On Wed, 18 Nov 2020 at 07:34, Wenbin Mei <wenbin.mei@mediatek.com> wrote:
> > >
> > > Before we got these errors on MT8192 platform:
> > > [   59.153891] Restarting tasks ...
> > > [   59.154540] done.
> > > [   59.159175] PM: suspend exit
> > > [   59.218724] mtk-msdc 11f60000.mmc: phase: [map:fffffffe] [maxlen:31]
> > > [final:16]
> > > [  119.776083] mmc0: cqhci: timeout for tag 9
> > > [  119.780196] mmc0: cqhci: ============ CQHCI REGISTER DUMP ===========
> > > [  119.786709] mmc0: cqhci: Caps:      0x100020b6 | Version:  0x00000510
> > > [  119.793225] mmc0: cqhci: Config:    0x00000101 | Control:  0x00000000
> > > [  119.799706] mmc0: cqhci: Int stat:  0x00000000 | Int enab: 0x00000000
> > > [  119.806177] mmc0: cqhci: Int sig:   0x00000000 | Int Coal: 0x00000000
> > > [  119.812670] mmc0: cqhci: TDL base:  0x00000000 | TDL up32: 0x00000000
> > > [  119.819149] mmc0: cqhci: Doorbell:  0x003ffc00 | TCN:      0x00000200
> > > [  119.825656] mmc0: cqhci: Dev queue: 0x00000000 | Dev Pend: 0x00000000
> > > [  119.832155] mmc0: cqhci: Task clr:  0x00000000 | SSC1:     0x00001000
> > > [  119.838627] mmc0: cqhci: SSC2:      0x00000000 | DCMD rsp: 0x00000000
> > > [  119.845174] mmc0: cqhci: RED mask:  0xfdf9a080 | TERRI:    0x0000891c
> > > [  119.851654] mmc0: cqhci: Resp idx:  0x00000000 | Resp arg: 0x00000000
> > > [  119.865773] mmc0: cqhci: : ===========================================
> > > [  119.872358] mmc0: running CQE recovery
> > > From these logs, we found TDL base was back to the default value.
> > >
> > > After suspend, the mmc host is powered off by HW, and bring CQE register
> > > to the default value, so we add system suspend/resume interface, then bring
> > > CQE to deactivated state before suspend, it will be enabled by CQE first
> > > request after resume.
> > >
> > > Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> >
> > I took the liberty of renaming msdc_sys_suspend|resume to
> > msdc_suspend|resume, as I think the "_sys" is a bit superfluous.
> >
> > Additionally, I added a fixes+stable tag, then I applied this for fixes, thanks!
> >
> > Please tell me, if there is anything you would like me to change.
> >
> > Kind regards
> > Uffe
> >
> > It is OK for me, thanks for your help.
>
> > > ---
> > >  drivers/mmc/host/mtk-sd.c | 22 ++++++++++++++++++++--
> > >  1 file changed, 20 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > > index fc5ee5df91ad..c5f9cd6fc951 100644
> > > --- a/drivers/mmc/host/mtk-sd.c
> > > +++ b/drivers/mmc/host/mtk-sd.c
> > > @@ -2758,11 +2758,29 @@ static int msdc_runtime_resume(struct device *dev)
> > >         msdc_restore_reg(host);
> > >         return 0;
> > >  }
> > > +
> > > +static int msdc_sys_suspend(struct device *dev)
> > > +{
> > > +       struct mmc_host *mmc = dev_get_drvdata(dev);
> > > +       int ret;
> > > +
> > > +       if (mmc->caps2 & MMC_CAP2_CQE) {
> > > +               ret = cqhci_suspend(mmc);
> > > +               if (ret)
> > > +                       return ret;
> > > +       }
> > > +
> > > +       return pm_runtime_force_suspend(dev);
> > > +}
> > > +
> > > +static int msdc_sys_resume(struct device *dev)
> > > +{
> > > +       return pm_runtime_force_resume(dev);
> > > +}
> > >  #endif
> > >
> > >  static const struct dev_pm_ops msdc_dev_pm_ops = {
> > > -       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> > > -                               pm_runtime_force_resume)
> > > +       SET_SYSTEM_SLEEP_PM_OPS(msdc_sys_suspend, msdc_sys_resume)
> > >         SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
> > >  };
> > >
> > > --
> > > 2.18.0
> > >
>
