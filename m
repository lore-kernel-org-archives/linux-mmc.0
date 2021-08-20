Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FC3C4338F
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Aug 2021 16:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADD756113E
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Aug 2021 16:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhHTQei (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Aug 2021 12:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhHTQeh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Aug 2021 12:34:37 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED913C061756
        for <linux-mmc@vger.kernel.org>; Fri, 20 Aug 2021 09:33:59 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id x10-20020a056830408a00b004f26cead745so15013940ott.10
        for <linux-mmc@vger.kernel.org>; Fri, 20 Aug 2021 09:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/C8NeHo7GpZkUH1MXjk90wBsd8C6uuIwq8RGb1Hq5vo=;
        b=IZP6XmBG5SL2HxTLGkkDDx0/FLxPIdyJJdRIudKqB/cJ5PKq6qEgam/BDbPyMLfM7f
         0zg2lzUj8Xj4r6szTG6ovaYq+wgcPJhiyYiEed/J/YvFOCeyQytIO8nfzLWzRO9wn5y/
         RYFQhWyBWqpIh7r+V2m8XKlZDol/Dz1Ls5qJGa+LUgPV74FcDLUpFTLELob79i2r4t2Z
         7IVd9RkjubFRtkRPkv/3eOTKPUmKLUhfnfVKuUEtfupfUuv5Cc6AJD1qY2Nfu74lypAZ
         NWx69F5Bm/YiQ14jsu+6OnJ/QvCKOiwflMtD3A/w2W2cADV+eD2Bt6hx8RqKWw3+cAD/
         Conw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/C8NeHo7GpZkUH1MXjk90wBsd8C6uuIwq8RGb1Hq5vo=;
        b=eN6TDFe38iLk3YGMvjhtELEtyT9q3iRyn6hwJHUFxvRdm+kjKhdXg9zKA5VuoBUdbp
         aUvewsBhHxSps8YeyJAtOeErcxSiEiTJZdWLHNg2dR91vnu4sGBxDClHdz53rG7zzz+D
         44UkSiOoM6MrH1K2dZY5s5jaEmzlsE3h+bqN11AyP9T7QfLMvqbAbJRzf+yFgelQKErC
         fwQ6+J3AvWhNptdPJkj02WL0oQP6m20JvQB94G2OzFx7kAkao1kpTx5Ju8RprUqsYcE1
         y8DSsV0NgV14aoiFzcd6ghr1qfAJgPU0jquo7QOXtHOEPSeN8t0a/yrjXjipu6nvLv24
         5VUw==
X-Gm-Message-State: AOAM530mUibt4xUGdcUoBwaIMr+xGYqP8IjaQAELRY0AvW1CFgc4+aXY
        D865bHqu7LDgbKKJzroKTSkw6A==
X-Google-Smtp-Source: ABdhPJxBghjCh0btKNfjwzvGN2Vxx1KHZIfWf5hcsClQM0NLrJC694h/EB+IoLCQTcq+zXsFqp+5HA==
X-Received: by 2002:a9d:7ccc:: with SMTP id r12mr17883793otn.350.1629477239291;
        Fri, 20 Aug 2021 09:33:59 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r20sm202737oot.16.2021.08.20.09.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 09:33:58 -0700 (PDT)
Date:   Fri, 20 Aug 2021 09:35:21 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>, linux-mmc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 10/15] pwrseq: add support for QCA BT+WiFi power
 sequencer
Message-ID: <YR/ZyVrkmfVd0a8r@ripper>
References: <20210817005507.1507580-1-dmitry.baryshkov@linaro.org>
 <20210817005507.1507580-11-dmitry.baryshkov@linaro.org>
 <YR7m43mURVJ8YufC@ripper>
 <CAA8EJpr+=Yg2B_DzQWntW0GgvBfaSpAu0K+UD3NowdkusiYxrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpr+=Yg2B_DzQWntW0GgvBfaSpAu0K+UD3NowdkusiYxrQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri 20 Aug 01:10 PDT 2021, Dmitry Baryshkov wrote:

> Hi,
> 
> On Fri, 20 Aug 2021 at 02:17, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Mon 16 Aug 17:55 PDT 2021, Dmitry Baryshkov wrote:
> > [..]
> > > diff --git a/drivers/power/pwrseq/pwrseq_qca.c b/drivers/power/pwrseq/pwrseq_qca.c
> > > new file mode 100644
> > > index 000000000000..3421a4821126
> > > --- /dev/null
> > > +++ b/drivers/power/pwrseq/pwrseq_qca.c
> > > @@ -0,0 +1,290 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (c) 2021, Linaro Ltd.
> > > + *
> > > + * Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > + *
> > > + * Power Sequencer for Qualcomm WiFi + BT SoCs
> > > + */
> > > +
> > > +#include <linux/delay.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pwrseq/driver.h>
> > > +#include <linux/regulator/consumer.h>
> > > +
> > > +/*
> > > + * Voltage regulator information required for configuring the
> > > + * QCA WiFi+Bluetooth chipset
> > > + */
> > > +struct qca_vreg {
> > > +     const char *name;
> > > +     unsigned int load_uA;
> > > +};
> > > +
> > > +struct qca_device_data {
> > > +     struct qca_vreg vddio;
> >
> > Any particular reason why this isn't just the first entry in vregs and
> > operated as part of the bulk API?
> 
> Because VDDIO should be up before bringing the rest of the power
> sources (at least for wcn39xx). This is usually the case since VDDIO
> is S4A, but I'd still prefer to express this in the code.
> And register_bulk_enable powers up all the supplies asynchronously,
> thus it can not guarantee that the first entry would be powered up
> first.
> 

Ahh, forgot about the async nature of bulk_enable. Make the code a
little ugly, but it needs to be done like that.

Thinking about it, isn't there a required minimum time between vddio and
the others in the wcn specification?

> >
> > > +     struct qca_vreg *vregs;
> > > +     size_t num_vregs;
> > > +     bool has_bt_en;
> > > +     bool has_wifi_en;
> > > +};
> > > +
> > > +struct pwrseq_qca;
> > > +struct pwrseq_qca_one {
> > > +     struct pwrseq_qca *common;
> > > +     struct gpio_desc *enable;
> > > +};
> > > +
> > > +#define PWRSEQ_QCA_WIFI 0
> > > +#define PWRSEQ_QCA_BT 1
> > > +
> > > +#define PWRSEQ_QCA_MAX 2
> > > +
> > > +struct pwrseq_qca {
> > > +     struct regulator *vddio;
> > > +     struct gpio_desc *sw_ctrl;
> > > +     struct pwrseq_qca_one pwrseq_qcas[PWRSEQ_QCA_MAX];
> > > +     int num_vregs;
> > > +     struct regulator_bulk_data vregs[];
> > > +};
> > > +
> > > +static int pwrseq_qca_power_on(struct pwrseq *pwrseq)
> > > +{
> > > +     struct pwrseq_qca_one *qca_one = pwrseq_get_data(pwrseq);
> > > +     int ret;
> > > +
> > > +     if (qca_one->common->vddio) {
> >
> > devm_regulator_get() doesn't return NULL, so this is always true.
> 
> This is more of the safety guard for the cases when the qca doesn't
> have the special vddio supply.
> 

If you think there's such a case coming up, then it makes sense.
On the flip side, debugging the resulting panic when someone adds a new
compatible without vddio is very minor...


I think this looks good then.

Regards,
Bjorn
