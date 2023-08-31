Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C949C6FA8F
	for <linux-mmc@archiver.kernel.org>; Thu, 31 Aug 2023 00:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238932AbjHaAmi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Aug 2023 20:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjHaAmh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Aug 2023 20:42:37 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8988F
        for <linux-mmc@vger.kernel.org>; Wed, 30 Aug 2023 17:42:35 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6bd0a0a6766so309693a34.2
        for <linux-mmc@vger.kernel.org>; Wed, 30 Aug 2023 17:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693442554; x=1694047354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dlcuc28wNXxkp3oqXdY8kbbgG+AHVoBzRLKl6J2yon4=;
        b=eyKoNb9miinD3fqPA/1xWZsgNTZ2no3IsutWMuR5JNLBWiA+4l3M8dtz7JOyQSXmJU
         +/71vQfQzS/+XrtDKWsx18NggfR5WGhaM1bMlkxxRR9lz10zNClEP2FJ0hWWsSG78MlN
         4L01cdROx2vK1BTX68fUGNzX2B2gwaGhTBe/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693442554; x=1694047354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dlcuc28wNXxkp3oqXdY8kbbgG+AHVoBzRLKl6J2yon4=;
        b=eEFq5Sf48ZrZ2IIJhPfV12aZU5RRK+0vaZGatFgpjppSOsYcD3g0cdrVUha7fOSuVL
         qG8CVDQz3eqI440YAcidrtsemf573mE6CgS5Hz0bPbxAKZG9/gUr8s5Gyg5MW0GF2B0p
         2Vvbi4NT9QV8IA3OmR3Z2EnJRY5korSaRt2EYsV/Rpl/U8aP6kaKQI+M40Bu5k79vPwh
         6QXC0WgusEx+p4LvOFRfgluzz9ImP6dwebFCvLaBRfv1DcJYEpuAg+mwUV1tebSueuhC
         BPPr1vFBuH3ZKOCcwM/eCI3zl8ByVc0ZZS1RkxKk1au2SEAOeER+wm/IwVs2USqUPYP6
         sd1g==
X-Gm-Message-State: AOJu0YxX3K5gnDM78InyIKjpF77rAq8RdR8leXgt6x6oXKJm03p+3r4i
        +hzq1/zQFjBwHqA0W7elHOpfWXD+CIvi602uqM2y6w==
X-Google-Smtp-Source: AGHT+IFdt+d3mQ5CEdRbz2IFVyH9djoyQRRp5qFBQpfUZVOvZBYJ9SHfV/cmVQO3wDX3fTDpUS6B+wVXcH/37kJVvus=
X-Received: by 2002:a05:6870:5596:b0:1bb:509a:824f with SMTP id
 n22-20020a056870559600b001bb509a824fmr4560826oao.55.1693442554700; Wed, 30
 Aug 2023 17:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <391c4270-637a-2afb-210d-6b6dfef01efa@intel.com>
 <20230828100313.3051403-1-benchuanggli@gmail.com> <CAG-rBig+koxDf3TuC-0p=tcBY_2WM1sPCvRDtjRmR7AnikrN-A@mail.gmail.com>
 <CACT4zj-BaX4tHji8B8gS5jiKkd-2BcwfzHM4fS-OUn0f8DSxcw@mail.gmail.com>
 <CAG-rBihBkTeZR6yMSF+5zg-h1U1pxGuN-nv=Y7DXLvxV435hDw@mail.gmail.com>
 <CACT4zj_84eCYOq56zdqaydaEGqyqBrXDrsTkDRyCntvVF78-0A@mail.gmail.com>
 <CAG-rBigLPfJ6u5LQZ4FwMMm_h3b5fQiRYFkwNjFHm4cDCN1VRw@mail.gmail.com> <CACT4zj_fVyz2oCw6aw7TLmyfZ04WcPeZmwSr79TdWsSP435xoQ@mail.gmail.com>
In-Reply-To: <CACT4zj_fVyz2oCw6aw7TLmyfZ04WcPeZmwSr79TdWsSP435xoQ@mail.gmail.com>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Wed, 30 Aug 2023 20:42:23 -0400
Message-ID: <CAG-rBiikaMaMbaOgQ9LH4x0LK8T6+m+8p_9ZSyYiRxHUTxn75Q@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix
 SoCs can suspend
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        skardach@google.com, adrian.hunter@intel.com,
        SeanHY.chen@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        jasonlai.genesyslogic@gmail.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, reniuschengl@gmail.com,
        stable@vger.kernel.org, ulf.hansson@linaro.org,
        victor.shih@genesyslogic.com.tw, victorshihgli@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Aug 30, 2023 at 8:34=E2=80=AFPM Ben Chuang <benchuanggli@gmail.com>=
 wrote:
>
> Understood, I accept your suggestion.
>

Thanks so much for the detailed review, much appreciated !
I shall be posting a v3 later this week. I look forward to Genesys's
review and/or Acked-by.
