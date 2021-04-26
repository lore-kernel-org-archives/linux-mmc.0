Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF54C433B4
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Apr 2021 09:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 918C761363
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Apr 2021 09:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhDZJhA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Apr 2021 05:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbhDZJg7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Apr 2021 05:36:59 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C196C061574;
        Mon, 26 Apr 2021 02:36:18 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n21so7221398eji.1;
        Mon, 26 Apr 2021 02:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=z9OfI7Gg8z0z7FNzTAb0WQZ6OZrp5p/pY11xr6JmEak=;
        b=LtY+4GWa+gPJ2svm57w5ffrD9eqlgxCDKoAEcGY4NSEtNZKaCTYMcIOv/Qj5tq/hju
         PUpBoPpLl+RMj3WzUmaehVmqEQsdMMaCtArV5P3i3TZekW8c5KhzmjQOz2bd+oateLPK
         5Xzq1THHEAZdnKqtMGtiPA94T4NEZsjHPdBgLz5/SC2EncFdrsGF6IZU6C/0yyqdiVH0
         dRQvz08GiQdv6vo6yoxJEqI4tE7FtrBA3S3te1p9naPx+os3Zl8p/U3fcU7fmTqpwH0O
         bMYi/VFjGCzzpyog4Och8f4/mWPQtrMeZeZGuxNG6DHPElKPtdMRGdtwgnsnfzxq6KUe
         B5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=z9OfI7Gg8z0z7FNzTAb0WQZ6OZrp5p/pY11xr6JmEak=;
        b=C94S1iNxSgVNVCJIJfyZtSHpiS4fsqK2F08OocPKcOsPVELI5vVJXW1A4szCXlzQIg
         IgkIn6opwvCWFwN0EQKbqVT8SLo/s557/w8ydORgwwPzYKcTWc/mwmk7a6mL4bi6hDnU
         c28CNJi3vSpJv/yv5FC+M5DSg1Gj9PYV2AwFTzlVWh3vVTKwWfHR8w5UFD5J4Hs1CaX4
         fuhWANgVZdG6c4Qpjv6n9HEuIWtvDwfhFFXcV2jKy7aMxnwhmnGqmiKKzd67nfpKxbOE
         jBYieFw8qc3zPknd5lRzHvu+1gDFte/b3txdxFuULf6PrnWOHZ5oejDqHjBKZJQ9+m3q
         fPog==
X-Gm-Message-State: AOAM533d6prQzqTcC0j724ygwboOoBdKLU7wi+jRFgJ/5GZ3J/gEPZWG
        scXyt+8iQmXCVIe1qDhRfvg=
X-Google-Smtp-Source: ABdhPJxnCx9QHe/B4XTJXqdM2K58vPYypO29YzrRVPEdHIir1aXHX2bUyGXZ/K62pLLHSwikGCSB/Q==
X-Received: by 2002:a17:906:b191:: with SMTP id w17mr17828574ejy.200.1619429777239;
        Mon, 26 Apr 2021 02:36:17 -0700 (PDT)
Received: from ubuntu-laptop (ip5f5bec5d.dynamic.kabel-deutschland.de. [95.91.236.93])
        by smtp.googlemail.com with ESMTPSA id r18sm11155609ejd.106.2021.04.26.02.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 02:36:16 -0700 (PDT)
Message-ID: <4140ef6b0fa84a5096a697ce4afea51b16e53045.camel@gmail.com>
Subject: Re: [PATCH RESEND v3] mmc-utils: Re-submit of the erase command
 addition plus remval of MMC_IOC_MULTI_CMD ifndef for erase. Re-committing
 the change per request by Avir.
From:   Bean Huo <huobean@gmail.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "luserhker@gmail.com" <luserhker@gmail.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "kenny.gibbons@oracle.com" <kenny.gibbons@oracle.com>,
        "kimito.sakata@oracle.com" <kimito.sakata@oracle.com>,
        "rkamdar@micron.com" <rkamdar@micron.com>,
        "chris@printf.net" <chris@printf.net>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kimito Sakata <ksakata@Kimitos-MBP.hsd1.co.comcast.net>
Date:   Mon, 26 Apr 2021 11:36:15 +0200
In-Reply-To: <DM6PR04MB6575ABF56616177093F75D80FC459@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210422161255.4610-1-luserhker@gmail.com>
         <DM6PR04MB657557ACD70FF26950CF0B0AFC459@DM6PR04MB6575.namprd04.prod.outlook.com>
         <DM6PR04MB6575ABF56616177093F75D80FC459@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 2021-04-23 at 05:31 +0000, Avri Altman wrote:
> +Bean
> 
> > > From: Kimito Sakata <kimito.sakata@oracle.com>
> > > 
> > > Signed-off-by: Kimito Sakata <
> > > ksakata@Kimitos-MBP.hsd1.co.comcast.net>
> > Hi Kimito,
> > Please use a proper subject and commit log body.
> > If you don't understand the difference between those two - please
> > ask.
> > Also for consistency, you might want to use your oracle mail for
> > your Signed-
> > off-by tag.
> > You need to change your git configs for that.
> Also, can you refer to this patch submitted by Bean - 
> https://www.spinics.net/lists/linux-mmc/msg63582.html
> Are you co-developing this together?
> 
> Thanks,
> Avri
> 
> > Thanks,
> > Avri
> 

Kimito,
If you need my support as before. ping me.

Bean

