Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B45AC83F3E
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Sep 2023 18:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240423AbjIESS6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 Sep 2023 14:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240422AbjIESSi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Sep 2023 14:18:38 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880363AA1
        for <linux-mmc@vger.kernel.org>; Tue,  5 Sep 2023 11:17:24 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-572a7141434so1725702eaf.2
        for <linux-mmc@vger.kernel.org>; Tue, 05 Sep 2023 11:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693937725; x=1694542525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tt9PKqPXCDGH5CQZjgxSAl72LaGp51mOxNh82fgNfgg=;
        b=ZvmWpeX01mrbexpHZfPwDca8I7dEtVdTfcx2Fgkr1GXaSRNbKWHSJ25QKSaEjJU6A4
         7s/MC8zL0KIeFPWzl3DLP/fWDVdMBLGlFyy1jqQIFjPAlWV7x4j0+AMhjiD7b9SNJPTt
         sZaaT4XOz+xRSLODX57sv79LYOHkCPDg2W568=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693937725; x=1694542525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tt9PKqPXCDGH5CQZjgxSAl72LaGp51mOxNh82fgNfgg=;
        b=IgbPV5vLP46Z580u9AjfuMIYMYJ9rAGGQVfRpk+lfz0W1v0hUR8VUkSgpynsb0QfEH
         ZV9xRpz96JmPn2elUcokcIxAPR86140ESHhu4p45ljPpG35wgh5qayNWf0ZY3UrCfO86
         BG56XMdbESOYldEDSW8OwmK4FwFT6FZabKzJYTTNIB1Z3BVGsV4MS+WvqlGAtJFqjXjo
         +w9yVuNFu5ZEyRz7KAIhsKpGYMF1BXbiyJRpmYUhCv9xzxaGHzZclaEHmQ7kXS/pHZJp
         4SmsYWt3RpM6Y31n2joL6LER+yE4YfagCK3mPT+lwL3mG0xqIJRe8cHV8e7E+3kYXupR
         Oc9A==
X-Gm-Message-State: AOJu0YyYgNUmj+WZi+4BAYVPiDrvfCFyUrSji0vaE/bXxJNPt7uJbyTm
        MDA4xuSsoTx/8ZNPe71KPidecnDprWhGicAlzf/OOw==
X-Google-Smtp-Source: AGHT+IH6wFs61SzfavhRJHdqzadeJsEMO8uYIE8BSkLub8a8wUWtujiulH3kJVHf72S40Tz2pll1hvNVgedDiohHwhA=
X-Received: by 2002:a4a:3416:0:b0:573:bf68:8dbc with SMTP id
 b22-20020a4a3416000000b00573bf688dbcmr12139050ooa.7.1693937725545; Tue, 05
 Sep 2023 11:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230831160055.v3.1.I7ed1ca09797be2dd76ca914c57d88b32d24dac88@changeid>
 <8d88df6b-20c8-cc8e-c08a-e9f09466dc41@intel.com>
In-Reply-To: <8d88df6b-20c8-cc8e-c08a-e9f09466dc41@intel.com>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Tue, 5 Sep 2023 11:15:14 -0700
Message-ID: <CAG-rBig796Yc9iyTiLOLt2R9PW9SoOFtuks3a1usu4XwvkzAOQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix
 SoCs can suspend
To:     ulf.hansson@linaro.org, ben.chuang@genesyslogic.com.tw,
        jasonlai.genesyslogic@gmail.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        jason.lai@genesyslogic.com.tw, skardach@google.com,
        Renius Chen <reniuschengl@gmail.com>,
        rafael.j.wysocki@intel.com, linux-mmc@vger.kernel.org,
        stable@vger.kernel.org, SeanHY.chen@genesyslogic.com.tw,
        victor.shih@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

What do we need for Ulf to add this to the maintainer git? There are
released devices waiting for this fix, but picking from list generates
lots of paperwork, so I'd prefer to pick from git.

We have a LGTM from Jason Lai, do we need one from Ben Chuang as well?

On Mon, Sep 4, 2023 at 3:42=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
