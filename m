Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AF3C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Nov 2021 12:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbhK3MSZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 30 Nov 2021 07:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhK3MSZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Nov 2021 07:18:25 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBA9C061574
        for <linux-mmc@vger.kernel.org>; Tue, 30 Nov 2021 04:15:06 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id j18so27499499ljc.12
        for <linux-mmc@vger.kernel.org>; Tue, 30 Nov 2021 04:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hiIkem+B6QCrT12bPKvlDSMsTIjxibXAHl60Tbjdc3Q=;
        b=uzqKHXtoaAyJumpL/n/Cx8CHKQGfzmg8dH/Ec7KIPaCYiyMlV3E3ex6prLC5wgnvwE
         Cl1Vhtr2xyAfQCoRqc7toGUPUmJqeKmAS0PW14JBzNQZqxZJdO6yQAM+2IwV3rcLicSh
         0I2SXi/rTAlJXsVvP8lJJWULQ6MclplSwo0BCCehiDgYanpTXW+1/qexjZvNd/wWQcVm
         tLIksQHCVv398cTe0Coewb2btpnP3QkrivuoGLXBMVQubjQL3AOQWSY4FBHgOnZUfg7k
         8YbV1WkkyTPNilwLODKqaDZQSvQCTGdIzLu2Ww/GKzaFg0fr6QaYqDoJc67M0esjQ77B
         yNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hiIkem+B6QCrT12bPKvlDSMsTIjxibXAHl60Tbjdc3Q=;
        b=MIUOpZ2Br5EVCvacvNWrNgGrsHkr0ljYUmOEByOnhq6uzvRJNOlnjoJEFh6ARC2DTa
         B5FIlCROTAy2NsjygFstcsmqT9i7fBveBvpDnjxf5bA9ltGQzsvffzy8nFJLEWvbXldc
         3aZewxGW+WHK6bzAAf8I0o+5iSZFDXSTv9aAHJ8m9tNh9fJHXowUbeD5h8h46acwkTu8
         wxDxRbBIfq5vQpHQD0MBSYlmXFbx2sPrGEdv94q1c5XMh5Co8W13MaGq68Lf5YIuVd/S
         NPeJ6/uAWItHoVOvZB38lheNFq+RV2chqYRKPPggtSbntc/gW2EGG5wTA9yAXLaiBdwc
         VWAQ==
X-Gm-Message-State: AOAM5333tzt6I4DTm7kRad71hXl5Yt+rtnk08iBb+T9Ds3kL99FKWXTK
        p7QfoV8F+Y8lisCLLX21/iu48FWsIp5jkpXqxHbZxg==
X-Google-Smtp-Source: ABdhPJzBF9KJSuw3VCBnpgv9RMzHA/XYXlR9he66qHKtGKHy78+ax39Qa6+0yME4YOTYQdRFU0Z0k7N20AoCtHUC+60=
X-Received: by 2002:a2e:b6d1:: with SMTP id m17mr54633456ljo.273.1638274504429;
 Tue, 30 Nov 2021 04:15:04 -0800 (PST)
MIME-Version: 1.0
References: <20211116105109.3830-1-oleg@kaa.org.ua> <20211129154826.23595-1-oleg@kaa.org.ua>
 <DM6PR04MB657569E423F95B4151E56C80FC679@DM6PR04MB6575.namprd04.prod.outlook.com>
 <42135dd8-c326-7607-acc9-3d55e9b98dad@kaa.org.ua>
In-Reply-To: <42135dd8-c326-7607-acc9-3d55e9b98dad@kaa.org.ua>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 30 Nov 2021 13:14:28 +0100
Message-ID: <CAPDyKFqrTvV5BSerNwXT4tQNWwFdSZferccdMWGOe_RCC8hkCg@mail.gmail.com>
Subject: Re: [PATCH v4] mmc-utils: Use printf() to extract and print fw version
To:     Oleh Kravchenko <oleg@kaa.org.ua>
Cc:     Avri Altman <avri.altman@wdc.com>, Bean Huo <beanhuo@micron.com>,
        Chris Ball <chrisball@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 30 Nov 2021 at 13:07, Oleh Kravchenko <oleg@kaa.org.ua> wrote:
>
> Hello Avri!
>
> 30.11.21 09:42, Avri Altman =D0=BF=D0=B8=D1=88=D0=B5:
> > Hi,
> >> This patch also fixes a compile error with a newer version of GCC:
> >> error: '__builtin_strncpy' output may be truncated copying 8 bytes fro=
m a
> >> string of length 511 [-Werror=3Dstringop-truncation]
> > You are reverting commit 0eea71e4f2 (mmc-utils: Fix for Firmware Versio=
n string printing).
> > Please use git revert and add an explanation in your commit log.
>
> I'm not reverting this commit.
> It's similar but not.

Right, this time we limit the print to 8 chars, which avoids garbage
from a non-NULL terminated string.

Perhaps we should add (similar to what we do for kernel commits):
Fixes: 0eea71e4f22a ("mmc-utils: Fix for Firmware Version string printing")

[...]

Kind regards
Uffe
