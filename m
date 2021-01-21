Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D7AC433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 15:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F0FF23A1E
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 15:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733014AbhAUPa6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Jan 2021 10:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732995AbhAUPat (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2021 10:30:49 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5694C061788
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jan 2021 07:30:08 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id j21so579258oou.11
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jan 2021 07:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yh44Qxrf3+J5SnhMnA0rx5pIze1zuLLqN86AC8WHNhk=;
        b=TCwTrp16z8Lztm1psaFL7rE/yVt8v+mjVp1ObImD4/Ulcik7gy/HqV3nkzD1ixdzAM
         eGfrFwC8tYyOzdusxgWbFYoVKjo3ZXGJp5M2rTPuEN8+Nw+L2vJtVI72tRnIAU6GvOPs
         ySp6f42MacoOipIl4ZSTKtRHWcogXpBaPpA9ZIQbwCXpOaxc9rK2b2zUaYw4WsP/JDT4
         48PkDujOCzNMBa3W7NcFex8UUA5ySdm/aIWdXseH1yDR2SO7gKgT+5riaPUrvBuG2jOW
         B84VE4oGY+aM3hFfwnRibvH3ex0wfo/Pj1ekHFaGh5jegPHSSgPnO5UTTvRQ0n5Fd09x
         tSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yh44Qxrf3+J5SnhMnA0rx5pIze1zuLLqN86AC8WHNhk=;
        b=Cd2nCV6nDT0V+Q5Xkb8zBLqyaiatR+kc8TWLearOiv4FrUhXgPvUsEeA0RqK10Cj/T
         uw9ou+/+qz85VGBoyMQO8yjowdanpo3Hc3tvAJi8UEQCFSQzTihgjnCTbsK9mpi4Fpb/
         L4jLubsbwSbOlcvo6NQmq6hy33CEZ9dBpEFD1GXy1ZU2zA6iQyzpcaeuhvm8PzACVd2f
         wMIEiMr4kUbpXzEPPbPrZwk8kn6+WmHSCmuMDoZrsiE0v146VdKXY7u+IEv8paFwq2Eb
         u+upI/vYDy+9SLAJ5q+OIQj8+RBn40ahfoxrtYd+/wDHeMpZJqSp8V2uFdrMwht1aZBK
         MEmw==
X-Gm-Message-State: AOAM533A/ETzmvU7CPSmuL6ny2x37Tm7s5TizwV/iMRbHmKwfV897Haw
        iK6wg9+Z67XXGLoe09daSQ7R6Q==
X-Google-Smtp-Source: ABdhPJxQHhIiYJ+qrMcAr6bi0vv2DvGBaXj8k1VbUa3szgnRbEjTRJWtS6LfZ2/eQUPXyqb5OaIG/w==
X-Received: by 2002:a4a:e9a7:: with SMTP id t7mr94550ood.31.1611243008067;
        Thu, 21 Jan 2021 07:30:08 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q127sm1130404oia.18.2021.01.21.07.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 07:30:07 -0800 (PST)
Date:   Thu, 21 Jan 2021 09:30:05 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Satya Tangirala <satyat@google.com>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v5 6/9] firmware: qcom_scm: update comment for
 ICE-related functions
Message-ID: <YAmd/b2y7vvp7udE@builder.lan>
References: <20210121090140.326380-1-ebiggers@kernel.org>
 <20210121090140.326380-7-ebiggers@kernel.org>
 <CAPDyKFoOL2Dsqb=nKw5hF5hiVLn-TDHWH4Th9icvoLY4aJtpSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFoOL2Dsqb=nKw5hF5hiVLn-TDHWH4Th9icvoLY4aJtpSA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu 21 Jan 08:42 CST 2021, Ulf Hansson wrote:

> - trimmed cc-list
> 
> On Thu, 21 Jan 2021 at 10:03, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > From: Eric Biggers <ebiggers@google.com>
> >
> > The SCM calls QCOM_SCM_ES_INVALIDATE_ICE_KEY and
> > QCOM_SCM_ES_CONFIG_SET_ICE_KEY are also needed for eMMC inline
> > encryption support, not just for UFS.  Update the comments accordingly.
> >
> > Reviewed-by: Satya Tangirala <satyat@google.com>
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Björn, may I have your ack on this one? I intend to queue this via my mmc tree.
> 

Certainly, sorry for not paying attention.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>


And I presume I'll take the dts patch (8/9) through the Qcom tree...

Regards,
Bjorn

> Kind regards
> Uffe
> 
> > ---
> >  drivers/firmware/qcom_scm.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> > index 7be48c1bec96d..f57779fc7ee93 100644
> > --- a/drivers/firmware/qcom_scm.c
> > +++ b/drivers/firmware/qcom_scm.c
> > @@ -965,8 +965,11 @@ EXPORT_SYMBOL(qcom_scm_ice_available);
> >   * qcom_scm_ice_invalidate_key() - Invalidate an inline encryption key
> >   * @index: the keyslot to invalidate
> >   *
> > - * The UFSHCI standard defines a standard way to do this, but it doesn't work on
> > - * these SoCs; only this SCM call does.
> > + * The UFSHCI and eMMC standards define a standard way to do this, but it
> > + * doesn't work on these SoCs; only this SCM call does.
> > + *
> > + * It is assumed that the SoC has only one ICE instance being used, as this SCM
> > + * call doesn't specify which ICE instance the keyslot belongs to.
> >   *
> >   * Return: 0 on success; -errno on failure.
> >   */
> > @@ -995,10 +998,13 @@ EXPORT_SYMBOL(qcom_scm_ice_invalidate_key);
> >   *                 units, e.g. 1 = 512 bytes, 8 = 4096 bytes, etc.
> >   *
> >   * Program a key into a keyslot of Qualcomm ICE (Inline Crypto Engine), where it
> > - * can then be used to encrypt/decrypt UFS I/O requests inline.
> > + * can then be used to encrypt/decrypt UFS or eMMC I/O requests inline.
> > + *
> > + * The UFSHCI and eMMC standards define a standard way to do this, but it
> > + * doesn't work on these SoCs; only this SCM call does.
> >   *
> > - * The UFSHCI standard defines a standard way to do this, but it doesn't work on
> > - * these SoCs; only this SCM call does.
> > + * It is assumed that the SoC has only one ICE instance being used, as this SCM
> > + * call doesn't specify which ICE instance the keyslot belongs to.
> >   *
> >   * Return: 0 on success; -errno on failure.
> >   */
> > --
> > 2.30.0
> >
